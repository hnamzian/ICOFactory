const GERC20 = artifacts.require("./Token/GERC20");

const tokenArgs = {
  name: "JIMMIX",
  symbol: "JMX",
  decimals: 3,
  isPausable: true,
  isCapped: true,
  cap: 10000000
};

contract("GERC20", accounts => {
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

  it("should revert minting tokens more than cap", async () => {
    let revert;

    try {
      await token.mint(accounts[1], tokenArgs.cap + 1, { from: accounts[0] });
    } catch (ex) {
      revert = ex.message.includes("revert");
    }
    assert.equal(revert, true);
  });
});
