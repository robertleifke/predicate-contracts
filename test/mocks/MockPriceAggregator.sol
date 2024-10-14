// SPDX-License-Identifier: BUSL-1.1
pragma solidity =0.8.12;

import {IPriceAggregator} from "../../src/interfaces/IPriceAggregator.sol";

contract MockPriceAggregator is IPriceAggregator {
    mapping(string => uint256) public prices;

    function setPrice(string calldata tokenID, uint256 price) external {
        prices[tokenID] = price;
    }

    function getPrice(string calldata tokenID, uint256 amountIn) external view override returns (uint256) {
        require(prices[tokenID] != 0, "MockPriceAggregator: token not supported");
        require(amountIn > 0, "MockPriceAggregator: amountIn must be greater than 0");
        return prices[tokenID];
    }

    function assetToAsset(
        address tokenIn,
        uint256 amountIn,
        address tokenOut,
        uint256 twapPeriod
    ) external pure override returns (uint256 amountOut) {
        (tokenIn, amountIn, tokenOut, twapPeriod);
        return 0;
    }

    function isTokenSupported(
        string calldata tokenID
    ) external view override returns (bool) {
        return prices[tokenID] != 0;
    }
}
