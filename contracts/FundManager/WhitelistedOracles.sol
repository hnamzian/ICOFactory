pragma solidity "0.5.2";

import "openzeppelin-solidity/contracts/access/Roles.sol";
import "openzeppelin-solidity/contracts/ownership/Ownable.sol";

contract WhitelistedOracles is Ownable {
  using Roles for Roles.Role;

  event OracleAdded(address indexed account);
  event OracleRemoved(address indexed account);

  Roles.Role private _Oracles;

  modifier onlyOracle() {
    require(isOracle(msg.sender));
    _;
  }

  function isOracle(address account) public view returns (bool) {
    return _Oracles.has(account);
  }

  function addOracle(address account) public onlyOwner {
    _addOracle(account);
  }

  function removeOracle(address account) public onlyOwner {
    _removeOracle(account);
  }

  function _addOracle(address account) internal {
    _Oracles.add(account);
    emit OracleAdded(account);
  }

  function _removeOracle(address account) internal {
    _Oracles.remove(account);
    emit OracleRemoved(account);
  }
  
}