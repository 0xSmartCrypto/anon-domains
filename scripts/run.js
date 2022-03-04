const main = async () => {
  const [owner, randomPerson] = await hre.ethers.getSigners();
  const domainContractFactory = await hre.ethers.getContractFactory('Domains');
  const domainContract = await domainContractFactory.deploy("anon");
  await domainContract.deployed();
  console.log("Contract deployed to:", domainContract.address);
  console.log("Contract deployed by:", owner.address);
  
  const txn = await domainContract.register(
    "not", 
    { value: hre.ethers.utils.parseEther("0.1") }
  );
  await txn.wait();

  const domainOwner = await domainContract.getAddress("super");
  console.log("Owner of domain super.anon:", domainOwner);

  const balance = await hre.ethers.provider.getBalance(domainContract.address);
  console.log("Balance of domain contract:", hre.ethers.utils.formatEther(balance));
}

const runMain = async () => {
  try {
    await main();
    process.exit(0);
  } catch (error) {
    console.log(error);
    process.exit(1);
  }
};

runMain();
