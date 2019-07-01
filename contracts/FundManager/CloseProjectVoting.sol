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

  constructor(uint256 _minVotesToCloseProject) public {
    minVotesToCloseProject = _minVotesToCloseProject;
  }

  function createCloseProjectVoting(uint256 ending, string memory message) public {
    CloseProjectVotingData memory closeProjectVoting = CloseProjectVotingData({
      message: message,
      isValid: true
    });

    string memory votingID = createVoting(ending, minVotesToCloseProject);
    closeProjectVotings[votingID] = closeProjectVoting;
  }

  function voteCloseProject(string memory _votingId, bool _vote) public {
    vote(_votingId, _vote);
    setVoteConsensus(_votingId);
  }

}