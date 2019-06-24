const WhitelistedInvestors = artifacts.require("./Crowdsale/WhitelistedInvestors");

contract("WhitelistedInvestors", accounts => {
  let whitelistedInvestors;

  beforeEach(async () => {
    whitelistedInvestors = await WhitelistedInvestors.new();
  });

  it("should add investor to whitelist", async () => {
    await whitelistedInvestors.addInvestor(accounts[1], { from: accounts[0] });
    const isInvestor = await whitelistedInvestors.isInvestor(accounts[1]);
    assert.isTrue(isInvestor);
  });

  it("should remove investor to whitelist", async () => {
    await whitelistedInvestors.addInvestor(accounts[1], { from: accounts[0] });
    await whitelistedInvestors.removeInvestor(accounts[1], { from: accounts[0] });
    const isInvestor = await whitelistedInvestors.isInvestor(accounts[1]);
    assert.isFalse(isInvestor);
  });
});
