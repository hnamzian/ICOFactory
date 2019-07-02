pragma solidity "0.5.2";

import "openzeppelin-solidity/contracts/ownership/Ownable.sol";

contract WithdrawalWallet is Ownable {
  address payable _withdrawalAddress;

  event FundWithdrawn(address _withdrawalAddress, uint256 _fund);

  function setWithdrawalAddress(address payable withdrawalAddress) public onlyOwner {
    _withdrawalAddress = withdrawalAddress;
  }

  function getWithdrawalAddress() public view returns (address) {
    return _withdrawalAddress;
  }

}