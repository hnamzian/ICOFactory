pragma solidity "0.5.2";

import "openzeppelin-solidity/contracts/math/SafeMath.sol";

contract DetailedCrowdsale {
  using SafeMath for uint256;

  uint256 internal _softcap;
  uint256 internal _hardcap;
  uint256 internal _maxIndividualEtherInvest;

  constructor(
    uint256 softcap, 
    uint256 hardcap, 
    uint256 maxIndividualEtherInvest) public {
    _softcap = softcap;
    _hardcap = hardcap;
    _maxIndividualEtherInvest = maxIndividualEtherInvest;
  }

  function getSoftcap() public view returns (uint256) {
    return _softcap;
  }

}