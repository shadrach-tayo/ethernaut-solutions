// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract Contract {
  uint256 public count = 0;

  function plus() public {
    count += 1;
  }
  function minus() public {
    count -= 1;
  }
}
