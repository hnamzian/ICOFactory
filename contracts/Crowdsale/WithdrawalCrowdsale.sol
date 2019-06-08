pragma solidity "0.5.2";

import "./BasicCrowdsale.sol";
import "openzeppelin-solidity/contracts/math/SafeMath.sol";

contract WithdrawalCrowdsale is BasicCrowdsale {
  using SafeMath for uint256;

  address private _withdrawManager;
  address payable _withdrawalAddress;

  uint256 internal _totalWithdrawals;

  event FundWithdrawn(address _withdrawalAddress, uint256 _fund);

  modifier onlyWithdrawManager() {
    require(msg.sender == _withdrawManager, "you are not permitted");
    _;
  }

  function setWithdrawManager(address withdrawManager) public onlyOwner {
    _withdrawManager = withdrawManager;
  }

  function setWithdrawalAddress(address payable withdrawalAddress) public onlyOwner {
    _withdrawalAddress = withdrawalAddress;
  }

  function withdraw(uint256 fund) public onlyWithdrawManager returns (bool) {
    require(_withdrawalAddress != address(0), "Invalid withdrawal Address");
    require(fund < _etherRaised.sub(_remainingFunds), "Insufficient Funds");

    _totalWithdrawals.add(fund);

    _withdrawalAddress.transfer(fund);
    
    emit FundWithdrawn(_withdrawalAddress, fund);

    return true;
  }

}