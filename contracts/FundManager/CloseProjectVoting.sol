pragma solidity ^0.5.2;

import "./WhitelistedOracles.sol";
import "./VotingCore.sol";

contract CloseProjectVoting is VotingCore, WhitelistedOracles {
  struct CloseProjectVotingData {
    string message;
    bool isValid;
  }
  mapping (string => CloseProjectVotingData) closeProjectVotings;

  uint256 internal minVotesToCloseProject;

  event CloseProjectVotingCreated(string votingID);

  constructor(uint256 _minVotesToCloseProject) public {
    minVotesToCloseProject = _minVotesToCloseProject;
  }

  function validateCloseProjectVoting(string memory votingID) internal returns (bool) {
    require(closeProjectVotings[votingID].isValid == true, "Invalid Close Project Voting");
    return true;
  }

  function createCloseProjectVoting(uint256 ending, string memory message) public {
    CloseProjectVotingData memory closeProjectVoting = CloseProjectVotingData({
      message: message,
      isValid: true
    });

    string memory votingID = createVoting(ending, minVotesToCloseProject);
    closeProjectVotings[votingID] = closeProjectVoting;

    emit CloseProjectVotingCreated(votingID);
  }

  function voteCloseProject(string memory _votingId, bool _vote) public {
    validateCloseProjectVoting(_votingId);
    vote(_votingId, _vote);
    setVoteConsensus(_votingId);
  }

}