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

  event TokensPurchased(address indexed wallet, uint256 weiAmount, uint256 tokens);

  constructor(
    uint256 softcap, 
    uint256 hardcap, 
    uint256 maxIndividualEtherInvest) public {
      _softcap = softcap;
      _hardcap = hardcap;
      _maxIndividualEtherInvest = maxIndividualEtherInvest;
  }

  function buyToken() public payable {}

  function _preValidatePurchase(address wallet, uint256 weiAmount) internal view returns (bool) {
    require(wallet != address(0), "invalid wallet address");
    require(weiAmount != 0, "invalid amount of invest");
    require(isInvestor(wallet), "wallet is not whitelisted");
    require(_etherRaised.add(weiAmount) < _hardcap, "hardcap reached");
    require(_invests[wallet].add(weiAmount) < _maxIndividualEtherInvest, "individual invest cap reached");

    return true;
  }
}