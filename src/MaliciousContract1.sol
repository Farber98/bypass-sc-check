// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract MaliciousContract1 {
    // Attempting to call Target.protected will fail,
    // Target block calls from contract
    function pwn(address _target) external {
        // This will fail
        Target(_target).protected();
    }
}
