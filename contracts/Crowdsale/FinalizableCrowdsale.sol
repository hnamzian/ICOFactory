pragma solidity "0.5.2";

import "./BasicCrowdsale.sol";
import "./TerminatorRole.sol";

contract FinalizableCrowdsale is BasicCrowdsale, TerminatorRole {
  // defines Crowdsale state:
  // Running: open to purchase
  // Refunding: closed and invests must be refunded
  // Finalized: closed and fund raised successfully 
  enum State {Running, Refunding, Terminated, Finalized}
  State internal state;

  constructor() public {
    state = State.Running;
  }

  function terminateProject() public onlyTerminator {
    if (state == State.Finalized) state = State.Terminated;
  }
  
  function finalize() public onlyOwner {
    _finalize();
  }

  function _finalize() internal {
    if (_etherRaised > _hardcap) state = State.Finalized;
    else if (isSalesClosed()) {
      if (_etherRaised >= _softcap) state = State.Finalized;
      else state = State.Refunding;
    }
  }

  function isFinalized() public view returns (bool) {
    return state == State.Finalized ? true : false;
  }
}