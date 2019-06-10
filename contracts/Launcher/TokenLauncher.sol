pragma solidity ^0.5.2;

import "../Token/GERC20.sol";

contract TokenLauncher {

  function launchToken(
    string memory name,
    string memory symbol,
    uint8 decimals,
    bool isBurnable,
    bool isPausable,
    bool isCapped,
    uint256 cap) public {
    new GERC20(name, symbol, decimals, isBurnable, isPausable, isCapped, cap);
  }

}