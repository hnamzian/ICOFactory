pragma solidity ^0.5.2;

import "./BasicCrowdsale.sol";
import "./FinalizableCrowdsale.sol";
import "./RefundableCrowdsale.sol";
import "./WithdrawalCrowdsale.sol";

contract GeneralCrowdsale is 
  BasicCrowdsale,
  WithdrawalCrowdsale,
  FinalizableCrowdsale,
  RefundableCrowdsale
{
  constructor(address tokenAddress,
    uint256 softcap,
    uint256 hardcap,
    uint256 maxIndividualEtherInvest)
  BasicCrowdsale(tokenAddress, softcap, hardcap, maxIndividualEtherInvest)
  FinalizableCrowdsale() public {}

}