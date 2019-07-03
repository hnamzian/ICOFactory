const WithdrawalWallet = artifacts.require("./WithdrawalWallet.sol");

let withdrawalWallet;

contract("WithdrawalWallet", accounts => {
  beforeEach(async () => {
    withdrawalWallet = await WithdrawalWallet.new();
  }); 

})