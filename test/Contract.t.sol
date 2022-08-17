// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import "src/Contract.sol";
contract ContractTest is Test, Contract {
    function setUp() public {}

    function testCount() public {
        assertEq(count, 0);
    }

    function testPlus() public {
        plus();
        plus();
        assertEq(count, 2);
    }
}
