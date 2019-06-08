pragma solidity "0.5.2";

import "openzeppelin-solidity/contracts/ownership/Ownable.sol";

contract WithdrawalCrowdsale is Ownable {
  address private _withdrawManager;

  function setWithdrawManager(address withdrawManager) public onlyOwner {
    _withdrawManager = withdrawManager;
  }
}