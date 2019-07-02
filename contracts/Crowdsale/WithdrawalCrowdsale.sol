pragma solidity "0.5.2";

import "./BasicCrowdsale.sol";
import "./WithdrawManagerRole.sol";
import "openzeppelin-solidity/contracts/math/SafeMath.sol";

contract WithdrawalCrowdsale is BasicCrowdsale, WithdrawManagerRole {
  using SafeMath for uint256;

  address payable _withdrawalAddress;

  event FundWithdrawn(address _withdrawalAddress, uint256 _fund);

  function setWithdrawalAddress(address payable withdrawalAddress) public onlyOwner {
    _withdrawalAddress = withdrawalAddress;
  }

  function getWithdrawalAddress() public view returns (address) {
    return _withdrawalAddress;
  }

  function withdraw(uint256 fund) public onlyWithdrawManager returns (bool) {
    require(_withdrawalAddress != address(0), "Invalid withdrawal Address");
    require(fund < _etherRaised.sub(_totalWithdrawals), "Insufficient Funds");

    _totalWithdrawals = _totalWithdrawals.add(fund);

    _withdrawalAddress.transfer(fund);
    
    emit FundWithdrawn(_withdrawalAddress, fund);

    return true;
  }

}