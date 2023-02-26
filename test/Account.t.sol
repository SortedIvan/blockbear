// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/AccountManager.sol";

contract AccountManagerTest is Test {
    AccountManager public accountManager;

    function setUp() public {
        accountManager = new AccountManager();
    }

    function testCreateAccount() public {
        address someRandomUser = vm.addr(1); // Get a random address for a user
        assertEq(accountManager.GetAccounts().length, 0);// Should be 0 before adding a user
        vm.prank(someRandomUser);
        // Create a new account
        accountManager.SignUp("Ivan");
        assertEq(accountManager.GetAccounts().length, 1); // Should be one after adding a user
    }

    function testGetAccountByAddress() public {
        address someRandomUser = vm.addr(1); // Get a random address for a user

        // For this to appear within the console, we need to run the test with more verbosity
        // address test = address(accountManager);
        // console.log(test);
        vm.prank(someRandomUser); // Make sure the signup function is called with the address 
        // Create a new account
        accountManager.SignUp("Ivan");

        vm.prank(someRandomUser); // Make sure that the getter function is done with the same user
        string memory username = accountManager.GetUsername();
        assertEq(username, "Ivan");
    }
}
