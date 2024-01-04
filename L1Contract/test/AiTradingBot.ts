import { describe } from "node:test";
import { ethers } from "hardhat";

describe("AI Trading Bot", () => {
  it("Should be able to deploy the contract", async () => {
    const AiTradingBot = await ethers.getContractFactory("AiTradingBot");
    const aiTradingBot = await AiTradingBot.deploy();
    // await aiTradingBot.deployed();
    console.log("AiTradingBot deployed to:", aiTradingBot.address);
  });
});