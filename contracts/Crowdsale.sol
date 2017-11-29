pragma solidity ^0.4.15;

import 'zeppelin-solidity/contracts/ownership/Ownable.sol';

import './Token.sol';


contract Crowdsale is Ownable {
    function Crowdsale(){
        m_token = new Token();
    }

    Token public m_token;
}
