// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.9;
import "./AccoundModel.sol";
    
    /**
        * @title Account Factory
        * @dev The AccountFactory provides an abstraction of account creation
    */
contract AccountFactory {
    /*
        * @dev CreateAccount function takes in the address that called it and returns a new account
        - function is pure as it does not interact with the state variables
    */
    function CreateAccount(string memory accountName, address userAddress) internal pure returns (Account memory){
        Account memory account = Account(
            userAddress,
            accountName,
            true
        );
        return account;
    } 


}