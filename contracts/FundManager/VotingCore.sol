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
    uint256 minVotesConsensus;
    uint256 positiveVotes;
  }

  mapping (string => VotingSession) votings;
  string[] votingIds;

  function createVoting(uint256 ending, uint256 minVotesConsensus) internal returns (string memory) {
    VotingSession memory voting = VotingSession({
      state: VotingState.Denied,
      finalized: false,
      createdBy: msg.sender,
      ending: ending,
      minVotesConsensus: minVotesConsensus,
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

  function vote(string memory _votingId, bool _vote) internal {
    VotingSession storage voting = votings[_votingId];
    require(block.timestamp <= voting.ending, "Invalid Voting session to vote");

    if(voting.voteOf[msg.sender] != _vote) {
      voting.voteOf[msg.sender] = _vote;
      if(_vote) voting.positiveVotes = voting.positiveVotes.add(1);
      else voting.positiveVotes = voting.positiveVotes.sub(1);
    }
  }

  function setVoteConsensus(string memory _votingId) internal {
    VotingSession storage voting = votings[_votingId];
    require(voting.createdBy != address(0), "Invalid voting session");
    if (voting.positiveVotes >= voting.minVotesConsensus) voting.state = VotingState.Accepted;
    voting.state = VotingState.Denied;
  }

}