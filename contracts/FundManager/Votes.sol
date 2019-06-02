pragma solidity ^0.5.2;

import "./ProjectOwnerRole.sol";
import "./WhitelistedOracles.sol";

contract Voting is ProjectOwnerRole, WhitelistedOracles {
  enum VotingState {Voting, Accepted, Denied}

  struct VotingSession {
    VotingState state;
    address createdBy;
    uint256 ending;
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

  modifier onlyFundVotingRunning() {
    FundVoting _lastVoting = fundVoting[fundVoting.length-1];
    require(_lastVoting.votingSession.state == VotingState.Voting, "no active voting");
    _;
  }

  modifier onlyCloseProjectVotingRunning() {
    CloseProjectVoting _lastVoting = closeProjectVoting[fundVoting.length-1];
    require(_lastVoting.votingSession.state == VotingState.Voting, "no active voting");
    _;
  }
  
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

  function requestCloseProjectVoting(string memory message) public onlyOracle {
    CloseProjectVoting memory lastVoting = closeProjectVoting[closeProjectVoting.length-1];
    require(lastVoting.votingSession.state != VotingState.Voting, "another voting session is still running");

    CloseProjectVoting memory _closeProjectVoting = CloseProjectVoting({
      votingSession: VotingSession({
        state: VotingState.Voting,
        createdBy: msg.sender,
        positiveVotes: 0
      }),
      message: message
    });

    closeProjectVoting.push(_closeProjectVoting);
  }

  function voteFundRaising(bool _vote) public onlyOracle onlyFundVotingRunning {
    FundVoting _lastVoting = fundVoting[fundVoting.length-1];
    if(_lastVoting.votingSession.voteOf[msg.sender] != _vote) {
      _lastVoting.votingSession.voteOf[msg.sender] = _vote;
      if(_vote) _lastVoting.votingSession.positiveVotes.add(1);
    }
  }

  function voteCloseProject(bool _vote) public onlyOracle onlyCloseProjectVotingRunning {
    CloseProjectVoting _lastVoting = closeProjectVoting[closeProjectVoting.length-1];
    if(_lastVoting.votingSession.voteOf[msg.sender] != _vote) {
      _lastVoting.votingSession.voteOf[msg.sender] = _vote;
      if(_vote) _lastVoting.votingSession.positiveVotes.add(1);
    }
  }

}