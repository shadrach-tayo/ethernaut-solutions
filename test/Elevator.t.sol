// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.0;

import "forge-std/Test.sol";
import "src/Elevator.sol";
contract ElevatorTest is Test {
    Elevator instance;
    AttackElevator attacker;

    function setUp() public {
        instance = new Elevator();
        attacker = new AttackElevator(address(instance));
    }

    function testClimbToTopFloor() public {
        assertTrue(!instance.top());
        assertEq(instance.floor(), 0);

        attacker.climbElevator();
       
        assertTrue(instance.top());
        assertEq(instance.floor(), 1);
        assertTrue(attacker.called());
    }
}
