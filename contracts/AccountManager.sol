// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.9;
import "./AccountFactory.sol";

contract AccountManager is AccountFactory {

    //@dev Null naming convention for simplicity
    //@user All variables and types have 0 as their initial value, 
    //we can compare to NULL variable to check if something exists

    uint8 constant NULL_NR = 0;
    string constant NULL_STR = "";
    address constant NULL_ADDR = address(0);

    event NewAccount(address userAddress, string name);

    mapping(address => Account) public accountAddressMap;
    mapping(string => address) public nameToAddressMap;

    /*
        Checks if an account with this address already exists
        @param userAddress The address of the user, msg.sender
    */
    modifier accountNotExist(address _userAddress){
        require(accountAddressMap[_userAddress].valid == false);
        _;
    }

    /*
        Checks if the account name is available
        @param name The name of the account
    */
    modifier accountNameAvailable(string memory _name){
        require(nameToAddressMap[_name] == NULL_ADDR); // @dev if the address is null for the name, the name is free
        _;
    }

    /*
        Sign up function, lets users create an account
        @param name The name of the account
    */
    function SignUp(string memory name) external accountNotExist(msg.sender) accountNameAvailable(name) {
        Account memory account = CreateAccount(name,msg.sender);
        accountAddressMap[msg.sender] = account;
    }

    /*
        Lets users change their name
        @param _newName The new name specified by the user
    */
    function ChangeName(string memory _newName) external {
        require(accountAddressMap[msg.sender].valid == true);
        accountAddressMap[msg.sender].accountName = _newName;
    }
}