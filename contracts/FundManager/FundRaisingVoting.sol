pragma solidity ^0.5.2;

import "./ProjectOwnerRole.sol";
import "./WhitelistedOracles.sol";
import "./VotingCore.sol";

contract FundRaisingVoting is VotingCore, WhitelistedOracles, ProjectOwnerRole {

  struct FundVoting {
    VotingSession votingSession;
    uint256 requestedFund;
    string message;
  }
  mapping (string => FundVoting) fundVotings;

  uint256 internal minVotesToRaiseFund;

}