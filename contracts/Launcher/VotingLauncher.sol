pragma solidity ^0.5.2;

import "../FundManager/Voting.sol";
import "./STOSheet.sol";

contract VotingLauncher {
  STOSheet _STOSheet;

  event VotingLaunched(address votingAddress);

  constructor(address STOSheetAddress) public {
    _STOSheet = STOSheet(STOSheetAddress);
  }
  
  function launchVoting(string memory stoID) public returns (address) {
    address crowdsaleAddress = _STOSheet.getCrowdsaleAddress(stoID);

    require(crowdsaleAddress != address(0), "crowdsale contract has not been deployed");

    Voting voting = new Voting(crowdsaleAddress);
    address votingAddress = address(voting);

    emit VotingLaunched(address(voting));

    return votingAddress;
  }
}