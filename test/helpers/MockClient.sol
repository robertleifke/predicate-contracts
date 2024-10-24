// SPDX-License-Identifier: MIT

pragma solidity =0.8.12;

import {PredicateClient} from "../../src/mixins/PredicateClient.sol";
import {IPredicateManager} from "../../src/interfaces/IPredicateManager.sol";
import {Ownable} from "openzeppelin/access/Ownable.sol";
import "forge-std/console.sol";

contract MockClient is PredicateClient, Ownable {
    uint256 public counter;

    constructor(
        address _serviceManager
    ) {
        setServiceManager(_serviceManager);
        _transferOwnership(msg.sender);
    }

    function incrementCounter() external onlyPredicateServiceManager {
        counter++;
    }

    /**
     * @notice Updates the policy ID
     * @param _policyID policy ID from onchain
     */
    function setPolicy(
        string memory _policyID
    ) external onlyOwner {
        policyID = _policyID;
        serviceManager.setPolicy(_policyID);
    }

    /**
     * @notice Internal function for setting the ServiceManager
     * @param _serviceManager address of the service manager
     */
    function setServiceManager(
        address _serviceManager
    ) public onlyOwner {
        serviceManager = IPredicateManager(_serviceManager);
    }

    fallback() external payable {
        revert("");
    }

    receive() external payable {
        revert("");
    }
}
