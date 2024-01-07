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
    MockUSDC public usdc;
    uint256 initialAmount = 5_000_000;

    function setUp() public {
        address owner = address(this);
        usdc = new MockUSDC("USDC", "USDC", 1000 * 1e6);
        aiTradingBot = new AiTradingBot(
            l2ContractAddress,
            swapRouter,
            starknetCore,
            usdc,
            weth,
            owner
        );
        usdc.approve(address(aiTradingBot), initialAmount);
        aiTradingBot.addFunds(TokenType.USDC, initialAmount);
    }

    function test_SetUp() public {
        assertEq(aiTradingBot.currentAmountUSDC(), initialAmount);
    }
}
