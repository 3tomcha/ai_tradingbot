// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import {AiTradingBot, TokenType} from "../src/AiTradingBot.sol";

contract AiTradingBotTest is Test {
    AiTradingBot public aiTradingBot;

    address l2ContractAddress = 0xF;
    address uniswapRouter = "0x68b3465833fb72A70ecDF485E0e4C7bD8665Fc45";
    address starknetCore = "0xde29d060D45901Fb19ED6C6e959EB22d8626708e";
    address usdcAddress = "0x07865c6e87b9f70255377e024ace6630c1eaa37f";
    address wethAddress = "0xB4FBF271143F4FBf7B91A5ded31805e42b2208d6";

    uint256 initialAmount = 5_000_000;

    function setUp() public {
        aiTradingBot = new AiTradingBot(
            l2ContractAddress,
            uniswapRouter,
            starknetCore,
            usdcAddress,
            wethAddress
        );
        aiTradingBot.addFunds(TokenType.USDC, initialAmount);
    }

    function test_SetUp() public {
        assertEq(aiTradingBot.currentAmountUSDC, initialAmount);
    }
}
