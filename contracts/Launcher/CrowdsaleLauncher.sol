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
  
  function launchCrowdsale(string memory stoID) public returns (address) {
    (address tokenAddress,
    uint256 softcap,
    uint256 hardcap,
    uint256 maxIndividualEtherInvest) = _STOSheet.getCrowdsaleAddress(stoID);

    GeneralCrowdsale crowdsale = new GeneralCrowdsale(tokenAddress, softcap, hardcap, maxIndividualEtherInvest);
    address crowdsaleAddress = address(crowdsale);

    emit CrowdsaleLaunched(address(crowdsale), tokenAddress, softcap, hardcap, maxIndividualEtherInvest);

    return crowdsaleAddress;
  }
}