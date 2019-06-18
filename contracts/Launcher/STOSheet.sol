pragma solidity ^0.5.2;

import "../utils/bytesUtil.sol";

contract STOSheet {
  using bytesUtils for bytes32;

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
    address createdBy;
    Token token;
    Crowdsale crowdsale;
    Voting voting;
  }

  mapping(string => STO) private STOs;

  function setSTOConfigs(
    string memory name,
    string memory symbol,
    uint8 decimals,
    bool isBurnable,
    bool isPausable,
    bool isCapped,
    uint256 cap,
    uint256 softcap,
    uint256 hardcap,
    uint256 maxIndividualEtherInvest) public returns (string memory hashIDString) {
    bytes32 hashID = keccak256(
      abi.encode(
      name,
      symbol,
      decimals,
      isBurnable,
      isPausable,
      isCapped,
      cap,
      softcap,
      hardcap,
      maxIndividualEtherInvest));
      
    hashIDString = hashID.bytes32ToString();

    // STO storage stoConfig = STOs[hashID.bytes32ToString()];
  }

}