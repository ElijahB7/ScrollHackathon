require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config(); // To load environment variables from .env file

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.26",
  networks: {
    sepolia: {
      url: "https://scroll-sepolia.g.alchemy.com/v2/43mKUgcLH6NSL6qe1lskxFgmwQxs9N2u", // URL for the Sepolia Scroll node
      accounts: ["b2ac8c38d57072a307707df27360aba96c5496cd06cc3a72487590c4f3bb5812"], // Your wallet's private key
      chainId: 534351 // Make sure this is the correct chain ID for Sepolia Scroll
    }
  },
  etherscan: {
    apiKey: {
      scrollSepolia: '7K9PHY7VXHWHYART7DRRGHH37U2FPUQ6MA',
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
