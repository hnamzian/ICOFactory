const WithdrawalWallet = artifacts.require("./WithdrawalWallet.sol");

let withdrawalWallet;

contract("WithdrawalWallet", accounts => {
  beforeEach(async () => {
    withdrawalWallet = await WithdrawalWallet.new();
  });

  it("should set withdrawal wallet address by owner", async () => {
    await withdrawalWallet.setWithdrawalAddress(accounts[1], { from: accounts[0] });
    const walletAddress = await withdrawalWallet.getWithdrawalAddress();
    assert.equal(walletAddress, accounts[1]);
  });

  it("should revert setting withdrawal wallet address by address is not owner", async () => {
    let revert;
    try {
      await withdrawalWallet.setWithdrawalAddress(accounts[1], { from: accounts[2] });
    } catch (ex) {
      revert = ex.message.includes("revert");
    }
    assert.isTrue(revert);
  });
});
