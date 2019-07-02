const TerminatorManager = artifacts.require("./TerminatorRole.sol");

let terminator;

contract("WitdrawMangerRole", accounts => {
  beforeEach(async () => {
    terminator = await TerminatorManager.new();
  });

  it("should set terminator address by owner", async () => {
    await terminator.setTerminator(accounts[1], { from: accounts[0] });
    const terminatorAddress = await terminator.getTerminator();
    assert.equal(terminatorAddress, accounts[1]);
  });
});
