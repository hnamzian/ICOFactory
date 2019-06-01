pragma solidity ^0.5.2;

import "openzeppelin-solidity/contracts/ownership/Ownable.sol";
import "openzeppelin-solidity/contracts/math/SafeMath.sol";

contract SalesRounds is Ownable {
  using SafeMath for uint256;

  struct Round {
    uint256 opening;  // opening timestamp of Round
    uint256 duration;   // Round duration
    uint256 tokenPerEth;  // amount of tokens in decimals per Ether
    uint256 tokenCap;   // max number of tokens allowed to be purchased at Round
    uint256 minInvest;  // minimum amount of weis to be purchased individually
    uint256 maxInvest;  // maximum amount of weis can be purchased individually
    mapping(address => uint256) invests;  // amount of weis invested by an address at each Round
  }
  Round[] Rounds;

  event RoundAdded(uint256 opening,
  uint256 duration,
  uint256 tokenPerEth,
  uint256 tokenCap,
  uint256 minInvest,
  uint256 maxInvest);
  event RoundRemoved(uint8 roundIndex);

  modifier onlySalesRunning() {
    require(isSalesRunning(), "Crowdsale is not running now");
    _;
  }

  function isSalesRunning() public view returns (bool) {
    Round memory round;
    for (uint8 i = 0; i < Rounds.length; i++) {
      round = Rounds[i];
      if (block.timestamp > round.opening && block.timestamp < round.opening + round.duration) {
        return true;
      }
    }
    return false;
  }

  function isSalesClosed() public view returns (bool) {
    Round memory round;
    if (block.timestamp > round.opening + round.duration) return true;
    return false;
  }

  function addRound(
    uint256 _opening,
    uint256 _duration,
    uint256 _tokenPerEth,
    uint256 _tokenCap,
    uint256 _minInvest,
    uint256 _maxInvest) public onlyOwner {
    _addRound(_opening, _duration, _tokenPerEth, _tokenCap, _minInvest, _maxInvest);
  }

  function removeRound(uint8 roundIndex) public onlyOwner {
    _removeRound(roundIndex);
  }

  function getTokensPerEther() public view returns (uint256) {
    uint8 roundIndex = _getRoundIndex();
    if (roundIndex < Rounds.length) {
      Round memory round = Rounds[roundIndex];
      return round.tokenPerEth;
    }
    return 0;
  }

  function getRoundMinInvest() public view returns (uint256) {
    uint8 roundIndex = _getRoundIndex();
    if (roundIndex < Rounds.length) {
      Round memory round = Rounds[roundIndex];
      return round.minInvest;
    }
    return uint(-1);
  }

  function getRoundMaxInvest() public view returns (uint256) {
    uint8 roundIndex = _getRoundIndex();
    if (roundIndex < Rounds.length) {
      Round memory round = Rounds[roundIndex];
      return round.maxInvest;
    }
    return uint(0);
  }

  function getRoundInvestOf(address wallet, uint8 roundIndex) public view returns (uint256) {
    require(wallet != address(0), "invalid address");
    require(roundIndex < Rounds.length, "invalid round index");
    return Rounds[roundIndex].invests[wallet];
  }

  function setRoundInvestOf(address wallet, uint256 weiAmount, uint8 roundIndex) internal {
    require(wallet != address(0), "invalid address");
    require(roundIndex < Rounds.length, "invalid round index");
    Rounds[roundIndex].invests[wallet] = weiAmount;
  }

  function increaseRoundInvestOf(address wallet, uint256 weiAmount, uint8 roundIndex) internal {
    require(wallet != address(0), "invalid address");
    require(roundIndex < Rounds.length, "invalid round index");
    Rounds[roundIndex].invests[wallet] = Rounds[roundIndex].invests[wallet].add(weiAmount);
  }

  function _addRound(
    uint256 _opening,
    uint256 _duration,
    uint256 _tokenPerEth,
    uint256 _tokenCap,
    uint256 _minInvest,
    uint256 _maxInvest) internal {
    if (Rounds.length > 0) {
      Round memory lastRound = Rounds[Rounds.length-1];
      require(_opening > lastRound.opening + lastRound.duration, "invalid opening tistamp");
    }

    Rounds.push(Round({
      opening: _opening,
      duration: _duration,
      tokenPerEth: _tokenPerEth,
      tokenCap: _tokenCap,
      minInvest: _minInvest,
      maxInvest: _maxInvest}));

    emit RoundAdded(_opening, _duration, _tokenPerEth, _tokenCap, _minInvest, _maxInvest);
  }

  function _removeRound(uint8 roundIndex) internal {
    require(roundIndex < Rounds.length, "invalid round index");

    for (uint8 i = roundIndex; i < Rounds.length-1; i++){
      Rounds[i] = Rounds[i+1];
    }
    delete Rounds[Rounds.length-1];
    Rounds.length--;

    emit RoundRemoved(roundIndex);
  }

  function _getRoundIndex() internal view returns (uint8) {
    Round memory round;
    for (uint8 i = 0; i < Rounds.length; i++) {
      round = Rounds[i];
      if (block.timestamp > round.opening && block.timestamp < round.opening + round.duration) {
        return i;
      }
    }
    return uint8(-1);
  }
}