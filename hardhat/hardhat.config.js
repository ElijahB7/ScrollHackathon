require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config(); // To load environment variables from .env file

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.26",
  networks: {
    sepolia: {
      url: "https://scroll-sepolia.g.alchemy.com/v2/ALCHEMYAPIKEY", // URL for the Sepolia Scroll node
      accounts: ["ADD PRIVATE KEY"], // Your wallet's private key
      chainId: 534351 // Make sure this is the correct chain ID for Sepolia Scroll
    }
  },
  etherscan: {
    apiKey: {
      scrollSepolia: 'ADD SEPOLIA SCAN KEY',
    },
    customChains: [
      {
        network: 'scrollSepolia',
        chainId: 534351,
        urls: {
          apiURL: 'https://api-sepolia.scrollscan.com/api',
          browserURL: 'https://sepolia.scrollscan.com/',
        },
      },
    ],
  },
}
