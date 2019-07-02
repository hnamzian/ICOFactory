pragma solidity "0.5.2";

import "openzeppelin-solidity/contracts/ownership/Ownable.sol";

contract WithdrawManagerRole is Ownable {
  address private _withdrawManager;

  modifier onlyWithdrawManager() {
    require(msg.sender == _withdrawManager, "you are not permitted");
    _;
  }

  function setWithdrawManager(address withdrawManager) public onlyOwner {
    _withdrawManager = withdrawManager;
  }

  function getWithdrawalManager() public view returns (address) {
    return _withdrawManager;
  }

}