pragma solidity "0.5.2";

import "openzeppelin-solidity/contracts/access/Roles.sol";
import "openzeppelin-solidity/contracts/ownership/Ownable.sol";

contract WhitelistedVoters is Ownable {
  using Roles for Roles.Role;

  event VoterAdded(address indexed account);
  event VoterRemoved(address indexed account);

  Roles.Role private _Voters;

  modifier onlyVoter() {
    require(isVoter(msg.sender));
    _;
  }

  function isVoter(address account) public view returns (bool) {
    return _Voters.has(account);
  }

  function addVoter(address account) public onlyOwner {
    _addVoter(account);
  }

  function removeVoter(address account) public onlyOwner {
    _removeVoter(account);
  }

  function _addVoter(address account) internal {
    _Voters.add(account);
    emit VoterAdded(account);
  }

  function _removeVoter(address account) internal {
    _Voters.remove(account);
    emit VoterRemoved(account);
  }
  
}