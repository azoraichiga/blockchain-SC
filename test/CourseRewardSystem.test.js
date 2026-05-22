const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("CourseRewardSystem", function () {

  let contract;
  let owner;
  let student1;
  let student2;

  beforeEach(async function () {

    [owner, student1, student2] = await ethers.getSigners();

    const Factory = await ethers.getContractFactory("CourseRewardSystem");

    contract = await Factory.deploy(
      ethers.parseEther("1"),
      7
    );

    await contract.waitForDeployment();

    await contract.depositFunds({ value: ethers.parseEther("10") });
  });

  it("Should set correct owner", async function () {
    expect(await contract.owner()).to.equal(owner.address);
  });

  it("Should whitelist student", async function () {

    await contract.whitelistStudent(student1.address);

    expect(
      await contract.whitelist(student1.address)
    ).to.equal(true);
  });

  it("Should allow reward claim", async function () {

    await contract.whitelistStudent(student1.address);

    await contract.connect(student1).claimReward();

    expect(
      await contract.hasClaimed(student1.address)
    ).to.equal(true);
  });

  it("Should prevent double claim", async function () {

    await contract.whitelistStudent(student1.address);

    await contract.connect(student1).claimReward();

    await expect(
      contract.connect(student1).claimReward()
    ).to.be.revertedWith("Reward already claimed");
  });

});
