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
    await token.burn(1, { from: accounts[1] });
    const balance = await token.balanceOf(accounts[1]);
    assert.equal(+balance, 0);
  });

  it("should revert burning tokens more than owner's balance", async () => {
    await token.mint(accounts[1], 1, { from: accounts[0] });
    try {
      await token.burn(2, { from: accounts[1] });
    } catch (ex) {
      revert = ex.message.includes("revert");
    }
    assert.equal(revert, true);
    
    const balance = await token.balanceOf(accounts[1]);
    assert.equal(+balance, 1);
  });

  it("should burn approved tokens by allowed account", async () => {
    await token.mint(accounts[1], 1, { from: accounts[0] });
    await token.approve(accounts[2], 1, { from: accounts[1] });
    await token.burnFrom(accounts[1], 1, { from: accounts[2] });
    const balance = await token.balanceOf(accounts[1]);
    const allowance = await token.allowance(accounts[1], accounts[2]);
    assert.equal(+balance, 0);
    assert.equal(+allowance, 0);
  });

  it("should revert burning more than approved tokens by allowed account", async () => {
    await token.mint(accounts[1], 1, { from: accounts[0] });
    await token.approve(accounts[2], 1, { from: accounts[1] });

    try {
      await token.burnFrom(accounts[1], 2, { from: accounts[2] });
    } catch (ex) {
      revert = ex.message.includes("revert");
    }
    assert.equal(revert, true);
    
    const balance = await token.balanceOf(accounts[1]);
    const allowance = await token.allowance(accounts[1], accounts[2]);

    assert.equal(+balance, 1);
    assert.equal(+allowance, 1);
  });
  
});
