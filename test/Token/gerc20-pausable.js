const GERC20 = artifacts.require("./Token/GERC20");

const tokenArgs = {
  name: "JIMMIX",
  symbol: "JMX",
  decimals: 3,
  isPausable: true,
  isCapped: true,
  cap: 10000000
};

contract("GERC20 - pausable", accounts => {
  let token;

  beforeEach(async () => {
    token = await GERC20.new(
      tokenArgs.name,
      tokenArgs.symbol,
      tokenArgs.decimals,
      tokenArgs.isPausable,
      tokenArgs.isCapped,
      tokenArgs.cap
    );
  });

  it("should revert transfering token when contract is paused", async () => {
    let revert;

    await token.mint(accounts[1], 1);
    await token.pause({ from: accounts[0] });
    try {
      await token.transfer(accounts[2], 1, { from: accounts[1] });
    } catch (ex) {
      revert = ex.message.includes("revert");
    }
    assert.equal(revert, true);
  });
});
