pragma solidity ^0.5.2;

import "./ProjectOwnerRole.sol";
import "./WhitelistedOracles.sol";
import "../Crowdsale/GeneralCrowdsale.sol";
import "openzeppelin-solidity/contracts/math/SafeMath.sol";

contract Voting is ProjectOwnerRole, WhitelistedOracles {
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
    FundVoting storage _lastVoting = fundVoting[votingIndex];
    require(block.timestamp > _lastVoting.votingSession.ending, "Voting is still running");
    require(!_lastVoting.votingSession.finalized, "voting session has not been finalized");
    if (_lastVoting.votingSession.state == VotingState.Accepted) {
      bool withdrawResult = Crowdsale.withdraw(_lastVoting.requestedFund);
      _lastVoting.votingSession.finalized = withdrawResult;
    }
  }

  function terminateProject() public onlyOracle {
    require(closeProjectVoting.length > 0, "No voting session exists");
    CloseProjectVoting memory _lastVoting = closeProjectVoting[closeProjectVoting.length-1];
    require(block.timestamp > _lastVoting.votingSession.ending, "voting is still running");
    if(_lastVoting.votingSession.state == VotingState.Accepted) Crowdsale.terminateProject();
  }

}