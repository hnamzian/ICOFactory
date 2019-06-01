pragma solidity "0.5.2";

import "./BasicCrowdsale.sol";

contract FinalizableCrowdsale is BasicCrowdsale {
  // defines Crowdsale state:
  // Running: open to purchase
  // Refunding: closed and invests must be refunded
  // Finalized: closed and fund raised successfully 
  enum State {Running, Refunding, Finalized}
  State internal state;

  constructor() public {
    state = State.Running;
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