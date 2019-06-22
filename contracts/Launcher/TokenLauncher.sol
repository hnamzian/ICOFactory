pragma solidity ^0.5.2;

import "../Token/GERC20.sol";
import "./STOSheet.sol";

contract TokenLauncher {

  STOSheet _STOSheet;

  event TokenLaunched(
  address tokenAddress,
  string name,
  string symbol,
  uint8 decimals,
  bool isPausable,
  bool isCapped,
  uint256 cap);

  constructor(address STOSheetAddress) public {
    _STOSheet = STOSheet(STOSheetAddress);
  }

  function launchToken(string memory stoID) public returns (address) {
    (string memory name,
    string memory symbol,
    uint8 decimals,
    bool isPausable,
    bool isCapped,
    uint256 cap,
    address tokenAddress) = _STOSheet.getTokenConfigs(stoID);

    require(tokenAddress == address(0), "This project has already launched a Token");

    GERC20 gerc20 = new GERC20(name, symbol, decimals, isPausable, isCapped, cap);
    tokenAddress = address(gerc20);

    _STOSheet.setTokenAddress(stoID, tokenAddress);

    emit TokenLaunched(address(gerc20), name, symbol, decimals, isPausable, isCapped, cap);

    return tokenAddress;
  }

}