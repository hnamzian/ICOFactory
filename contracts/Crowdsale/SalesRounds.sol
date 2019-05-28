pragma solidity ^0.5.2;

import "openzeppelin-solidity/contracts/ownership/Ownable.sol";

contract SalesRounds is Ownable {
  struct Round {
    uint256 opening;  // opening timestamp of Round
    uint256 ending;   // ending timestamp of Round
    uint256 tokenPerEth;  // amount of tokens in decimals per Ether
    uint256 tokenCap;   // max number of tokens allowed to be purchased at Round
    uint256 minTokensInvest;  // minimum amount of tokens to be purchased individually
    uint256 maxTokensInvest;  // maximum amount of tokens can be purchased individually
  }
  Round[] Rounds;

  event RoundAdded(uint256 opening,
  uint256 ending,
  uint256 tokenPerEth,
  uint256 tokenCap,
  uint256 minTokensInvest,
  uint256 maxTokensInvest);

  function addRound(
    uint256 _opening,
    uint256 _ending,
    uint256 _tokenPerEth,
    uint256 _tokenCap,
    uint256 _minTokensInvest,
    uint256 _maxTokensInvest) public onlyOwner {
    _addRound(_opening, _ending, _tokenPerEth, _tokenCap, _minTokensInvest, _maxTokensInvest);
  }

  function _addRound(
    uint256 _opening,
    uint256 _ending,
    uint256 _tokenPerEth,
    uint256 _tokenCap,
    uint256 _minTokensInvest,
    uint256 _maxTokensInvest) internal {
    Rounds.push(Round({
      opening: _opening,
      ending: _ending,
      tokenPerEth: _tokenPerEth,
      tokenCap: _tokenCap,
      minTokensInvest: _minTokensInvest,
      maxTokensInvest: _maxTokensInvest}));

    emit RoundAdded(_opening, _ending, _tokenPerEth, _tokenCap, _minTokensInvest, _maxTokensInvest);
  }
}