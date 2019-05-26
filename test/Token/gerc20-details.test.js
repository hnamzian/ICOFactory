const GERC20 = artifacts.require("./Token/GERC20");

const tokenArgs = {
  name: "JIMMIX",
  symbol: "JMX",
  decimals: 3,
  isBurnable: true,
  isPausable: true,
  isCapped: true,
  cap: 10000000
};

contract("GERC20", accounts => {
  it("should check token name", async () => {
    let token = await GERC20.deployed(
      tokenArgs.name,
      tokenArgs.symbol,
      tokenArgs.decimals,
      tokenArgs.isBurnable,
      tokenArgs.isPausable,
      tokenArgs.isCapped,
      tokenArgs.cap
    );
    const name = await token.name.call();
    assert.equal(name, tokenArgs.name);
  });

  it("should check token symbol", async () => {
    let token = await GERC20.deployed();
    const symbol = await token.symbol.call();
    assert.equal(symbol, tokenArgs.symbol);
  });

  it("should check token decimals", async () => {
    let token = await GERC20.deployed();
    const decimals = await token.decimals.call();
    assert.equal(decimals, tokenArgs.decimals);
  });
});
