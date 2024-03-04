const { ethers, network } = require("hardhat");
async function main() {
  const [deployer] = await ethers.getSigners();

  console.log(
    "Deploying the contract FiveIREToken with the account:",
    deployer.address
  );

  const FiveIREToken = await ethers.getContractFactory("FiveIREToken");
  const fiveIREToken = await FiveIREToken.deploy(deployer.address);

  await fiveIREToken.deployed();

  console.log("FiveIREToken deployed to:", fiveIREToken.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
