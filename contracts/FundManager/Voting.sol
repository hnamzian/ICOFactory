pragma solidity ^0.5.2;

import "../Crowdsale/GeneralCrowdsale.sol";
import "./FundRaisingVoting.sol";
import "./CloseProjectVoting.sol";
import "openzeppelin-solidity/contracts/math/SafeMath.sol";

contract Voting is FundRaisingVoting, CloseProjectVoting {
  using SafeMath for uint256;

  GeneralCrowdsale Crowdsale;

  constructor(
    address crowdsaleAddress,
    uint256 _minVotesToRaiseFund,
    uint256 _minVotesToCloseProject)
    FundRaisingVoting(_minVotesToRaiseFund)
    CloseProjectVoting(_minVotesToCloseProject)
    public {
    Crowdsale = GeneralCrowdsale(crowdsaleAddress);
  }

  function claimFund(string memory votingIndex)
    public
    onlyProjectOwner
    whenVotingIsRunning(votingIndex)
    returns (uint256)
  {
    validateFundVoting(votingIndex);
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

  function terminateProject(string memory votingIndex)
    public
    onlyOracle
    whenVotingIsRunning(votingIndex)
  {
    validateCloseProjectVoting(votingIndex);
    VotingSession storage _votingSession = votings[votingIndex];
    require(block.timestamp > _votingSession.ending, "Voting is still running");
    require(!_votingSession.finalized, "voting session has not been finalized");
    if(_votingSession.state == VotingState.Accepted) {
      Crowdsale.terminateProject();
      _votingSession.finalized = true;
    }
  }

}