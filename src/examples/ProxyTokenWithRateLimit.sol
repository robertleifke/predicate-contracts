// SPDX-License-Identifier: MIT
pragma solidity ^0.8.12;

import {Ownable} from "openzeppelin/access/Ownable.sol";
import {RateLimiter} from "../mixins/RateLimiter.sol";

contract ProxyTokenWithRateLimit is RateLimiter {
    address private proxyToken;

    constructor(address _owner, address _proxyToken) {
        transferOwnership(_owner);
        proxyToken = _proxyToken;
    }

    function simulateTransfer(
        uint256 amount
    ) external {
        if (!this.evaluateRateLimit(proxyToken, amount)) {
            revert("ProxyTokenWithRateLimit: rate limit exceeded");
        }
    }

    function setProxyToken(
        address _proxyToken
    ) public onlyOwner {
        proxyToken = _proxyToken;
    }

    function getProxyToken() external view returns (address) {
        return proxyToken;
    }
}
