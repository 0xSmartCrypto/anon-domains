# .anon domains (with Hardhat)

The main contract `Domains.sol` lets you create and manage .anon domains.

Using ERC721 libraries from OpenZeppelin, this contract mints the .anon domains as NFTs, visible on compatible NFT marketplaces (e.g. OpenSea).

The NFT is generated as an SVG, with the newly minted domain string embedded in the image.

The contract makes use of:
- Custom errors (e.g. `UnAuthorized`, `AlreadyRegistered` etc) to save gas
- Depending on domain length, charge users different prices
- Withdrawl function is available to the contract deployer (owner)

# Deploy to local

- Edit `./scripts/run.js` to your liking
- Run `npm run local`

# Deploy to Polygon (Mumbai Testnet)

- Edit `./scripts/deploy.js` to your liking
- Run `npm run mumbai`
# Misc

The following tasks are available:

```shell
npx hardhat accounts
npx hardhat compile
npx hardhat clean
npx hardhat test
npx hardhat node
node scripts/sample-script.js
npx hardhat help
```
