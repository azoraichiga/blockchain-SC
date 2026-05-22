// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @custom:dev-run-script scripts/deploy.js
contract CourseRewardSystem {

    address public owner;
    uint256 public rewardAmount;
    uint256 public claimDeadline;

    mapping(address => bool) public hasClaimed;
    mapping(address => bool) public whitelist;
    mapping(address => uint256) public rewardTier;

    event RewardClaimed(address indexed student, uint256 amount);
    event RewardAmountChanged(uint256 newAmount);
    event StudentWhitelisted(address indexed student);
    event RewardTierSet(address indexed student, uint256 amount);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this");
        _;
    }

    modifier beforeDeadline() {
        require(block.timestamp <= claimDeadline, "Claim deadline passed");
        _;
    }

    constructor(uint256 _rewardAmount, uint256 _durationInDays) {
        owner = msg.sender;
        rewardAmount = _rewardAmount;
        claimDeadline = block.timestamp + (_durationInDays * 1 days);
    }

    function setRewardAmount(uint256 _amount) external onlyOwner {
        rewardAmount = _amount;
        emit RewardAmountChanged(_amount);
    }

    function whitelistStudent(address _student) external onlyOwner {
        whitelist[_student] = true;
        emit StudentWhitelisted(_student);
    }

    function setRewardTier(address _student, uint256 _amount)
        external
        onlyOwner
    {
        rewardTier[_student] = _amount;
        emit RewardTierSet(_student, _amount);
    }

    function claimReward() external beforeDeadline {

        require(whitelist[msg.sender], "Not whitelisted");
        require(!hasClaimed[msg.sender], "Reward already claimed");

        hasClaimed[msg.sender] = true;

        uint256 amount = rewardTier[msg.sender];

        if (amount == 0) {
            amount = rewardAmount;
        }

    
    (bool success, ) = payable(msg.sender).call{value: amount}("");
require(success, "Transfer failed");

        emit RewardClaimed(msg.sender, amount);
    }

    function depositFunds() external payable onlyOwner {}

    function getContractBalance() external view returns(uint256) {
        return address(this).balance;
    }
}
