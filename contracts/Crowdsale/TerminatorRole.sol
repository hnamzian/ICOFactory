pragma solidity ^0.5.2;

import "openzeppelin-solidity/contracts/ownership/Ownable.sol";

contract TerminatorRole is Ownable {
  address private _terminator;

  modifier onlyTerminator() {
    require(msg.sender == _terminator, "you are not permitted");
    _;
  }

  function setTerminatationManager(address terminator) public onlyOwner {
    _terminator = terminator;
  }
}