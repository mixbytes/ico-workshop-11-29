const Sale = artifacts.require("./Crowdsale.sol");

module.exports = function(deployer) {
  deployer.deploy(Sale);
};
