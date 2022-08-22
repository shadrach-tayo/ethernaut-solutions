// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.0;

import "forge-std/Test.sol";
import "src/Reentrance.sol";
contract ReentranceTest is Test {
    Reentrance instance;
    Attacker attacker;

    function setUp() public {
        instance = new Reentrance();
        attacker = new Attacker(address(instance));

        address(instance).call.value(5 ether)("");
    }

    function testReentrance() public {
        assertEq(address(instance).balance, 5 ether);
        assertEq(address(attacker).balance, 0);

        attacker.attack.value(1 ether)();

        assertEq(address(instance).balance, 0);
        assertEq(address(attacker).balance, 6 ether);
    }
}
