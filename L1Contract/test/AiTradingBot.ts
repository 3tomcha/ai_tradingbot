import { AiTradingBot__factory } from './../typechain-types/factories/contracts/AiTradingBot.sol/AiTradingBot__factory';
import { SimpleERC20__factory } from './../typechain-types/factories/contracts/USDC.sol/SimpleERC20__factory';
import { expect } from "chai";
import { ethers } from "hardhat";

describe("AI Trading Bot", () => {
  const deployFixture = async () => {
    const [owner, otherAccount] = await ethers.getSigners();
    const aiTradingBot__factory = new AiTradingBot__factory();
    const l2ContractAddress = 0xF;
    const uniswapRouter = "0x68b3465833fb72A70ecDF485E0e4C7bD8665Fc45";
    const starknetCore = "0xde29d060D45901Fb19ED6C6e959EB22d8626708e";
    const usdcAddress = "0x07865c6e87b9f70255377e024ace6630c1eaa37f";
    const wethAddress = "0xB4FBF271143F4FBf7B91A5ded31805e42b2208d6";
    const initialAmount = 5_000_000;

    const usdc = SimpleERC20__factory.connect(usdcAddress, owner);
    const aiTradingBot = await aiTradingBot__factory.connect(owner).deploy(l2ContractAddress, uniswapRouter, starknetCore, usdcAddress, wethAddress, owner)
    console.log("deployed");
    await usdc.connect(owner).approve(aiTradingBot.getAddress(), initialAmount + 500)

    // await usdc__factory.connect(usdcAddress, owner).approve()

    return {
      aiTradingBot,
      owner
    }
  }

  describe("Deployement", async () => {
    it("should be right owner", async () => {
      const { aiTradingBot, owner } = await deployFixture();
      expect(await aiTradingBot.owner()).to.equal(owner.address)
    })
    it("should be right amount", async () => {
      const { aiTradingBot, owner } = await deployFixture();
    })
  })
});