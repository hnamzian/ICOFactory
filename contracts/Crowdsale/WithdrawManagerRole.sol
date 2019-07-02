pragma solidity "0.5.2";

import "openzeppelin-solidity/contracts/ownership/Ownable.sol";

contract WithdrawManagerRole is Ownable {
  address private _withdrawManager;

}