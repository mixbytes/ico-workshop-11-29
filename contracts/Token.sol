pragma solidity ^0.4.15;

import 'zeppelin-solidity/contracts/token/StandardToken.sol';


contract Token is StandardToken {

    function Token() public {
        balances[msg.sender] = uint(1e9) * (uint(10) ** uint(decimals));
    }

    string public constant name = "Workshop token";
    string public constant symbol = "WSH";
    uint8 public constant decimals = 18;
}
