// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "forge-std/Test.sol";

import "src/Force.sol";
contract ForceTest is Test {
    Force force;
    Attack attacker;

    function setUp() public {
        force = new Force();
        attacker = new Attack(address(force));
    }

    function testForce() public {
        uint initialBal = address(force).balance;
        emit log_named_uint("balance before", address(force).balance);

        attacker.attack{value: 1 ether}();

        emit log_named_uint("balance after", address(force).balance);
        assertFalse(initialBal == address(force).balance);
    }

}
