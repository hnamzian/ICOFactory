pragma solidity ^0.5.2;

import "../Token/GERC20.sol";

contract TokenLauncher {

  event TokenLaunched(
  address tokenAddress,
  string name,
  string symbol,
  uint8 decimals,
  bool isBurnable,
  bool isPausable,
  bool isCapped,
  uint256 cap);

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