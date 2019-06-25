const SalesRounds = artifacts.require("./Crowdsale/SalesRounds");

function sleep(ms) {
  return new Promise(resolve => {
    setTimeout(resolve, ms);
  });
}

contract("SalesRounds", accounts => {
  beforeEach(async () => {
    salesRounds = await SalesRounds.new();
  });

  it("should add a new sales rounds", async () => {
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
        tokenWeiPrice: 2,
        tokenCap: 2000,
        minInvest: 15,
        maxInvest: 25
      }
    ];

    await salesRounds.addRound(
      rounds[0].opening,
      rounds[0].duration,
      rounds[0].tokenWeiPrice,
      rounds[0].tokenCap,
      rounds[0].minInvest,
      rounds[0].maxInvest
    );
    await salesRounds.addRound(
      rounds[1].opening,
      rounds[1].duration,
      rounds[1].tokenWeiPrice,
      rounds[1].tokenCap,
      rounds[1].minInvest,
      rounds[1].maxInvest
    );

    await sleep(10);
    let tokenWeiPrice = await salesRounds.getTokenWeiPrice({ from: accounts[0] });
    assert.equal(+tokenWeiPrice, rounds[0].tokenWeiPrice);

    await sleep(4000);
    tokenWeiPrice = await salesRounds.getTokenWeiPrice({ from: accounts[0] });
    assert.equal(+tokenWeiPrice, rounds[1].tokenWeiPrice);
  });
});
