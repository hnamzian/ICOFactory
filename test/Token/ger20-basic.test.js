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

  it("should transfer token", async () => {
    let token = await GERC20.deployed();
    const from = accounts[1];
    const to = accounts[2];

    await token.mint(accounts[1], 1, { from: accounts[0] });
    let fromOriginBalance = await token.balanceOf(from);
    let toOriginBalance = await token.balanceOf(accounts[2]);

    await token.transfer(to, 1, { from });
    let fromFinalBalance = await token.balanceOf(from);
    let toFinalBalance = await token.balanceOf(to);

    assert.equal(+fromOriginBalance - +fromFinalBalance, 1);
    assert.equal(+toFinalBalance - +toOriginBalance, 1);
  });

  it("should throw error on transferring more than owned balance", async () => {
    let token = await GERC20.deployed();
    const from = accounts[1];
    const to = accounts[2];
    let revert;

    await token.mint(accounts[1], 1, { from: accounts[0] });
    let fromOriginBalance = await token.balanceOf(from);
    try {
      await token.transfer(to, +fromOriginBalance + 1, { from });
    } catch (ex) {
      revert = ex.message.includes("revert");
    }
    assert.equal(revert, true);
  });
});
