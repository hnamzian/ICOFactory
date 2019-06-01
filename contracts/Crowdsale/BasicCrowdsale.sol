pragma solidity "0.5.2";

import "../Token/GERC20.sol";
import "./SalesRounds.sol";
import "./WhitelistedInvestors.sol";
import "openzeppelin-solidity/contracts/math/SafeMath.sol";

contract BasicCrowdsale is SalesRounds, WhitelistedInvestors {
  using SafeMath for uint256;

  GERC20 private _token;

  uint256 internal _softcap;
  uint256 internal _hardcap;
  uint256 internal _etherRaised;

  uint256 private _maxIndividualEtherInvest;

  mapping (address => uint256) internal _invests;


  event TokensPurchased(address indexed wallet, uint256 weiAmount, uint256 tokens);

  constructor(
    address tokenAddress,
    uint256 softcap, 
    uint256 hardcap, 
    uint256 maxIndividualEtherInvest) public {
      _token = GERC20(tokenAddress);
      _softcap = softcap;
      _hardcap = hardcap;
      _maxIndividualEtherInvest = maxIndividualEtherInvest;
  }

  function buyToken() public payable onlySalesRunning {
    address wallet = msg.sender;
    uint256 weiAmount = msg.value;

    _preValidatePurchase(wallet, weiAmount);

    _updatePurchaseState(wallet, weiAmount);

    uint256 tokenAmount = _processPurchase(wallet, weiAmount);

    emit TokensPurchased(wallet, weiAmount, tokenAmount);
  }

  function _preValidatePurchase(address wallet, uint256 weiAmount) internal view returns (bool) {
    require(wallet != address(0), "invalid wallet address");
    require(weiAmount != 0, "invalid amount of invest");
    require(isInvestor(wallet), "wallet is not whitelisted");
    require(_etherRaised.add(weiAmount) < _hardcap, "hardcap reached");
    require(_invests[wallet].add(weiAmount) < _maxIndividualEtherInvest, "individual invest cap reached");
    
    uint8 roundIndex = _getRoundIndex();
    uint256 roundInvest = getRoundInvestOf(wallet, roundIndex).add(weiAmount);
    require(roundInvest <= getRoundMaxInvest(), "individual round invest cap reached");
    require(roundInvest >= getRoundMinInvest(), "individual round invest not sufficiant");

    return true;
  }

  function _updatePurchaseState(address wallet, uint256 weiAmount) internal returns (bool) {
    _etherRaised = _etherRaised.add(weiAmount);
    _invests[wallet] = _invests[wallet].add(weiAmount);

    uint8 roundIndex = _getRoundIndex();
    increaseRoundInvestOf(wallet, weiAmount, roundIndex);
  }

  function _processPurchase(address wallet, uint256 weiAmount) internal returns (uint256) {
    uint256 tokenWeiPrice = getTokenWeiPrice();
    uint256 tokenAmount = weiAmount.mul(tokenWeiPrice);
    _token.mint(wallet, tokenAmount);
    return tokenAmount;
  }

}