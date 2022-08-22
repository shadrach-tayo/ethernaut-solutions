// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.0;

import "forge-std/Test.sol";
import "src/GatekeeperOne/GatekeeperOne.sol";
contract GatekeeperOneTest is Test {
    GatekeeperOne instance;
    GatePassOne attacker;
    
    address player = address(0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266);
    function setUp() public {
        instance = new GatekeeperOne();
        attacker = new GatePassOne();
    }

    // use testFail so the test doesn't fail when the attacker.enterGate(_gateAddr, _gas); call reverts in the loop
    function testFailGatePassOne() public { 
        assertTrue(instance.entrant() == address(0));

        vm.startPrank(player);
        
        attacker.enterGate(address(instance), 65782);
        assertEq(instance.entrant(), player);

        vm.stopPrank();
    }
}
