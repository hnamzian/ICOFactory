pragma solidity "0.5.2";

import "openzeppelin-solidity/contracts/access/Roles.sol";
import "openzeppelin-solidity/contracts/ownership/Ownable.sol";
import "openzeppelin-solidity/contracts/math/SafeMath.sol";

contract WhitelistedOracles is Ownable {
  using SafeMath for uint256;
  using Roles for Roles.Role;

  event OracleAdded(address indexed account);
  event OracleRemoved(address indexed account);

  Roles.Role private _Oracles;

  uint256 _numberOfOracles;

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
    _numberOfOracles = _numberOfOracles.add(1);
    emit OracleAdded(account);
  }

  function _removeOracle(address account) internal {
    _Oracles.remove(account);
    _numberOfOracles = _numberOfOracles.sub(1);
    emit OracleRemoved(account);
  }
  
}