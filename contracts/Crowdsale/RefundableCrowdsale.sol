pragma solidity "0.5.2";

import "./FinalizableCrowdsale.sol";

contract RefundableCrowdsale is FinalizableCrowdsale {
  event Refunded(address investor, uint256 invest);
    
  function refund(address payable investor) public {
    require(isFinalized());
    require(state == State.Refunding);
    require(_invests[investor] != 0);
    uint256 refundValue = _invests[investor];
    _invests[investor] = 0;
    investor.transfer(refundValue);
    emit Refunded(investor, refundValue);
  }
}