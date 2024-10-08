import { ethers } from "hardhat";

async function main() {
  const NFTExchange = await ethers.getContractFactory("NFTExchange");
  const depolyedContract = await NFTExchange.deploy();

  await depolyedContract.deployed();

  console.log(`deployed to ${depolyedContract.address}`);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
