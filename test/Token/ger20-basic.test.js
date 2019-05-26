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
  it("should mint token for account[1]", async () => {
    let token = await GERC20.deployed(
      tokenArgs.name,
      tokenArgs.symbol,
      tokenArgs.decimals,
      tokenArgs.isBurnable,
      tokenArgs.isPausable,
      tokenArgs.isCapped,
      tokenArgs.cap
    );
    await token.mint(accounts[1], 1, { from: accounts[0] });
    const balance = await token.balanceOf(accounts[1]);
    assert.equal(+balance, 1);
  });
});
