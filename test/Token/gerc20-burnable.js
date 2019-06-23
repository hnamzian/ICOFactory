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

  it("should burn tokens by token owner", async () => {
    await token.mint(accounts[1], 1, { from: accounts[0] });
    await token.burn(1, { from: accounts[1] })
    const balance = await token.balanceOf(accounts[1]);
    assert.equal(+balance, 0);
  })
})