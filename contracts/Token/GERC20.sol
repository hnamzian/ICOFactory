pragma solidity ^0.5.2;

import "openzeppelin-solidity/contracts/token/ERC20/ERC20.sol";
import "openzeppelin-solidity/contracts/token/ERC20/ERC20Burnable.sol";
import "openzeppelin-solidity/contracts/token/ERC20/ERC20Mintable.sol";
import "openzeppelin-solidity/contracts/token/ERC20/ERC20Pausable.sol";
import "openzeppelin-solidity/contracts/token/ERC20/ERC20Capped.sol";

contract GERC20 is ERC20,
  ERC20Burnable,
  ERC20Mintable,
  ERC20Pausable,
  ERC20Capped
{
    bool _isMintable;
    bool _isBurnable;
    bool _isPausable;
    bool _isCapped;

    constructor(
      uint256 totalSupply,
      bool isMintable,
      bool isBurnable,
      bool isPausable,
      bool isCapped,
      uint256 cap
    ) ERC20Capped(cap) public {
        if (!isMintable) require(totalSupply > 0, "totalSupply must be greater than 0");
        _isMintable = isMintable;
        _isBurnable = isBurnable;
        _isPausable = isPausable;
        _isCapped = isCapped;
        cap = isCapped ? cap : uint256(-1);
    }

    function mint(address to, uint256 value) public onlyMintable returns (bool) {
        super.mint(to, value);
    }

    function burn(uint256 value) public onlyBurnable {
        super.burn(value);
    }

    function burnFrom(address from, uint256 value) public onlyBurnable {
        super.burnFrom(from, value);
    }

    modifier onlyMintable() {
        require(_isMintable, "Token is not Mintable");
        _;
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