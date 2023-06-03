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
    // test pushing

    mapping(address => Account) public accountAddressMap;
    mapping(string => address) public nameToAddressMap;
    Account[] public accounts;

    function GetAccounts() external view returns (Account[] memory){
        return accounts;
    }

    function SignUp(string memory _name) external {
        require(accountAddressMap[msg.sender].valid == false); // Checks if the account name is available
        require(nameToAddressMap[_name] == NULL_ADDR); // @dev if the address is null for the name, the name is free

        Account memory account = CreateAccount(_name,msg.sender);
        accounts.push(account);
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

    /* Getter for usernames */
    function GetUsername() external view returns (string memory){
        return accountAddressMap[msg.sender].accountName;
    }

    /*Testing function to see whether ethers.js works correctly for the testing environment*/
    function AddNumbers(uint a, uint b) public pure returns(uint){
        return a + b;
    }
}