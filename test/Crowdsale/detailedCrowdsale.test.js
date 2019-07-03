const DetailedCrowdsale = artifacts.require("./DetailedCrowdsale.sol");

let detailedCrowdsale;

const softcap = 1;
const hardcap = 1;
const maxIndividualEtherInvest = 1;

contract("WithdrawalWallet", accounts => {
  beforeEach(async () => {
    detailedCrowdsale = await DetailedCrowdsale.new(softcap, hardcap, maxIndividualEtherInvest);
  });
});
