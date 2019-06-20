pragma solidity ^0.5.2;

import "../Crowdsale/GeneralCrowdsale.sol";
import "./STOSheet.sol";

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
    (uint256 softcap,
    uint256 hardcap,
    uint256 maxIndividualEtherInvest, ) = _STOSheet.getCrowdsaleConfigs(stoID);

    address tokenAddress = _STOSheet.getTokenAddress(stoID);

    require(tokenAddress != address(0), "Token conract has not been launched before");

    GeneralCrowdsale crowdsale = new GeneralCrowdsale(tokenAddress, softcap, hardcap, maxIndividualEtherInvest);
    address crowdsaleAddress = address(crowdsale);

    _STOSheet.setCrowdsaleAddress(stoID, crowdsaleAddress);

    emit CrowdsaleLaunched(address(crowdsale), tokenAddress, softcap, hardcap, maxIndividualEtherInvest);

    return crowdsaleAddress;
  }
}