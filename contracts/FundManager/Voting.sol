pragma solidity ^0.5.2;

import "./ProjectOwnerRole.sol";
import "./WhitelistedOracles.sol";
import "../Crowdsale/GeneralCrowdsale.sol";
import "openzeppelin-solidity/contracts/math/SafeMath.sol";

contract Voting is ProjectOwnerRole, WhitelistedOracles {
  using SafeMath for uint256;

  GeneralCrowdsale Crowdsale;

  enum VotingState {Accepted, Denied}

  struct VotingSession {
    VotingState state;
    bool finalized;
    address createdBy;
    uint256 ending;
    mapping (address => bool) voteOf;
    uint256 positiveVotes;
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

  uint256 private _minVotes;

  constructor(address crowdsaleAddress) public {
    Crowdsale = GeneralCrowdsale(crowdsaleAddress);
  }

  modifier onlyFundVotingRunning() {
    FundVoting memory _lastVoting = fundVoting[fundVoting.length-1];
    require(block.timestamp < _lastVoting.votingSession.ending, "no active voting");
    _;
  }

  modifier onlyCloseProjectVotingRunning() {
    CloseProjectVoting memory _lastVoting = closeProjectVoting[fundVoting.length-1];
    require(block.timestamp < _lastVoting.votingSession.ending, "no active voting");
    _;
  }
  
  function requestFundVoting(uint256 fund, uint256 ending, string memory message) public onlyProjectOwner {
    FundVoting memory lastFundVoting = fundVoting[fundVoting.length-1];
    require(block.timestamp > lastFundVoting.votingSession.ending, "another voting session is still running");
    require(fund > 0, "requested fund must be grater than 0");

    FundVoting memory _fundVoting = FundVoting({
      votingSession: VotingSession({
        state: VotingState.Denied,
        finalized: false,
        ending: ending,
        createdBy: msg.sender,
        positiveVotes: 0
      }),
      requestedFund: fund,
      message: message
    });

    fundVoting.push(_fundVoting);
  }

  function requestCloseProjectVoting(uint256 ending, string memory message) public onlyOracle {
    CloseProjectVoting memory lastVoting = closeProjectVoting[closeProjectVoting.length-1];
    require(block.timestamp > lastVoting.votingSession.ending, "another voting session is still running");

    CloseProjectVoting memory _closeProjectVoting = CloseProjectVoting({
      votingSession: VotingSession({
        state: VotingState.Denied,
        finalized: false,
        ending: ending,
        createdBy: msg.sender,
        positiveVotes: 0
      }),
      message: message
    });

    closeProjectVoting.push(_closeProjectVoting);
  }

  function voteFundRaising(bool _vote) public onlyOracle onlyFundVotingRunning {
    VotingSession storage _lastVoting = fundVoting[fundVoting.length-1].votingSession;
    if(_lastVoting.voteOf[msg.sender] != _vote) {
      _lastVoting.voteOf[msg.sender] = _vote;
      if(_vote) _lastVoting.positiveVotes.add(1);
      _lastVoting.state = _voteConsensus(_lastVoting.positiveVotes);
    }
  }

  function voteCloseProject(bool _vote) public onlyOracle onlyCloseProjectVotingRunning {
    VotingSession storage _lastVoting = closeProjectVoting[closeProjectVoting.length-1].votingSession;
    if(_lastVoting.voteOf[msg.sender] != _vote) {
      _lastVoting.voteOf[msg.sender] = _vote;
      if(_vote) _lastVoting.positiveVotes.add(1);
      _lastVoting.state = _voteConsensus(_lastVoting.positiveVotes);
    }
  }

  function claimFund(uint256 votingIndex) public onlyProjectOwner returns (uint256) {
    FundVoting storage _lastVoting = fundVoting[votingIndex];
    require(!_lastVoting.votingSession.finalized, "voting session has been finalized");
    Crowdsale.withdraw(_lastVoting.requestedFund);
  }

  function terminateProject() public onlyOracle {
    CloseProjectVoting memory _lastVoting = closeProjectVoting[fundVoting.length-1];
    require(block.timestamp > _lastVoting.votingSession.ending, "voting is not closed");

    if(_lastVoting.votingSession.state == VotingState.Accepted) Crowdsale.terminateProject();
  }

  function _voteConsensus(uint256 positiveVotes) internal view returns (VotingState) {
    if (positiveVotes >= _minVotes) return VotingState.Accepted;
    return VotingState.Denied;
  }

}