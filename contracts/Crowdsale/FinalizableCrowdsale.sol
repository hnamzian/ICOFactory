pragma solidity "0.5.2";

import "./BasicCrowdsale.sol";

contract FinalizableCrowdsale is BasicCrowdsale {
  // defines Crowdsale state:
  // Running: open to purchase
  // Refunding: closed and invests must be refunded
  // Finalized: closed and fund raised successfully 
  enum State {Running, Refunding, Finalized}
  State private state;

  constructor() public {
    state = State.Running;
  }
  
  function finalize() public onlyOwner {
    if (etherRaised > hardcap) state = State.Finalized;
    else if (isSalesClosed()) {
      if (etherRaised >= softcap) state = State.Finalized;
      else state = State.Refunding;
    }
  }
}