const DetailedCrowdsale = artifacts.require("./DetailedCrowdsale.sol");

let detailedCrowdsale;

const softcap = 1;
const hardcap = 1;
const maxIndividualEtherInvest = 1;

contract("WithdrawalWallet", accounts => {
  beforeEach(async () => {
    detailedCrowdsale = await DetailedCrowdsale.new(softcap, hardcap, maxIndividualEtherInvest);
  });

  it("should get softcap", async () => {
    const _softcap = await detailedCrowdsale.getSoftcap()
    assert.equal(_softcap, softcap);
  })

  it("should get hardcap", async () => {
    const _hardcap = await detailedCrowdsale.getHardcap()
    assert.equal(_hardcap, hardcap);
  })

});
