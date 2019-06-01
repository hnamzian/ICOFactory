pragma solidity "0.5.2";

import "./BasicCrowdsale.sol";

contract FinalizableCrowdsale is BasicCrowdsale {
  // defines Crowdsale state:
  // Running: open to purchase
  // Refunding: closed and invests must be refunded
  // Finalized: closed and fund raised successfully 
  enum State {Running, Refunding, Finalized}
  State private state;
  
}