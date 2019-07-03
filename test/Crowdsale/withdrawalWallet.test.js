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
});
