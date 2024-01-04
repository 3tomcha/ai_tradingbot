import { HardhatUserConfig } from "hardhat/config";

import { GOERLI_PRIVATE_KEY, MAINNET_PRIVATE_KEY } from "./keys.config";

const config: HardhatUserConfig = {
  solidity: "0.8.9",
  defaultNetwork: "mainnet",
  networks: {
    hardhat: {
      forking: {
        url: "https://eth-mainnet.g.alchemy.com/v2/EJlARqSMu_HlwPbVinJu2tOqsYAp2oSY",
      },
      allowUnlimitedContractSize: true
    },
    goerli: {
      url: `https://eth-goerli.g.alchemy.com/v2/yJ7nlf6NKvqagb4hA3CFl2Ht4msuwljA`,
      accounts: [GOERLI_PRIVATE_KEY]
    },
    mainnet: {
      url: 'https://eth-mainnet.g.alchemy.com/v2/EJlARqSMu_HlwPbVinJu2tOqsYAp2oSY',
      accounts: [MAINNET_PRIVATE_KEY]
    }
  }
};

export default config;