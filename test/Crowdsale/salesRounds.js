const SlaesRounds = artifacts.require("./Crowdsale/SalesRound");

contract("SalesRounds", accounts => {
  beforeEach(async () => {
    salesRounds = await SlaesRounds.new()
  })
})