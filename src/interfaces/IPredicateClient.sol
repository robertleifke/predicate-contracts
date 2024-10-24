// SPDX-License-Identifier: MIT

pragma solidity ^0.8.12;

struct PredicateMessage {
    string taskId;
    uint256 expireByBlockNumber;
    address[] signerAddresses;
    bytes[] signatures;
}

interface IPredicateClient {
    /**
     * @notice Sets a policy for the calling address, associating it with a policy document stored on IPFS.
     * @param _policyID A string representing the policyID from on chain.
     * @dev This function enables clients to define execution rules or parameters for tasks they submit.
     *      The policy governs how tasks submitted by the caller are executed, ensuring compliance with predefined rules.
     */
    function setPolicy(
        string memory _policyID
    ) external;
}
