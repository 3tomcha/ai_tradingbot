// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "../lib/forge-std/src/Test.sol";
import {AiTradingBot, TokenType, IStarknetCore, IERC20} from "../src/AiTradingBot.sol";
import "@uniswap/v3-periphery/contracts/interfaces/ISwapRouter.sol";
import {MockUSDC} from "../src/MockUSDC.sol";

contract AiTradingBotTest is Test {
    AiTradingBot public aiTradingBot;
    ISwapRouter public immutable swapRouter;
    IStarknetCore public immutable starknetCore;
    IERC20 public immutable weth;

    uint256 l2ContractAddress = 0xF;
    // IStarknetCore uniswapRouter = 0x07865c6E87B9F70255377e024ace6630C1Eaa37F;
    // IERC20 starknetCore = 0x07865c6E87B9F70255377e024ace6630C1Eaa37F;
    // IERC20 usdcAddress = 0x07865c6E87B9F70255377e024ace6630C1Eaa37F;
    // address wethAddress = 0x07865c6E87B9F70255377e024ace6630C1Eaa37F;

    uint256 initialAmount = 5_000_000;

    function setUp() public {
        address owner = address(this);
        MockUSDC usdc = new MockUSDC("USDC", "USDC", 1000 * 1e6);

        aiTradingBot = new AiTradingBot(
            l2ContractAddress,
            swapRouter,
            starknetCore,
            usdc,
            weth,
            owner
        );
        aiTradingBot.addFunds(TokenType.USDC, initialAmount);
    }

    function test_SetUp() public {
        console2.logUint(1);
        // console2.logUint(aiTradingBot.currentAmountUSDC());
        // assertEq(aiTradingBot.currentAmountUSDC(), initialAmount);
    }
}
