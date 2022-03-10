const main = async () => {
  const domainContractFactory = await hre.ethers.getContractFactory('Domains');
  const domainContract = await domainContractFactory.deploy("anon");
  await domainContract.deployed();
  console.log("Contract deployed to:", domainContract.address);

  let txn = await domainContract.register(
    "not",  
    {value: hre.ethers.utils.parseEther('0.1')}
  );
  await txn.wait();
  console.log("Minted domain not.anon");

  txn = await domainContract.setRecord("bored", "Am I a bored or not anon??");
  await txn.wait();
  console.log("Set record for bored.anon");

  const address = await domainContract.getAddress("bored");
  console.log("Owner of domain bored:", address);

  const balance = await hre.ethers.provider.getBalance(domainContract.address);
  console.log("Contract balance:", hre.ethers.utils.formatEther(balance));
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
