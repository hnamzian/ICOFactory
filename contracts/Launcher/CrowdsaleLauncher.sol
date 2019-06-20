pragma solidity ^0.5.2;

import "../Crowdsale/GeneralCrowdsale.sol";

contract CrowdsaleLauncher {
  STOSheet _STOSheet;

  event CrowdsaleLaunched(
  address crowdsaleAddress,
  address tokenAddress,
  uint256 softcap,
  uint256 hardcap,
  uint256 maxIndividualEtherInvest);

  constructor(address STOSheetAddress) public {
    _STOSheet = STOSheet(STOSheetAddress);
  }
  
  function launchCrowdsale(
    address tokenAddress,
    uint256 softcap,
    uint256 hardcap,
    uint256 maxIndividualEtherInvest) public returns (address) {
    GeneralCrowdsale crowdsale = new GeneralCrowdsale(tokenAddress, softcap, hardcap, maxIndividualEtherInvest);

    emit CrowdsaleLaunched(address(crowdsale), tokenAddress, softcap, hardcap, maxIndividualEtherInvest);

    return address(crowdsale);
  }
}