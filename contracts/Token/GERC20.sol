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
    _isMintable = isMintable;
    _isBurnable = isBurnable;
    _isPausable = isPausable;
    _isCapped = isCapped;
    cap = cap;
  }

  function mint(address to, uint256 value) public onlyMinter returns (bool) {
    super.mint(to, value);
  }

  modifier onlyMintable() {
    require(_isMintable, "Token is not Mintable");
    _;
  }

  modifier onlyBurnable() {
    require(_isBurnable, "Token is not Buranable");
    _;
  }

  modifier onlyCapped() {
    require(_isCapped, "Token is not Capped");
    _;
  }

  modifier onlyPausable() {
    require(_isPausable, "Token is not Pausable");
    _;
  }
}