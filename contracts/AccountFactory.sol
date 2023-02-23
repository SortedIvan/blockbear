// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.9;
    
    /**
        * @title Account Factory
        * @dev The AccountFactory provides an abstraction of account creation
    */
contract AccountFactory {

    struct Account {
        address accountAddress;
        string accountName;
    }

    /*
        * @dev CreateAccount function takes in the address that called it and 
    */
    function CreateAccount(string memory accountName, address userAddress) public pure returns (Account memory){
        Account memory account = Account(
            userAddress,
            accountName
        );
        return account;
    } 


}