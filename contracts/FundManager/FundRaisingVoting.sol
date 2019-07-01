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

  constructor(uint256 _minVotesToRaiseFund) public {
    minVotesToRaiseFund = _minVotesToRaiseFund;
  }

  function validateFundVoting(string memory votingID) internal returns (bool) {
    require(fundVotings[votingID].isValid == true, "Invalid Fund Raising Voting");
    return true;
  }

  function createFundVoting(uint256 fund, uint256 ending, string memory message) public {
    FundVoting memory fundVoting = FundVoting({
      requestedFund: fund,
      message: message,
      isValid: true
    });

    string memory votingID = createVoting(ending, minVotesToRaiseFund);
    fundVotings[votingID] = fundVoting;
  }

  function voteFundRaising(string memory _votingId, bool _vote) public {
    vote(_votingId, _vote);
    setVoteConsensus(_votingId);
  }

}
