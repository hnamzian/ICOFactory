pragma solidity ^0.5.2;

import "../utils/bytesUtil.sol";
import "openzeppelin-solidity/contracts/math/SafeMath.sol";

contract VotingCore {
  using SafeMath for uint256;
  using bytesUtils for bytes32;

  enum VotingState {Accepted, Denied}

  struct VotingSession {
    VotingState state;
    bool finalized;
    address createdBy;
    uint256 ending;
    mapping (address => bool) voteOf;
    uint256 positiveVotes;
  }

  mapping (string => VotingSession) votings;
  string[] votingIds;

  function createVoting(uint256 ending) internal returns (string memory) {
    VotingSession memory voting = VotingSession({
      state: VotingState.Denied,
      finalized: false,
      createdBy: msg.sender,
      ending: ending,
      positiveVotes: 0
    });

    bytes32 votingID = keccak256(
      abi.encode(
      voting.state,
      voting.finalized,
      voting.createdBy,
      voting.ending,
      voting.positiveVotes,
      block.timestamp));
    string memory votingIDString = votingID.bytes32ToString();

    votings[votingIDString] = voting;
    votingIds.push(votingIDString);

    return votingIDString;
  }

}