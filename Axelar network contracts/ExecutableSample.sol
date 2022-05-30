// SPDX-License-Identifier: MIT

pragma solidity 0.8.9;

import { IAxelarExecutable } from './IAxelarExecutable.sol';
contract ExecutableSample is IAxelarExecutable {
    string public value;
    string public sourceChain;
    string public sourceAddress;
    string public destinationChain;
    string public destinationAddress;
    AxelarGasReceiver gasReceiver;

    constructor(address gateway_) IAxelarExecutable(gateway_) {
    }

    function setDestinationChain (string _chain) public view returns(bool){
        destinationChain = _chain;
        return true;
    }

    function setDestinationAddress (string _address) public view returns(bool){
        destinationAddress = _address;
        return true;
    }

    function callSendToken (uint256 amount, string symbol) public{
        gateway.sendToken(destinationChain, destinationAddress, symbol, amount);
    }


    function _execute (
        string memory sourceChain_,
        string memory sourceAddress_, 
        bytes calldata payload_
    ) internal override {
        (value) = abi.decode(payload_, (string));
        sourceChain = sourceChain_;
        sourceAddress = sourceAddress_;
    }
}