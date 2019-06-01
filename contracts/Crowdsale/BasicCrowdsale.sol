pragma solidity "0.5.2";

import "./SalesRounds.sol";
import "./WhitelistedInvestors.sol";
import "openzeppelin-solidity/contracts/math/SafeMath.sol";

contract BasicCrowdsale is SalesRounds, WhitelistedInvestors {
  using SafeMath for uint256;

  uint256 private _softcap;
  uint256 private _hardcap;

}