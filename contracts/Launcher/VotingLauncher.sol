pragma solidity ^0.5.2;

import "../FundManager/Voting.sol";

contract VotingLauncher {
  event VotingLaunched(address votingAddress);

  function launchVoting(address crowdsaleAddress) public returns (Voting) {
    Voting voting = new Voting(crowdsaleAddress);

    emit VotingLaunched(address(voting));

    return voting;
  }
}