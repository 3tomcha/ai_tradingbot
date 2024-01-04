pragma solidity ^0.8.20;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/interfaces/IERC20.sol";
import "@uniswap/v3-periphery/contracts/interfaces/ISwapRouter.sol";

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
    // function withdrawl() {}
}
