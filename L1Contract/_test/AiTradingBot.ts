import { AiTradingBot__factory } from '../typechain-types/factories/contracts/AiTradingBot.sol/AiTradingBot__factory';
import { SimpleERC20__factory } from '../typechain-types/factories/contracts/USDC.sol/SimpleERC20__factory';
import { expect } from "chai";
import { ethers } from "hardhat";

// local
describe("AI Trading Bot", () => {
  const deployFixture = async () => {
    const [owner, otherAccount] = await ethers.getSigners();

    const l2ContractAddress = 0xF;
    const uniswapRouter = "0x68b3465833fb72A70ecDF485E0e4C7bD8665Fc45";
    const starknetCore = "0xde29d060D45901Fb19ED6C6e959EB22d8626708e";
    const wethAddress = "0xB4FBF271143F4FBf7B91A5ded31805e42b2208d6";
    const initialAmount = 5_000_000;

    const aiTradingBot__factory = new AiTradingBot__factory();
    const usdc__factory = new SimpleERC20__factory();
    const usdc = await usdc__factory.connect(owner).deploy("USDC", "USDC", initialAmount);
    const usdcAddress = await usdc.getAddress();
    const aiTradingBot = await aiTradingBot__factory.connect(owner).deploy(l2ContractAddress, uniswapRouter, starknetCore, usdcAddress, wethAddress, owner)
    const aiTradingBotAddress = await aiTradingBot.getAddress()

    await usdc.connect(owner).approve(aiTradingBotAddress, initialAmount + 500)
    await aiTradingBotAddress.connect(owner).addFunds(initialAmount);

    return {
      aiTradingBot,
      owner,
      usdc,
      initialAmount,
      aiTradingBotAddress
    }
  }

  describe("Deployement", async () => {
    it("should be right owner", async () => {
      const { aiTradingBot, owner } = await deployFixture();
      expect(await aiTradingBot.owner()).to.equal(owner.address)
    })
    it("should be right amount", async () => {
      const { aiTradingBot, owner, usdc, initialAmount, aiTradingBotAddress } = await deployFixture();
      expect(await usdc.balanceOf(aiTradingBotAddress)).to.equal(initialAmount);
    })
  })
});