// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Contract.sol";

contract ContractTest is Test {
    Contract drop;
    address testAddr = makeAddr("Test");

    function setUp() public {
        drop = new Contract(testAddr, "Test-Contract", "TC", testAddr, 500, testAddr);
    }

    function testDropWithZeroTokens() public {
        vm.expectRevert("You must input an amount > 0");
        drop.mint(testAddr, 0);
    }
}
