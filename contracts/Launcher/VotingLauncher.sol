pragma solidity ^0.5.2;

import "../FundManager/Voting.sol";

contract VotingLauncher {
  STOSheet _STOSheet;

  event VotingLaunched(address votingAddress);

  constructor(address STOSheetAddress) public {
    _STOSheet = STOSheet(STOSheetAddress);
  }
  
  function launchVoting(address crowdsaleAddress) public returns (address) {
    Voting voting = new Voting(crowdsaleAddress);

    emit VotingLaunched(address(voting));

    return address(voting);
  }
}