import { HardhatUserConfig } from "hardhat/config";
import 'dotenv/config'
import '@nomiclabs/hardhat-ethers';
import "@nomicfoundation/hardhat-toolbox";

const config: HardhatUserConfig = {
  solidity: "0.8.20",
  defaultNetwork: "goerli",
  networks: {
    hardhat: {
      forking: {
        url: "https://eth-mainnet.g.alchemy.com/v2/EJlARqSMu_HlwPbVinJu2tOqsYAp2oSY",
      },
      allowUnlimitedContractSize: true
    },
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