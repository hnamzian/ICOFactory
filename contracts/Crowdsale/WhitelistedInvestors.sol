pragma solidity "0.5.2";

import "openzeppelin-solidity/contracts/access/Roles.sol";
import "openzeppelin-solidity/contracts/ownership/Ownable.sol";

contract WhitelistedInvestors is Ownable {
  using Roles for Roles.Role;
}