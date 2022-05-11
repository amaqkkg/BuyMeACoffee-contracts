const hre = require("hardhat");

async function main() {
  // Get example accounts
  const [owner, tipper, tipper2, tipper3] = await hre.ethers.getSigners();

  // Get the contract to deploy & deploy
  const BuyMeACoffee = await hre.ethers.getContractFactory("BuyMeACoffee");
  const buyMeACoffee = await BuyMeACoffee.deploy();
  await buyMeACoffee.deployed;
  console.log("BuyMeACoffee deployed to ", buyMeACoffee.address);

  // check addresses
  console.log(`owner: ${owner.address}`);
  console.log(`tipper: ${tipper.address}`);

  // change the owner
  const addresses = [owner.address, tipper.address, buyMeACoffee.address];
  console.log(`current owner ${owner.address}`);
  console.log("=== change owner ===");
  await buyMeACoffee.connect(owner).changeOwner(tipper.address);
  const newOwner = await buyMeACoffee.currentOwner();
  console.log(`current owner ${newOwner}`);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
