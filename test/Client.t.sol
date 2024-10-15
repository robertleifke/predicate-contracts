// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity =0.8.12;

import {Ownable} from "openzeppelin/access/Ownable.sol";
import {MockClient} from "./helpers/MockClient.sol";
import "./helpers/utility/ServiceManagerSetup.sol";
import "forge-std/Test.sol";

contract MockClientTest is ServiceManagerSetup {
    function testServiceManagerIsSet() public {
        assertTrue(address(serviceManager) == address(client.serviceManager()));
    }

    function testOwnerCanSetPolicy() public {
        client.setPolicy("testpolicy99");
        assertEq(client.policyID(), "testpolicy99");
    }

    function testRandomAccountCannotSetPolicy() public {
        vm.expectRevert();
        vm.prank(address(44));
        client.setPolicy("testpolicy12345");
    }

    function testRandomAccountCannotCallConfidentialFunction() public {
        vm.expectRevert();
        vm.prank(address(44));
        client.incrementCounter();
    }

    function testServiceManagerCanCallConfidentialFunction() public {
        vm.prank(address(serviceManager));
        client.incrementCounter();
    }
}