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
  bool isBurnable,
  bool isPausable,
  bool isCapped,
  uint256 cap);

  constructor(address STOSheetAddress) public {
    _STOSheet = STOSheet(STOSheetAddress);
  }

  function launchToken(
    string memory name,
    string memory symbol,
    uint8 decimals,
    bool isBurnable,
    bool isPausable,
    bool isCapped,
    uint256 cap) public returns (address) {
    GERC20 gerc20 = new GERC20(name, symbol, decimals, isBurnable, isPausable, isCapped, cap);

    emit TokenLaunched(address(gerc20), name, symbol, decimals, isBurnable, isPausable, isCapped, cap);

    return address(gerc20);
  }

}