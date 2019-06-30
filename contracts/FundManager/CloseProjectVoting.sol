pragma solidity ^0.5.2;

import "./WhitelistedOracles.sol";
import "./VotingCore.sol";

contract CloseProjectVoting is VotingCore, WhitelistedOracles {
  struct CloseProjectVoting {
    string message;
  }
  mapping (string => CloseProjectVoting) closeProjectVotings;

  uint256 internal minVotesToCloseProject;

}