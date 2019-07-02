const WithdrawManager = artifacts.require("./WithdrawManagerRole.sol");

let withdrawManger;

contract("WitdrawMangerRole", accounts => {
  beforeEach(async () => {
    withdrawManger = await WithdrawManager.new();
  });

  it("should set whitdraw manager by owner", async () => {
    await withdrawManger.setWithdrawManager(accounts[1], { from: accounts[0] });
    const manager = await withdrawManger.getWithdrawalManager();
    assert.equal(manager, accounts[1]);
  });
});
