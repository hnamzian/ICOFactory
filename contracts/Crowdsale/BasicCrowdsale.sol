pragma solidity "0.5.2";

import "./SalesRounds.sol";
import "./WhitelistedInvestors.sol";
import "openzeppelin-solidity/contracts/math/SafeMath.sol";

contract BasicCrowdsale is SalesRounds, WhitelistedInvestors {
  using SafeMath for uint256;

  uint256 private _softcap;
  uint256 private _hardcap;

  uint256 private _maxIndividualEtherInvest;

  mapping (address => uint256) private _invests;

  uint256 private _etherRaised;

  constructor(
    uint256 softcap, 
    uint256 hardcap, 
    uint256 maxIndividualEtherInvest) public {
      _softcap = softcap;
      _hardcap = hardcap;
      _maxIndividualEtherInvest = maxIndividualEtherInvest;
  }
}