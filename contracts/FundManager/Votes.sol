pragma solidity ^0.5.2;

import "./ProjectOwnerRole.sol";
import "./WhitelistedOracles.sol";

contract Voting is ProjectOwnerRole, WhitelistedOracles {
  enum VotingState {Voting, Accepted, Denied}

  struct VotingSession {
    VotingState state;
    address createdBy;
    mapping (address => bool) voteOf;
    uint8 positiveVotes;
  }

  struct FundVoting {
    VotingSession votingSession;
    uint256 requestedFund;
    string message;
  }

  struct CloseProjectVoting {
    VotingSession votingSession;
    string message;
  }

  FundVoting[] fundVoting;
  CloseProjectVoting[] closeProjectVoting;

}