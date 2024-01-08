pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/interfaces/IERC20.sol";
import "@uniswap/v3-periphery/contracts/interfaces/ISwapRouter.sol";

enum TradeInstruction {
    BUY,
    SELL
}

enum TokenType {
    USDC,
    WETH
}

interface IStarknetCore {
    function sendMessageToL2(
        uint256 toAddress,
        uint256 selector,
        uint256[] calldata payload
    ) external returns (bytes32);

    function consumeMessageFromL2(
        uint256 fromAddress,
        uint256[] calldata payload
    ) external returns (bytes32);
}

contract AiTradingBot is Ownable {
    ISwapRouter public immutable swapRouter;
    IStarknetCore public immutable starknetCore;
    IERC20 public immutable usdc;
    IERC20 public immutable weth;

    uint256 public l2ContractAddress;

    uint256 public currentAmountUSDC;
    uint256 public currentAmountWEth;

    uint24 public constant poolFee = 3000;

    event executeTrade(TradeInstruction tradeInstruction, uint amount);

    constructor(
        uint256 _l2ContractAddress,
        ISwapRouter _swapRouter,
        IStarknetCore _starknetCore,
        IERC20 _usdc,
        IERC20 _weth,
        address initialOwner
    ) payable Ownable(initialOwner) {
        swapRouter = _swapRouter;
        starknetCore = _starknetCore;

        l2ContractAddress = _l2ContractAddress;

        usdc = _usdc;
        weth = _weth;

        currentAmountUSDC = 0;
        currentAmountWEth = 0;
    }

    function withdrawl(TokenType tokenType, uint amount) external onlyOwner {
        if (tokenType == TokenType.USDC) {
            usdc.transfer(msg.sender, amount);
            currentAmountUSDC -= amount;
        } else if (tokenType == TokenType.WETH) {
            usdc.transfer(msg.sender, amount);
            currentAmountWEth -= amount;
        }
    }

    function receiveInstruction(
        TradeInstruction instruction,
        uint amount
    ) external onlyOwner {
        uint256[] memory payload = new uint256[](2);
        payload[0] = instruction == TradeInstruction.BUY ? 0 : 1;
        payload[1] = amount;

        starknetCore.consumeMessageFromL2(l2ContractAddress, payload);

        // if (instruction == TradeInstruction.BUY) {
        //     buyWEth(amount);
        // } else if (instruction == TradeInstruction.SELL) {
        //     // sellWEth(amount);
        // }

        emit executeTrade(instruction, amount);
    }

    function buyWEth(uint amount) private {
        usdc.approve(address(swapRouter), amount + 100000);
        ISwapRouter.ExactInputSingleParams memory params = ISwapRouter
            .ExactInputSingleParams({
                tokenIn: address(usdc),
                tokenOut: address(weth),
                fee: poolFee,
                recipient: address(this),
                deadline: (block.timestamp + 60 * 500),
                amountIn: amount,
                amountOutMinimum: 0,
                sqrtPriceLimitX96: 0
            });
        currentAmountUSDC -= amount;
        currentAmountWEth += swapRouter.exactInputSingle(params);
    }

    function addFunds(TokenType tokenType, uint amount) external {
        if (tokenType == TokenType.USDC) {
            usdc.transferFrom(msg.sender, address(this), amount);
            currentAmountUSDC += amount;
        }
        if (tokenType == TokenType.WETH) {
            usdc.transferFrom(msg.sender, address(this), amount);
            currentAmountWEth += amount;
        }
    }
}
