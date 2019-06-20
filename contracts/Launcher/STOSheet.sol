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

    STOs[hashIDString] = STO({
      createdBy: msg.sender,
      token: Token({
        name: name,
        symbol: symbol,
        decimals: decimals,
        isBurnable: isBurnable,
        isPausable: isPausable,
        isCapped: isCapped,
        cap: cap,
        tokenAddress: address(0)
      }),
      crowdsale: Crowdsale({
        softcap: softcap,
        hardcap: hardcap,
        maxIndividualEtherInvest: maxIndividualEtherInvest,
        crowdsaleAddress: address(0)
      }),
      voting: Voting({
        votingAddress: address(0)
      })
    });
  }

  function getTokenConfigs(string memory id) public view returns (
    string memory name,
    string memory symbol,
    uint8 decimals,
    bool isBurnable,
    bool isPausable,
    bool isCapped,
    uint256 cap,
    address tokenAddress) {
    Token memory token = STOs[id].token;
    name = token.name;
    symbol = token.symbol;
    decimals = token.decimals;
    isBurnable = token.isBurnable;
    isPausable = token.isPausable;
    isCapped = token.isCapped;
    cap = token.cap;
    tokenAddress = token.tokenAddress;
  }

  function getCrowdsaleConfigs(string memory id) public view returns (
    uint256 softcap,
    uint256 hardcap,
    uint256 maxIndividualEtherInvest,
    address crowdsaleAddress) {
    Crowdsale memory crowdsale = STOs[id].crowdsale;
    softcap = crowdsale.softcap;
    hardcap = crowdsale.hardcap;
    maxIndividualEtherInvest = crowdsale.maxIndividualEtherInvest;
    crowdsaleAddress = crowdsale.crowdsaleAddress;
  }

  function getVotingConfigs(string memory id) public view returns (address votingAddress) {
    Voting memory voting = STOs[id].voting;
    votingAddress = voting.votingAddress;
  }
}