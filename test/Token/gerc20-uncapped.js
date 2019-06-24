const GERC20 = artifacts.require("./Token/GERC20");

contract("GERC20 - uncapped", accounts => {
  let token;

  const tokenArgs = {
    name: "JIMMIX",
    symbol: "JMX",
    decimals: 3,
    isPausable: true,
    isCapped: false,
    cap: 10000000
  };

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

  it("should mint tokens for each amount at uncapped case", async () => {
    const mintedTokens = tokenArgs.cap + 1;

    await token.mint(accounts[1], mintedTokens, { from: accounts[0] });
    const totalSupply = await token.totalSupply.call();
    assert.equal(+totalSupply, mintedTokens);
  });
});
