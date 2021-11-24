# EZMint
A simple NFT contract for testing minting DApps. This code is not autidited and should not be used in production environments.

## Add environment variables
Create a .env file in the project's root directory. It should look like this:
```
API_URL="https://eth-rinkeby.alchemyapi.io/v2/your-api-key"
PRIVATE_KEY="your-private-key"
PUBLIC_KEY="your-public-key"
ETH_SCAN_API_KEY="your-api-Ether-scan-key"
CONTRACT_ADDRESS="your-deployed-contract-address"
```

## Install imported contracts
`npm install @openzeppelin/contracts`

## Compile
`npx hardhat compile`

## Deploy Contract
`npx hardhat run scripts/deploy.js --network rinkeby`

Note down the deployed contract address

## Update scripts
Update the `CONTRACT_ADDRESS` variable in your .env file

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

### Verify contract
`npx hardhat verify --network rinkeby <Contract Address>`