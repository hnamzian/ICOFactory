pragma solidity ^0.5.2;

import "./ProjectOwnerRole.sol";
import "./WhitelistedOracles.sol";
import "./VotingCore.sol";

contract FundRaisingVoting is VotingCore, WhitelistedOracles, ProjectOwnerRole {

}