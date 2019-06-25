const GeneralCrowdsale = artifacts.require("./Crowdsale/GeneralCrowdsale");
const GERC20 = artifacts.require("./Token/GERC20");

const now = Math.floor(Date.now() / 1000);
const rounds = [
  {
    opening: now,
    duration: 10,
    tokenWeiPrice: 1,
    tokenCap: 1000,
    minInvest: 10,
    maxInvest: 25
  }
];

const crowdsaleArgs = {
  softcap: 15,
  hardcap: 20,
  maxIndividualEtherInves: 30
};

const tokenArgs = {
  name: "JIMMIX",
  symbol: "JMX",
  decimals: 3,
  isPausable: true,
  isCapped: true,
  cap: 10000000
};

let token;
let crowdsale;

function sleep(ms) {
  return new Promise(resolve => {
    setTimeout(resolve, ms);
  });
}

contract("FinalizableCrowdsale", accounts => {
  beforeEach(async () => {
    token = await GERC20.new(
      tokenArgs.name,
      tokenArgs.symbol,
      tokenArgs.decimals,
      tokenArgs.isPausable,
      tokenArgs.isCapped,
      tokenArgs.cap
    );

    crowdsale = await GeneralCrowdsale.new(
      token.address,
      crowdsaleArgs.softcap,
      crowdsaleArgs.hardcap,
      crowdsaleArgs.maxIndividualEtherInves
    );

    await token.addMinter(crowdsale.address, { from: accounts[0] });

    await crowdsale.addRound(
      rounds[0].opening,
      rounds[0].duration,
      rounds[0].tokenWeiPrice,
      rounds[0].tokenCap,
      rounds[0].minInvest,
      rounds[0].maxInvest
    );
  });

  it("should finalize crowdsale for invest more than hardcap", async () => {
    const invest = crowdsaleArgs.hardcap;

    await sleep(100);
    await crowdsale.addInvestor(accounts[1], { from: accounts[0] });
    await crowdsale.buyToken({ from: accounts[1], value: invest });
    await crowdsale.finalize();
    const isFinalized = await crowdsale.isFinalized();
    assert.isTrue(isFinalized);
  });

  it("should finalize crowdsale for invest more than softcap", async () => {
    const invest = crowdsaleArgs.softcap;

    await sleep(100);
    await crowdsale.addInvestor(accounts[1], { from: accounts[0] });
    await crowdsale.buyToken({ from: accounts[1], value: invest });
    await sleep(10000);
    await crowdsale.finalize();
    const isFinalized = await crowdsale.isFinalized();
    assert.isTrue(isFinalized);
  });
});
