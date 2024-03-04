require("dotenv").config();
require("@nomiclabs/hardhat-ethers");
require("@nomiclabs/hardhat-etherscan");

console.log("Deployer private key:", process.env.DEPLOYER_PRIVATE_KEY);
module.exports = {
  solidity: "0.8.24",
  etherscan: {
    // Your API key for Etherscan
    // Obtain one at https://etherscan.io/myapikey

    apiKey: "ACIG3PFRP7VAN56V78PZKS7N8GMNB3B2X4",
  },
  networks: {
    hardhat: {},
    localhost: {},
    bscTestnet: {
      allowUnlimitedContractSize: false,
      url: "https://bsc-testnet.public.blastapi.io",
      chainId: 97,
      gasPrice: 5000000000,
      accounts: [`0x${process.env.DEPLOYER_PRIVATE_KEY}`],
    },
  },
};
