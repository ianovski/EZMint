/**
* @type import('hardhat/config').HardhatUserConfig
*/
require("dotenv").config()
require("@nomiclabs/hardhat-ethers");
require("@nomiclabs/hardhat-etherscan");
const API_URL = process.env.API_URL
const PRIVATE_KEY = process.env.PRIVATE_KEY
const ETH_SCAN_API_KEY = process.env.ETH_SCAN_API_KEY
module.exports = {
   solidity: "0.8.0",
   networks: {
      hardhat: {},
      rinkeby: {
         url: API_URL,
         accounts: [`0x${PRIVATE_KEY}`]
      }
   },
   etherscan: {
      // Your API key for Etherscan
      // Obtain one at https://etherscan.io/
      apiKey: ETH_SCAN_API_KEY
    }
   
}
