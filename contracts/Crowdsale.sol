pragma solidity ^0.4.15;

import 'zeppelin-solidity/contracts/ownership/Ownable.sol';

import './Token.sol';


contract Crowdsale is Ownable {

    enum State {INIT, RUNNING, PAUSED, FAILED, SUCCEEDED}


    modifier requiresState(State state) {
        require(m_state == state);
        _;
    }

    // PUBLIC

    function Crowdsale(){
        m_token = new Token();
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


    // FIELDS

    Token public m_token;
    State m_state = State.INIT;
}
