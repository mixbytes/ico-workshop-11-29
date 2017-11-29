pragma solidity ^0.4.15;

import 'zeppelin-solidity/contracts/ownership/Ownable.sol';
import 'zeppelin-solidity/contracts/math/SafeMath.sol';

import './Token.sol';


contract Crowdsale is Ownable {
    using SafeMath for uint;

    enum State {INIT, RUNNING, PAUSED, FAILED, SUCCEEDED}


    modifier requiresState(State state) {
        require(m_state == state);
        _;
    }

    modifier timedStateChange() {
        if (m_state == State.INIT && now >= c_start_time)
            changeState(State.RUNNING);
        _;
    }

    // PUBLIC

    function Crowdsale() public {
        m_token = new Token();
    }

    function() public payable {
        buy();
    }

    function buy()
        public
        payable
        timedStateChange
        requiresState(State.RUNNING)
    {
        // msg.sender sends msg.value ether
        if (now > c_end_time) {
            finish();
            msg.sender.transfer(msg.value);
        }
        else {
            assert(now >= c_start_time && now <= c_end_time);

            uint tokens = msg.value.mul(c_tokens_per_wei);

            require(tokens <= m_token.balanceOf(this));
            m_token.transfer(msg.sender, tokens);
        }
    }


    // INTERNAL

    function changeState(State new_state) internal {
        assert(new_state != m_state);

        if (m_state == State.INIT) {
            assert(new_state == State.RUNNING);
        }
        else if (m_state == State.RUNNING) {
            assert(new_state == State.PAUSED || new_state == State.FAILED || new_state == State.SUCCEEDED);
        }
        else {
            // ...
        }

        m_state = new_state;
    }

    function finish() internal {
        assert(false);
    }


    // FIELDS

    uint public constant c_start_time = 1512086400;
    uint public constant c_end_time = c_start_time + 30 days;

    uint public constant c_tokens_per_wei = 100;

    uint public constant c_soft_cap = 1000 ether;


    Token public m_token;
    State m_state = State.INIT;
}
