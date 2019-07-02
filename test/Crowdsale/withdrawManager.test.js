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

  it("should revert setting whitdraw manager by address is not owner", async () => {
    let revert;
    try {
      await withdrawManger.setWithdrawManager(accounts[1], { from: accounts[2] });
    } catch (ex) {
      revert = ex.message.includes("revert");
    }
    assert.isTrue(revert);
  });
});
