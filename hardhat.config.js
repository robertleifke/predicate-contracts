/** @type import('hardhat/config').HardhatUserConfig */
require("@nomicfoundation/hardhat-toolbox");
require("@nomicfoundation/hardhat-foundry");
module.exports = {
  solidity: {
    compilers: [
      {
        version: "0.8.12",
        settings: {
          optimizer: {
            enabled: true,
            runs: 400,
            details: { yul: false },
          }
        }
      }
    ]
  },
  // remappings: [
  //   "forge-std/=lib/forge-std/src/",
  //   "openzeppelin/=lib/openzeppelin-contracts/contracts/",
  //   "solmate/=lib/solmate/src/",
  //   "openzeppelin-upgradeable/=lib/openzeppelin-contracts-upgradeable/contracts/",
  //   "eigenlayer-contracts/=lib/eigenlayer-contracts/",
  //   "utils/=lib/utils/",
  //   "@uniswap/v3-core/=lib/v3-core/",
  //   "@uniswap/v3-periphery/=lib/v3-periphery/"
  // ],
};
