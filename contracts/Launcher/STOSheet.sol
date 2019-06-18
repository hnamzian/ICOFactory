pragma solidity ^0.5.2;

contract STOSheet {
  struct Token {
    string name;
    string symbol;
    uint8 decimals;
    bool isBurnable;
    bool isPausable;
    bool isCapped;
    uint256 cap;
    address tokenAddress;
  }

  struct Crowdsale {
    uint256 softcap;
    uint256 hardcap;
    uint256 maxIndividualEtherInvest;
    address crowdsaleAddress;
  }

  struct Voting {
    address votingAddress;
  }

  struct STO {
    Token token;
    Crowdsale crowdsale;
    Voting voting;
  }

}