// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import {Test} from "forge-std/Test.sol";
import {DeployToken} from "script/DeployToken.s.sol";
import {DeveloperToken} from "src/DevToken.sol";

contract DtTest is Test {
    DeveloperToken public developerToken;
    DeployToken public deployer;

    address public owner;
    address bob = makeAddr("bob");
    address alice = makeAddr("alice");
    address charlie = makeAddr("charlie");

    uint256 public constant INITIAL_SUPPLY = 1000 ether;
    uint256 public constant STARTING_BALANCE = 100 ether;

    function setUp() public {
        deployer = new DeployToken();
        developerToken = deployer.run();
        owner = address(msg.sender);

        // Transfer some tokens to test accounts
        vm.prank(owner);
        developerToken.transfer(bob, STARTING_BALANCE);
    }

    // Basic Token Information Tests
    function testTokenName() public view {
        assertEq(developerToken.name(), "Developer's Token");
    }

    function testTokenSymbol() public view {
        assertEq(developerToken.symbol(), "DT");
    }

    function testTokenDecimals() public view {
        assertEq(developerToken.decimals(), 18);
    }

    function testInitialSupply() public view {
        assertEq(developerToken.totalSupply(), INITIAL_SUPPLY);
    }

    function testOwnerBalance() public view {
        uint256 expectedOwnerBalance = INITIAL_SUPPLY - STARTING_BALANCE;
        assertEq(developerToken.balanceOf(owner), expectedOwnerBalance);
    }

    function testBobBalance() public view {
        assertEq(developerToken.balanceOf(bob), STARTING_BALANCE);
    }

    // Transfer Tests
    function testTransfer() public {
        uint256 transferAmount = 10 ether;
        
        vm.prank(bob);
        bool success = developerToken.transfer(alice, transferAmount);
        
        assertTrue(success);
        assertEq(developerToken.balanceOf(bob), STARTING_BALANCE - transferAmount);
        assertEq(developerToken.balanceOf(alice), transferAmount);
    }

    function testTransferFailsWithInsufficientBalance() public {
        uint256 transferAmount = STARTING_BALANCE + 1;
        
        vm.prank(bob);
        vm.expectRevert();
        developerToken.transfer(alice, transferAmount);
    }

    function testTransferToZeroAddress() public {
        vm.prank(bob);
        vm.expectRevert();
        developerToken.transfer(address(0), 10 ether);
    }

    function testTransferEmitsEvent() public {
        uint256 transferAmount = 10 ether;
        
        vm.prank(bob);
        vm.expectEmit(true, true, false, true);
        emit Transfer(bob, alice, transferAmount);
        developerToken.transfer(alice, transferAmount);
    }

    // Approval Tests
    function testApprove() public {
        uint256 approvalAmount = 50 ether;
        
        vm.prank(bob);
        bool success = developerToken.approve(alice, approvalAmount);
        
        assertTrue(success);
        assertEq(developerToken.allowance(bob, alice), approvalAmount);
    }

    function testApproveEmitsEvent() public {
        uint256 approvalAmount = 50 ether;
        
        vm.prank(bob);
        vm.expectEmit(true, true, false, true);
        emit Approval(bob, alice, approvalAmount);
        developerToken.approve(alice, approvalAmount);
    }

    // TransferFrom Tests
    function testTransferFrom() public {
        uint256 approvalAmount = 50 ether;
        uint256 transferAmount = 30 ether;
        
        // Bob approves Alice to spend tokens
        vm.prank(bob);
        developerToken.approve(alice, approvalAmount);
        
        // Alice transfers from Bob to Charlie
        vm.prank(alice);
        bool success = developerToken.transferFrom(bob, charlie, transferAmount);
        
        assertTrue(success);
        assertEq(developerToken.balanceOf(bob), STARTING_BALANCE - transferAmount);
        assertEq(developerToken.balanceOf(charlie), transferAmount);
        assertEq(developerToken.allowance(bob, alice), approvalAmount - transferAmount);
    }

    function testTransferFromFailsWithInsufficientAllowance() public {
        uint256 approvalAmount = 30 ether;
        uint256 transferAmount = 50 ether;
        
        vm.prank(bob);
        developerToken.approve(alice, approvalAmount);
        
        vm.prank(alice);
        vm.expectRevert();
        developerToken.transferFrom(bob, charlie, transferAmount);
    }

    function testTransferFromFailsWithInsufficientBalance() public {
        uint256 transferAmount = STARTING_BALANCE + 1;
        
        vm.prank(bob);
        developerToken.approve(alice, transferAmount);
        
        vm.prank(alice);
        vm.expectRevert();
        developerToken.transferFrom(bob, charlie, transferAmount);
    }

    function testTransferFromEmitsEvent() public {
        uint256 approvalAmount = 50 ether;
        uint256 transferAmount = 30 ether;
        
        vm.prank(bob);
        developerToken.approve(alice, approvalAmount);
        
        vm.prank(alice);
        vm.expectEmit(true, true, false, true);
        emit Transfer(bob, charlie, transferAmount);
        developerToken.transferFrom(bob, charlie, transferAmount);
    }

    // Edge Case Tests
    function testTransferZeroAmount() public {
        vm.prank(bob);
        bool success = developerToken.transfer(alice, 0);
        
        assertTrue(success);
        assertEq(developerToken.balanceOf(bob), STARTING_BALANCE);
        assertEq(developerToken.balanceOf(alice), 0);
    }

    function testApproveZeroAmount() public {
        vm.prank(bob);
        bool success = developerToken.approve(alice, 0);
        
        assertTrue(success);
        assertEq(developerToken.allowance(bob, alice), 0);
    }

    function testMultipleApprovals() public {
        vm.prank(bob);
        developerToken.approve(alice, 100 ether);
        
        vm.prank(bob);
        developerToken.approve(alice, 50 ether);
        
        assertEq(developerToken.allowance(bob, alice), 50 ether);
    }

    // Fuzz Tests
    function testFuzzTransfer(uint256 amount) public {
        amount = bound(amount, 0, STARTING_BALANCE);
        
        vm.prank(bob);
        bool success = developerToken.transfer(alice, amount);
        
        assertTrue(success);
        assertEq(developerToken.balanceOf(bob), STARTING_BALANCE - amount);
        assertEq(developerToken.balanceOf(alice), amount);
    }

    function testFuzzApprove(uint256 amount) public {
        amount = bound(amount, 0, type(uint256).max);
        
        vm.prank(bob);
        bool success = developerToken.approve(alice, amount);
        
        assertTrue(success);
        assertEq(developerToken.allowance(bob, alice), amount);
    }

    // Events (for reference in expectEmit calls)
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
}
