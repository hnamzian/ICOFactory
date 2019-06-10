pragma solidity ^0.5.2;

import "./TokenLauncher.sol";
import "./CrowdsaleLauncher.sol";
import "./VotingLauncher.sol";

contract MainLauncher {

  TokenLauncher tokenLauncher;
  CrowdsaleLauncher crowdsaleLauncher;
  VotingLauncher votingLauncher;

  function launchSTO(
    string memory name,
    string memory symbol,
    uint8 decimals,
    bool isBurnable,
    bool isPausable,
    bool isCapped,
    uint256 cap,
    address tokenAddress,
    uint256 softcap,
    uint256 hardcap,
    uint256 maxIndividualEtherInvest
  ) public {
    tokenLauncher.launchToken(name, symbol, decimals, isBurnable, isPausable, isCapped, cap);
    crowdsaleLauncher.launchCrowdsale(tokenAddress, softcap, hardcap, maxIndividualEtherInvest);
    votingLauncher.launchVoting();
  }

}