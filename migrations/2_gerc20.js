const GERC20 = artifacts.require("./Token/GERC20");

module.exports = function(deployer) {
  const name = "JIMMIX";
  const symbol = "JMX";
  const decimals = 3;
  const isBurnable = true;
  const isPausable = true;
  const isCapped = true;
  const cap = 10000000;
  deployer.deploy(GERC20, name, symbol, decimals, isBurnable, isPausable, isCapped, cap);
};
