pragma solidity "0.5.2";

import "./BasicCrowdsale.sol";
import "openzeppelin-solidity/contracts/ownership/Ownable.sol";
import "openzeppelin-solidity/contracts/math/SafeMath.sol";

contract WithdrawalCrowdsale is BasicCrowdsale, Ownable {
  using Safemath for uint256;
  
  address private _withdrawManager;
  address private _withdrawalAddress;

  uint256 private _totalWithdrawals;
  uint256 private _remainingFunds;

  event FundWithdrawn(address _withdrawalAddress, uint256 _fund);

  modifier onlyWithdrawManger() {
    require(msg.sender == _withdrawManager, "you are not permitted");
    _;
  }

  function setWithdrawManager(address withdrawManager) public onlyOwner {
    _withdrawManager = withdrawManager;
  }

  function setWithdrawalAddress(address withdrawalAddress) public onlyOwner {
    _withdrawalAddress = withdrawalAddress;
  }

  function withdraw(uint256 fund) public onlyWithdrawManager returns (bool) {
    require(_withdrawalAddress != address(0), "Invalid withdrawal Address");
    _withdrawalAddress.transfer(fund);
    
    FundWithdrawn(_withdrawalAddress, fund);

    return true;
  }
  
}