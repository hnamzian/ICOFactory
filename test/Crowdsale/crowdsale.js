const GeneralCrowdsale = artifacts.require("./Crowdsale/GeneralCrowdsale");
const GERC20 = artifacts.require("./Token/GERC20");

const now = Math.floor(Date.now() / 1000);
const rounds = [
  {
    opening: now,
    duration: 2,
    tokenWeiPrice: 1,
    tokenCap: 1000,
    minInvest: 10,
    maxInvest: 20
  },
  {
    opening: now + 3,
    duration: 2,
    tokenWeiPrice: 1,
    tokenCap: 1000,
    minInvest: 10,
    maxInvest: 20
  }
];

let token;
let crowdsale;

function sleep(ms) {
  return new Promise(resolve => {
    setTimeout(resolve, ms);
  });
}

contract("Crowdsale", accounts => {
  beforeEach(async () => {
    const crowdsaleArgs = {
      softcap: 1000,
      hardcap: 100000,
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

    await crowdsale.addRound(
      rounds[1].opening,
      rounds[1].duration,
      rounds[1].tokenWeiPrice,
      rounds[1].tokenCap,
      rounds[1].minInvest,
      rounds[1].maxInvest
    );
  });

  it("should buy token", async () => {
    const invest = 20;

    await sleep(10);
    await crowdsale.addInvestor(accounts[1], { from: accounts[0] });
    await crowdsale.buyToken({ from: accounts[1], value: invest });
    const balance = await token.balanceOf(accounts[1]);
    const investOf = await crowdsale.getRoundInvestOf(accounts[1], 0);
    assert.equal(balance, invest / rounds[0].tokenWeiPrice);
    assert.equal(investOf, invest);
  });

  it("should revert buying token more than maximum round invest", async () => {
    let revert;
    const invest = rounds[0].maxInvest + 1;

    await sleep(10);
    await crowdsale.addInvestor(accounts[1], { from: accounts[0] });
    try {
      await crowdsale.buyToken({ from: accounts[1], value: invest });
    } catch (ex) {
      revert = ex.message.includes("revert");
    }

    assert.isTrue(revert);
  });

  it("should revert buying token less than minimum round invest", async () => {
    let revert;
    const invest = rounds[0].minInvest - 1;

    await sleep(10);
    await crowdsale.addInvestor(accounts[1], { from: accounts[0] });
    try {
      await crowdsale.buyToken({ from: accounts[1], value: invest });
    } catch (ex) {
      revert = ex.message.includes("revert");
    }

    assert.isTrue(revert);
  });
  
});
