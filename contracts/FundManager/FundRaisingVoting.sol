pragma solidity ^0.5.2;

import "./ProjectOwnerRole.sol";
import "./WhitelistedOracles.sol";
import "./VotingCore.sol";

contract FundRaisingVoting is VotingCore, WhitelistedOracles, ProjectOwnerRole {

  struct FundVoting {
    uint256 requestedFund;
    string message;
    bool isValid;
  }
  mapping (string => FundVoting) fundVotings;

  uint256 internal minVotesToRaiseFund;

  event FundRaisingVotingCreated(string votingID);

  constructor(uint256 _minVotesToRaiseFund) public {
    minVotesToRaiseFund = _minVotesToRaiseFund;
  }

  function setMinVotesToRaiseFund(uint256 _minVotesToRaiseFund) public onlyOwner {
    require(_minVotesToRaiseFund > 0, "Invalid value to set minimum votes");
    minVotesToRaiseFund = _minVotesToRaiseFund;
  }

  function getFundRaisingVoting(string memory votingID)
    public
    view
    returns (uint256, string memory, bool) {
    FundVoting memory fundVoting = fundVotings[votingID];
    return (fundVoting.requestedFund, fundVoting.message, fundVoting.isValid);
  }

  function validateFundVoting(string memory votingID) internal returns (bool) {
    require(fundVotings[votingID].isValid == true, "Invalid Fund Raising Voting");
    return true;
  }

  function createFundVoting(uint256 fund, uint256 ending, string memory message)
    public
    onlyProjectOwner {
    FundVoting memory fundVoting = FundVoting({
      requestedFund: fund,
      message: message,
      isValid: true
    });

    string memory votingID = createVoting(ending, minVotesToRaiseFund);
    fundVotings[votingID] = fundVoting;

    emit FundRaisingVotingCreated(votingID);
  }

  function voteFundRaising(string memory _votingId, bool _vote)
    public
    onlyOracle {
    validateFundVoting(_votingId);
    vote(_votingId, _vote);
    setVoteConsensus(_votingId);
  }

}
