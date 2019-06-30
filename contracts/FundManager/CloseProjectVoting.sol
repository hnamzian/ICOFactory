pragma solidity ^0.5.2;

import "./WhitelistedOracles.sol";
import "./VotingCore.sol";

contract CloseProjectVoting is VotingCore, WhitelistedOracles {
  struct CloseProjectVoting {
    string message;
  }
  mapping (string => CloseProjectVoting) closeProjectVotings;

  uint256 internal minVotesToCloseProject;

  constructor(uint256 _minVotesToCloseProject) public {
    minVotesToCloseProject = _minVotesToCloseProject;
  }

  function createCloseProjectVoting(uint256 ending, string memory message) public {
    CloseProjectVoting memory closeProjectVoting = CloseProjectVoting({
      message: message
    });

    string memory votingID = createVoting(ending, minVotesToCloseProject);
    closeProjectVotings[votingID] = closeProjectVoting;
  }

  function voteCloseProject(string memory _votingId, bool _vote) public {
    vote(_votingId, _vote);
    setVoteConsensus(_votingId);
  }

}