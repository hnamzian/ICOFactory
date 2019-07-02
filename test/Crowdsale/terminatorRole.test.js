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

  it("should fail to set terminator by address is not owner", async () => {
    let revert;
    try {
      await terminator.setTerminator(accounts[1], { from: accounts[2] });
    } catch (ex) {
      revert = ex.message.includes("revert");
    }
    assert.isTrue(revert);
  });
});
