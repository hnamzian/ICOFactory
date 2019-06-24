const WhitelistedInvestors = artifacts.require("./Crowdsale/WhitelistedInvestors");

contract("WhitelistedInvestors", accounts => {
  let whitelistedInvestors;

  beforeEach(async () => {
    whitelistedInvestors = await WhitelistedInvestors.new();
  });
});
