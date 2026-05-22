const hre = require("hardhat");

async function main() {

    const contractAddress = "PASTE_CONTRACT_ADDRESS";

    const contract = await hre.ethers.getContractAt(
        "CourseRewardSystem",
        contractAddress
    );

    const tx = await contract.setRewardAmount(
        hre.ethers.parseEther("2")
    );

    await tx.wait();

    console.log("Reward updated");
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});
