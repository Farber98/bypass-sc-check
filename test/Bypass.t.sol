// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "../src/VulnerableContract.sol";
import "../src/MaliciousContract1.sol";
import "../src/MaliciousContract2.sol";

contract Reentrancy is Test {
    VulnerableContract vulnerable;
    MaliciousContract1 malicious1;
    MaliciousContract2 malicious2;

    address payable vulnerableContractDeployer1 = payable(address(0x1));
    address payable maliciousContractDeployer2 = payable(address(0x2));

    function setUp() public {
        vm.startPrank(vulnerableContractDeployer1);
        vulnerable = new VulnerableContract();
        vm.stopPrank();

        vm.startPrank(maliciousContractDeployer2);
        malicious1 = new MaliciousContract1();
        vm.stopPrank();
    }

    function testNotBypassing() public {
        vm.startPrank(maliciousContractDeployer2);
        vm.expectRevert("no contract allowed");
        malicious1.pwn(address(vulnerable));
        assertEq(vulnerable.pwned(), false);
        vm.stopPrank();
    }

    function testBypassing() public {
        vm.startPrank(maliciousContractDeployer2);
        malicious2 = new MaliciousContract2(address(vulnerable));
        assertEq(vulnerable.pwned(), true);
        vm.stopPrank();
    }
}
