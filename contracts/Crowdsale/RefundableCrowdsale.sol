pragma solidity "0.5.2";

import "./FinalizableCrowdsale.sol";

contract RefundableCrowdsale is FinalizableCrowdsale {
  event Refunded(address investor, uint256 invest);
    
  function refund(address payable investor) public {
    require(state == State.Refunding  || state == State.Terminated);
    require(_invests[investor] != 0, "Amount of remaining invest is zero");

    uint256 refundValue = _etherRaised.sub(_totalWithdrawals).mul(_invests[investor]).div(_etherRaised);
    _invests[investor] = 0;
    investor.transfer(refundValue);
    
    emit Refunded(investor, refundValue);
  }
}