// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.9;
import "./AccountFactory.sol";

contract AccountManager is AccountFactory{

    //@dev Null naming convention for simplicity
    //@user All variables and types have 0 as their initial value, 
    //we can compare to NULL variable to check if something exists

    uint8 constant NULL_NR = 0;
    string constant NULL_STR = "";


    event NewAccount(address userAddress, string name);

    mapping(address => Account) public accountAddressMap;
    mapping(string => address) public nameToAddressMap;

    //@dev for simplicity & clean code, modifiers for account requirements
    modifier accountNotExist(address userAddress){
        require(accountAddressMap[userAddress].valid == false);
        _;
    }

    modifier accountNameAvailable(string memory name, address userAddress){
        require(nameToAddressMap[name] == address(0)); // @dev if the address is null for the name, the name is free
        _;
    }
    //end account requirements

}