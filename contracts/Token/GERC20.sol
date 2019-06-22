pragma solidity ^0.5.2;

import "openzeppelin-solidity/contracts/token/ERC20/ERC20.sol";
import "openzeppelin-solidity/contracts/token/ERC20/ERC20Burnable.sol";
import "openzeppelin-solidity/contracts/token/ERC20/ERC20Mintable.sol";
import "openzeppelin-solidity/contracts/token/ERC20/ERC20Pausable.sol";
import "openzeppelin-solidity/contracts/token/ERC20/ERC20Capped.sol";
import "openzeppelin-solidity/contracts/token/ERC20/ERC20Detailed.sol";

contract GERC20 is ERC20,
  ERC20Detailed,
  ERC20Burnable,
  ERC20Mintable,
  ERC20Pausable,
  ERC20Capped
{
    bool _isPausable;
    bool _isCapped;

    constructor(
      string memory name,
      string memory symbol,
      uint8 decimals,
      bool isPausable,
      bool isCapped,
      uint256 cap
    ) ERC20Capped(cap)
      ERC20Detailed(name, symbol, decimals) public {
        _isPausable = isPausable;
        _isCapped = isCapped;
        cap = isCapped ? cap : uint256(-1);
    }

    function pause() public onlyPausable {
        super.pause();
    }

    function unpause() public onlyPausable {
        super.unpause();
    }

    modifier onlyPausable() {
        require(_isPausable, "Token is not Pausable");
        _;
    }
}