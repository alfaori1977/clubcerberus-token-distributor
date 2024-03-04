const { ethers, network } = require("hardhat");
async function main() {
  const [deployer] = await ethers.getSigners();
  const TokenDistributor = await ethers.getContractFactory("TokenDistributor");
  const tokenDistributor = await TokenDistributor.deploy(deployer.address);

  console.log("TokenDistributor deployed to:", tokenDistributor.address);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
