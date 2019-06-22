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
  it("should mint token for account[1]", async () => {
    let token = await GERC20.new(
      tokenArgs.name,
      tokenArgs.symbol,
      tokenArgs.decimals,
      tokenArgs.isPausable,
      tokenArgs.isCapped,
      tokenArgs.cap
    );

    await token.mint(accounts[1], 1, { from: accounts[0] });
    const balance = await token.balanceOf(accounts[1]);
    assert.equal(+balance, 1);
  });

  it("should transfer token", async () => {
    let token = await GERC20.new(
      tokenArgs.name,
      tokenArgs.symbol,
      tokenArgs.decimals,
      tokenArgs.isPausable,
      tokenArgs.isCapped,
      tokenArgs.cap
    );

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
    let token = await GERC20.new(
      tokenArgs.name,
      tokenArgs.symbol,
      tokenArgs.decimals,
      tokenArgs.isPausable,
      tokenArgs.isCapped,
      tokenArgs.cap
    );

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

  it("should approve and transferFrom tokens", async () => {
    let token = await GERC20.new(
      tokenArgs.name,
      tokenArgs.symbol,
      tokenArgs.decimals,
      tokenArgs.isPausable,
      tokenArgs.isCapped,
      tokenArgs.cap
    );

    const minter = accounts[0];
    const from = accounts[1];
    const spender = accounts[2];
    const to = accounts[3];
    const amount = 10;
    const approval = 5;
    const spends = 5;

    await token.mint(from, amount, { from: minter });

    await token.approve(spender, approval, { from });
    const allowance = await token.allowance(from, spender);
    assert.equal(+allowance, approval);

    const fromOriginBalance = await token.balanceOf(from);
    const toOriginBalance = await token.balanceOf(to);
    await token.transferFrom(from, to, spends, { from: spender });
    const fromFinalBalance = await token.balanceOf(from);
    const toFinalBalance = await token.balanceOf(to);

    assert.equal(+fromOriginBalance - +fromFinalBalance, spends);
    assert.equal(+toFinalBalance - +toOriginBalance, spends);
  });

  it("should throw error to spende more than allowance", async () => {
    let token = await GERC20.new(
      tokenArgs.name,
      tokenArgs.symbol,
      tokenArgs.decimals,
      tokenArgs.isPausable,
      tokenArgs.isCapped,
      tokenArgs.cap
    );

    const minter = accounts[0];
    const from = accounts[1];
    const spender = accounts[2];
    const to = accounts[3];
    const amount = 10;
    const approval = 5;
    const spends = 10;
    let revert;

    await token.mint(from, amount, { from: minter });
    await token.approve(spender, approval, { from });

    try {
      await token.transferFrom(from, to, spends, { from: spender });
    } catch (ex) {
      revert = ex.message.includes("revert");
    }
    assert.equal(revert, true);
  });
});
