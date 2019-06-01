pragma solidity ^0.5.2;

import "../Roles.sol";

contract ProjectOwnerRole {
  using Roles for Roles.Role;

  event ProjectOwnerAdded(address indexed account);
  event ProjectOwnerRemoved(address indexed account);

  Roles.Role private _ProjectOwners;

  constructor () internal {
    _addProjectOwner(msg.sender);
  }

  modifier onlyProjectOwner() {
    require(isProjectOwner(msg.sender));
    _;
  }

  function isProjectOwner(address account) public view returns (bool) {
    return _ProjectOwners.has(account);
  }

  function addProjectOwner(address account) public onlyProjectOwner {
    _addProjectOwner(account);
  }

  function renounceProjectOwner() public {
    _removeProjectOwner(msg.sender);
  }

  function _addProjectOwner(address account) internal {
    _ProjectOwners.add(account);
    emit ProjectOwnerAdded(account);
  }

  function _removeProjectOwner(address account) internal {
    _ProjectOwners.remove(account);
    emit ProjectOwnerRemoved(account);
  }
}
