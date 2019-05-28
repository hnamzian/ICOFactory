pragma solidity ^0.5.2;

import "openzeppelin-solidity/contracts/ownership/Ownable.sol";

contract SalesRounds is Ownable {
  struct Round {
    uint256 opening;  // opening timestamp of Round
    uint256 duration;   // Round duration
    uint256 tokenPerEth;  // amount of tokens in decimals per Ether
    uint256 tokenCap;   // max number of tokens allowed to be purchased at Round
    uint256 minTokensInvest;  // minimum amount of tokens to be purchased individually
    uint256 maxTokensInvest;  // maximum amount of tokens can be purchased individually
  }
  Round[] Rounds;

  event RoundAdded(uint256 opening,
  uint256 duration,
  uint256 tokenPerEth,
  uint256 tokenCap,
  uint256 minTokensInvest,
  uint256 maxTokensInvest);
  event RoundRemoved(uint8 roundIndex);

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

  function addRound(
    uint256 _opening,
    uint256 _duration,
    uint256 _tokenPerEth,
    uint256 _tokenCap,
    uint256 _minTokensInvest,
    uint256 _maxTokensInvest) public onlyOwner {
    _addRound(_opening, _duration, _tokenPerEth, _tokenCap, _minTokensInvest, _maxTokensInvest);
  }

  function removeRound(uint8 roundIndex) public onlyOwner {
    _removeRound(roundIndex);
  }

  function _addRound(
    uint256 _opening,
    uint256 _duration,
    uint256 _tokenPerEth,
    uint256 _tokenCap,
    uint256 _minTokensInvest,
    uint256 _maxTokensInvest) internal {
    if (Rounds.length > 0) {
      Round memory lastRound = Rounds[Rounds.length-1];
      require(_opening > lastRound.opening + lastRound.duration, "invalid opening tistamp");
    }

    Rounds.push(Round({
      opening: _opening,
      duration: _duration,
      tokenPerEth: _tokenPerEth,
      tokenCap: _tokenCap,
      minTokensInvest: _minTokensInvest,
      maxTokensInvest: _maxTokensInvest}));

    emit RoundAdded(_opening, _duration, _tokenPerEth, _tokenCap, _minTokensInvest, _maxTokensInvest);
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
}