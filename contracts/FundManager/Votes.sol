pragma solidity ^0.5.2;

import "./ProjectOwnerRole.sol";
import "./WhitelistedOracles.sol";

contract Voting is ProjectOwnerRole, WhitelistedOracles {
  enum ElectionType {Funding, CloseProject}
  enum ElectionState {Voting, Accepted, Denied}

  struct VotingSession {
    ElectionType electioType;
    ElectionState state;
    address createdBy;
    mapping (address => bool) voteOf;
    uint8 positiveVotes;
  }
  VotingSession[] votingSessions;
  
}