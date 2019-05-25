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
    bool _isBurnable;
    bool _isPausable;
    bool _isCapped;

    constructor(
      bool isBurnable,
      bool isPausable,
      bool isCapped,
      uint256 cap
    ) ERC20Capped(cap) public {
        _isBurnable = isBurnable;
        _isPausable = isPausable;
        _isCapped = isCapped;
        cap = isCapped ? cap : uint256(-1);
    }

    function burn(uint256 value) public onlyBurnable {
        super.burn(value);
    }

    function burnFrom(address from, uint256 value) public onlyBurnable {
        super.burnFrom(from, value);
    }

    function pause() public onlyPausable {
        super.pause();
    }

    function unpause() public onlyPausable {
        super.unpause();
    }

    modifier onlyBurnable() {
        require(_isBurnable, "Token is not Buranable");
        _;
    }

    modifier onlyPausable() {
        require(_isPausable, "Token is not Pausable");
        _;
    }
}