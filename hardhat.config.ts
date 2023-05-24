import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import dotenv from "dotenv";
dotenv.config();

const ETHERSCAN_API_KEY = process.env.ETHERSCAN_API_KEY;
const POLYGONSCAN_API_KEY = process.env.POLYGONSCAN_API_KEY;
const ACCOUNT_PRIVATE_KEY_DEV = process.env.ACCOUNT_PRIVATE_KEY_DEV ?? "";
const ACCOUNT_PRIVATE_KEY_MAIN = process.env.ACCOUNT_PRIVATE_KEY_MAIN ?? "";

//dev
const ALCHEMY_API_KEY_GOERIL = process.env.ALCHEMY_API_KEY_GOERIL;

//main
const ALCHEMY_API_KEY_MAIN = process.env.ALCHEMY_API_KEY_MAIN;

//mumbai
const ALCHEMY_API_KEY_POLYGON = process.env.ALCHEMY_API_KEY_POLYGON;

//mumbai
const ALCHEMY_API_KEY_MUMBAI = process.env.ALCHEMY_API_KEY_MUMBAI;

//sepolia
const ALCHEMY_API_KEY_SEPOLIA = process.env.ALCHEMY_API_KEY_SEPOLIA;

const config: HardhatUserConfig = {
  solidity: "0.8.17",
  networks: {
    // goerli: {
    //   url: `https://eth-goerli.alchemyapi.io/v2/${ALCHEMY_API_KEY_GOERIL}`,
    //   accounts: [ACCOUNT_PRIVATE_KEY_DEV],
    // },
    // sepolia: {
    //   url: `https://eth-sepolia.g.alchemy.com/v2/${ALCHEMY_API_KEY_SEPOLIA}`,
    //   accounts: [ACCOUNT_PRIVATE_KEY_MAIN],
    // },
    // mainnet: {
    //   url: `https://eth-mainnet.g.alchemy.com/v2/${ALCHEMY_API_KEY_MAIN}`,
    //   accounts: [ACCOUNT_PRIVATE_KEY_DEV],
    // },
    // mumbai: {
    //   url: `https://polygon-mumbai.g.alchemy.com/v2/${ALCHEMY_API_KEY_MUMBAI}`,
    //   accounts: [ACCOUNT_PRIVATE_KEY_DEV],
    // },
    polygon: {
      url: `https://polygon-mainnet.g.alchemy.com/v2/${ALCHEMY_API_KEY_POLYGON}`,
      accounts: [ACCOUNT_PRIVATE_KEY_MAIN],
    },
  },
  etherscan: {
    apiKey: { polygon: POLYGONSCAN_API_KEY ?? "" },
  },
};

export default config;
