const TerminatorManager = artifacts.require("./TerminatorRole.sol");

let terminator;

contract("WitdrawMangerRole", accounts => {
  beforeEach(async () => {
    terminator = await TerminatorManager.new();
  });
});
