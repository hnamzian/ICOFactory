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

  function setMinVotesToCloseProject(uint256 _minVotesToCloseProject) public onlyOwner {
    require(_minVotesToCloseProject > 0, "Invalid value to set minimum votes");
    minVotesToCloseProject = _minVotesToCloseProject;
  }

  function getCloseProjectVoting(string memory votingID)
    public
    view
    returns (string memory, bool) {
    CloseProjectVotingData memory closeProjectVoting = closeProjectVotings[votingID];
    return (closeProjectVoting.message, closeProjectVoting.isValid);
  }

  function validateCloseProjectVoting(string memory votingID) internal returns (bool) {
    require(closeProjectVotings[votingID].isValid == true, "Invalid Close Project Voting");
    return true;
  }

  function createCloseProjectVoting(uint256 ending, string memory message)
    public
    onlyOracle {
    CloseProjectVotingData memory closeProjectVoting = CloseProjectVotingData({
      message: message,
      isValid: true
    });

    string memory votingID = createVoting(ending, minVotesToCloseProject);
    closeProjectVotings[votingID] = closeProjectVoting;

    emit CloseProjectVotingCreated(votingID);
  }

  function voteCloseProject(string memory _votingId, bool _vote)
    public
    onlyOracle {
    validateCloseProjectVoting(_votingId);
    vote(_votingId, _vote);
    setVoteConsensus(_votingId);
  }

}