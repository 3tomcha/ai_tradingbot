import { HardhatUserConfig } from "hardhat/config";
import 'dotenv/config'
import "@nomicfoundation/hardhat-toolbox";
import '@typechain/hardhat'
import '@nomicfoundation/hardhat-ethers'
import '@nomicfoundation/hardhat-chai-matchers'

const config: HardhatUserConfig = {
  solidity: "0.8.20",
  defaultNetwork: "hardhat",
  typechain: {
    outDir: "typechain-types",
    target: "ethers-v6"
  },
  networks: {
    goerli: {
      url: `https://eth-goerli.g.alchemy.com/v2/yJ7nlf6NKvqagb4hA3CFl2Ht4msuwljA`,
      accounts: [String(process.env.GOERLI_PRIVATE_KEY)]
    },
    mainnet: {
      url: 'https://eth-mainnet.g.alchemy.com/v2/EJlARqSMu_HlwPbVinJu2tOqsYAp2oSY',
      accounts: [String(process.env.MAINNET_PRIVATE_KEY)]
    }
  }
};

export default config;