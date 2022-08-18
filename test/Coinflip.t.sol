// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.0;

import "forge-std/Test.sol";
import "src/CoinFlip/CoinFlip.sol";
contract CoinFlipTest is Test {
    CoinFlip coinFlip;
    AttackCoinFlip attacker;
    function setUp() public {}

    function testCoinFlip() public {
        coinFlip = new CoinFlip();
        attacker = new AttackCoinFlip(address(coinFlip));

        assertEq(coinFlip.consecutiveWins(), 0);
        emit log_named_uint("consecutiveWins", coinFlip.consecutiveWins());

        attacker.attackFlip();
        assertEq(coinFlip.consecutiveWins(), 1);
        emit log_named_uint("consecutiveWins", coinFlip.consecutiveWins());
       
    }
    function testFailCoinFlip() public {
        coinFlip = new CoinFlip();
        attacker = new AttackCoinFlip(address(coinFlip));

        assertEq(coinFlip.consecutiveWins(), 0);
        emit log_named_uint("consecutiveWins", coinFlip.consecutiveWins());

        attacker.attackFlip();
        assertEq(coinFlip.consecutiveWins(), 1);
        emit log_named_uint("consecutiveWins", coinFlip.consecutiveWins());

        // skip(3600);
       
        attacker.attackFlip();
        assertEq(coinFlip.consecutiveWins(), 2);
        emit log_named_uint("consecutiveWins", coinFlip.consecutiveWins());
    }
}
