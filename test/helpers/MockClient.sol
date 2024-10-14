// SPDX-License-Identifier: MIT

pragma solidity =0.8.12;

import {PredicateClient} from "../../src/mixins/PredicateClient.sol";
import {Ownable} from "openzeppelin/access/Ownable.sol";
import "forge-std/console.sol";

contract MockClient is PredicateClient {
    uint256 public counter;

    constructor(
        address _serviceManager
    ) {
        setServiceManager(_serviceManager);
    }

    function incrementCounter() external onlyPredicateServiceManager {
        counter++;
    }

    fallback() external payable {
        revert("");
    }

    receive() external payable {
        revert("");
    }
}
