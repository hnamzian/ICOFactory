pragma solidity ^0.5.2;

import "./ProjectOwnerRole.sol";
import "./WhitelistedOracles.sol";

contract Votes is ProjectOwnerRole, WhitelistedOracles {
  enum ElectionType {Funding, CloseProject}
  enum ElectionState {Voting, Accepted, Denied}

  struct VoteSession {
    ElectionType electioType;
    ElectionState state;
    address createdBy;
    mapping (address => bool) votes;
    uint8 positiveVotes;
  }
  
}