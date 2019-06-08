pragma solidity "0.5.2";

import "./BasicCrowdsale.sol";
import "openzeppelin-solidity/contracts/ownership/Ownable.sol";

contract WithdrawalCrowdsale is BasicCrowdsale, Ownable {
  address private _withdrawManager;

  modifier onlyWithdrawManger() {
    require(msg.sender == _withdrawManager, "you are not permitted");
    _;
  }

  function setWithdrawManager(address withdrawManager) public onlyOwner {
    _withdrawManager = withdrawManager;
  }
}