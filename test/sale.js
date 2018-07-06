'use strict';

const Sale = artifacts.require("./Crowdsale.sol");
const Token = artifacts.require("./Token.sol");
const l = console.log;

contract('Crowdsale', function(accounts) {

    function getRoles() {
        return {
            owner: accounts[1],
            investor1: accounts[2],
            investor2: accounts[3],
            nobody: accounts[4]
        };
    }

    it("test state changes", async function() {
        const role = getRoles();

        const instance = await Sale.new({from: role.owner});
        const token = Token.at(await instance.m_token());

        const balance = await token.balanceOf(role.investor1);
        assert(balance == 0);

        await instance.sendTransaction({from: role.investor1, value: web3.toWei(10, 'finney')});

        assert((await token.balanceOf(role.investor1)) == 0); // sale is over
    });
});
