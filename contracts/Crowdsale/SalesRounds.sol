pragma solidity ^0.5.2;

contract SalesRounds {
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
  
}