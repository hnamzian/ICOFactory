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
  bytes32[] votingIds;

  function createVoting(uint256 ending) internal returns (bytes32) {
    VotingSession memory _voting = VotingSession({
      state: VotingState.Denied,
      finalized: false,
      createdBy: msg.sender,
      ending: ending,
      positiveVotes: 0
    });

    bytes32 votingID = keccak256(
      abi.encode(
      _voting.state,
      _voting.finalized,
      _voting.createdBy,
      _voting.ending,
      _voting.positiveVotes,
      block.timestamp));

    votingIds.push(votingID);

    return votingID;
  }
}