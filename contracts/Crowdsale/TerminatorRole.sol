pragma solidity ^0.5.2;

import "openzeppelin-solidity/contracts/ownership/Ownable.sol";

contract TerminatorRole is Ownable {
  address private _terminationManger;

  modifier onlyTerminator() {
    require(msg.sender == _terminationManger, "you are not permitted");
    _;
  }

  function setTerminatationManager(address terminationManager) public onlyOwner {
    _terminationManger = terminationManager;
  }
}