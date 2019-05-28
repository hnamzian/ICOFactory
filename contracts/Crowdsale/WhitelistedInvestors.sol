pragma solidity "0.5.2";

import "openzeppelin-solidity/contracts/access/Roles.sol";
import "openzeppelin-solidity/contracts/ownership/Ownable.sol";

contract WhitelistedInvestors is Ownable {
  using Roles for Roles.Role;

  event InvestorAdded(address indexed account);
  event InvestorRemoved(address indexed account);

  Roles.Role private _investors;

  function addInvestor(address account) public onlyOwner {
    _addInvestor(account);
  }

  function _addInvestor(address account) internal {
    _investors.add(account);
    emit InvestorAdded(account);
  }

  function _removeInvestor(address account) internal {
    _investors.remove(account);
    emit InvestorRemoved(account);
  }
  
}