// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.0;

import "forge-std/Test.sol";

import "src/Telephone.sol";
contract TelePhoneTest is Test {
    address sender = 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266;
    function setUp() public {}

    function testAttackTelephone() public {
       Telephone phone = new Telephone();
       AttackTelephone attacker = new AttackTelephone(address(phone));
       address currentOwner = phone.owner();
       emit log_named_address("currentOwner", currentOwner);

       vm.startPrank(sender);
       attacker.attackTelephone(sender);
       address newOwner = phone.owner();
       emit log_named_address("newOwner", newOwner);
       assertFalse(newOwner == currentOwner);
       vm.stopPrank();
    }
}
