const WithdrawManager = artifacts.require("./WithdrawManagerRole.sol");

let withdrawManger;

contract("WitdrawMangerRole", accounts => {
  beforeEach(async () => {
    withdrawManger = await WithdrawManager.new();
  });

});
