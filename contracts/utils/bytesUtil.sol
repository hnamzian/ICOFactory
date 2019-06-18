pragma solidity ^0.5.2;

library bytesUtils {
  function bytes32ToBytes(bytes32 _bytes32) public view returns (bytes memory) {
    bytes memory bytesArray = new bytes(32);
    for (uint256 i; i < 32; i++) {
      bytesArray[i] = _bytes32[i];
    }
    return bytesArray;
  }
}