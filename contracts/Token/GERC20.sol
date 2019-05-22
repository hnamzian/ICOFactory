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
  bool isMintable;
  bool isBurnable;
  bool isPausable;
  bool isCapped;

  constructor(
    string _name,
    string _symbol,
    uint256 _totalSupply,
    uint256 _decimals,
    bool _isMintable,
    bool _isBurnable,
    bool _isPausable,
    bool _isCapped,
    uint256 _cap
  ) ERC20Capped(cap) public {}
}