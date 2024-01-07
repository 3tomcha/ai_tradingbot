// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2, console} from "../lib/forge-std/src/Test.sol";
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
    address owner = address(this);

    function setUp() public {
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
        assertEq(usdc.balanceOf(address(aiTradingBot)), initialAmount);
        assertEq(aiTradingBot.currentAmountUSDC(), initialAmount);
    }

    function test_Transaction() public {
        uint256 newAmount = 5_000_000;
        address otherAccount = vm.addr(2);
        vm.prank(owner);
        usdc.transfer(otherAccount, newAmount);
        vm.prank(otherAccount);
        usdc.approve(address(aiTradingBot), newAmount);
        vm.prank(otherAccount);
        aiTradingBot.addFunds(TokenType.USDC, newAmount);
        assertEq(
            usdc.balanceOf(address(aiTradingBot)),
            initialAmount + newAmount
        );
    }
}
