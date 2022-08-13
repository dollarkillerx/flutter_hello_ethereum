// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract HelloWorld {
    string public yourName;

    /* Constructor */
    constructor() {
        yourName = "Unknown";
    }

    function setName(string memory nm) public {
        yourName = nm;
    }
}
