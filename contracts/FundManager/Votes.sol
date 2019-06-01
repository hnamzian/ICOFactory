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

  function requestFundVoting(uint256 fund, string memory message) public onlyProjectOwner {
    FundVoting memory lastFundVoting = fundVoting[fundVoting.length-1];
    require(lastFundVoting.votingSession.state != VotingState.Voting, "another voting session is still running");
    require(fund > 0, "requested fund must be grater than 0");

    FundVoting memory _fundVoting = FundVoting({
      votingSession: VotingSession({
        state: VotingState.Voting,
        createdBy: msg.sender,
        positiveVotes: 0
      }),
      requestedFund: fund,
      message: message
    });

    fundVoting.push(_fundVoting);
  }
}