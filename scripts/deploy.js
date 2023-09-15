async function main() {
  // const [deployer] = await ethers.getSigners();

  // console.log(deployer,"Deploying contracts with the account:", deployer.address);

  const token = await ethers.deployContract("OceanToken");

  console.log(token,"Token address:", await token.getAddress());
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
  /////////////////////token address/////////////////////

  //sepolia   0xdb718024eBcb8217715F6A9531c1B8b8B2eC3523
  //ganache 0xFd738477Af8ecd8eA25662f8Bf004D04a0eA34E7