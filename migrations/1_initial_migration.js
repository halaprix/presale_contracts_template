const TokenSale = artifacts.require("TokenSale");

module.exports = function (deployer) {
  deployer.deploy(TokenSale, 5000, "0x8F94E1323Be5810Dbd13F7D41B11f813CeAa09e4", "0x6A4813F50751291732EFE9936cc0C4b13F974739");
};
