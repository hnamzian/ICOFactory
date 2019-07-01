pragma solidity ^0.5.2;

import "../Crowdsale/GeneralCrowdsale.sol";
import "./FundRaisingVoting.sol";
import "./CloseProjectVoting.sol";
import "openzeppelin-solidity/contracts/math/SafeMath.sol";

contract Voting is FundRaisingVoting, CloseProjectVoting {
  using SafeMath for uint256;

  GeneralCrowdsale Crowdsale;

  constructor(address crowdsaleAddress) public {
    Crowdsale = GeneralCrowdsale(crowdsaleAddress);
  }

  modifier onlyFundVotingRunning() {
    FundVoting memory _lastVoting = fundVoting[fundVoting.length-1];
    require(block.timestamp < _lastVoting.votingSession.ending, "no active voting");
    _;
  }

  modifier onlyCloseProjectVotingRunning() {
    require(closeProjectVoting.length > 0, "No voting session exists");
    CloseProjectVoting memory _lastVoting = closeProjectVoting[closeProjectVoting.length-1];
    require(block.timestamp < _lastVoting.votingSession.ending, "no active voting");
    _;
  }

  function claimFund(uint256 votingIndex) public onlyProjectOwner returns (uint256) {
    FundVoting storage _fundVoting = fundVotings[votingIndex];
    require(_fundVoting.requestedFund > 0, "Invalid requested fund");

    VotingSession storage _votingSession = votings[votingIndex];
    require(block.timestamp > _votingSession.ending, "Voting is still running");
    require(!_votingSession.finalized, "voting session has not been finalized");

    if (_votingSession.state == VotingState.Accepted) {
      bool withdrawResult = Crowdsale.withdraw(_fundVoting.requestedFund);
      _votingSession.finalized = withdrawResult;
    }
  }

  function terminateProject(uint256 votingIndex) public onlyOracle {
    VotingSession storage _votingSession = votings[votingIndex];
    require(block.timestamp > _votingSession.ending, "Voting is still running");
    require(!_votingSession.finalized, "voting session has not been finalized");
    if(_votingSession.state == VotingState.Accepted) {
      Crowdsale.terminateProject();
      _votingSession.finalized = true;
    }
  }

}