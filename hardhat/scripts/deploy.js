const hre = require("hardhat");

async function main() {
    // Compile the contract
    await hre.run('compile');

    // Get the contract to deploy
    const YourContract = await hre.ethers.getContractFactory("AdvancedMarketplace");
    const yourContract = await YourContract.deploy();

    // Wait for the contract to be deployed
   // await yourContract.deployed();

    console.log("YourContract deployed to:", yourContract.address);
}

// Run the script
main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });
