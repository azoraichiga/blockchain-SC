const hre = require("hardhat");

async function main() {

    const Factory = await hre.ethers.getContractFactory(
        "CourseRewardSystem"
    );

    const contract = await Factory.deploy(
        hre.ethers.parseEther("1"),
        7
    );

    await contract.waitForDeployment();

    console.log(
        "Contract deployed to:",
        await contract.getAddress()
    );
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});
