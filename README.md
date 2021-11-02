# EZMint
A simple NFT contract for testing minting DApps. This code is not autidited and should not be used in production environments.

## Add environment variables
Create a .env file in the project's root directory. It should look like this:
```
API_URL="https://eth-rinkeby.alchemyapi.io/v2/your-api-key"
PRIVATE_KEY="your-private-key"
PUBLIC_KEY="your-public-key"
```

## Install imported contracts
`npm install @openzeppelin/contracts`

## Compile
`npx hardhat compile`

## Deploy Contract
`npx hardhat run scripts/deploy.js --network rinkeby`

Note down the deployed contract address

## Update scripts
Update the `contractAddress` variable for the following scripts:

- scripts/toggle-active.js
- scripts/add-whiteliest.js (also need to update new_address)
- scripts/default-uri.js
- scripts/mint-nft.js

## Set default URI
Set the `uri` variable in `scripts/default-uri.js` with the uri to a default NFT metadata .json file

`node scripts/default-uri.js `

## Set minting to active
`node scripts/toggle-active.js`

## Mint token
`node scripts/mint-nft.js`

## Optional: 
### Stop/pause mint
`node scripts/toggle-active.js`

### Add whitelisted address to allow some administrative functions
`node scripts/add-whitelisted.js`