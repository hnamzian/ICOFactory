pragma solidity ^0.5.2;

library strutil {
  function concat(string memory str1, string memory str2) public pure returns (string memory) {
    bytes memory str1Bytes = bytes(str1);
    bytes memory str2Bytes = bytes(str2);
    string memory mergedString = new string(str1Bytes.length + str2Bytes.length);
    bytes memory mergedStringBytes = bytes(mergedString);
    uint k = 0;
    for (uint i = 0; i < str1Bytes.length; i++) mergedStringBytes[k++] = str1Bytes[i];
    for (uint i = 0; i < str2Bytes.length; i++) mergedStringBytes[k++] = str2Bytes[i];
    return string(mergedStringBytes);
  }
}