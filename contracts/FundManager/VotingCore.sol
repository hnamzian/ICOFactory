pragma solidity ^0.5.2;

import "openzeppelin-solidity/contracts/math/SafeMath.sol";

contract VotingCore {
  using SafeMath for uint256;

  enum VotingState {Accepted, Denied}

  struct VotingSession {
    VotingState state;
    bool finalized;
    address createdBy;
    uint256 ending;
    mapping (address => bool) voteOf;
    uint256 positiveVotes;
  }

  mapping (bytes32 => VotingSession) votings;
  uint8[] votingIds;
}