const {
    time,
    loadFixture
  } = require("@nomicfoundation/hardhat-network-helpers");



const { expect } = require("chai");
const { ethers } = require("hardhat");

//require("@nomiclabs/hardhat-waffle");


describe("Account", function(){
    it("Should add two numbers", async function (){

        const AccountManager = await ethers.getContractFactory("AccountManager");
        const accountManager = await AccountManager.deploy();
        [owner, addr1, addr2] = await ethers.getSigners();
        const contract = await accountManager.deployed();

        const result = await contract.AddNumbers(5,10);
        expect(result).to.equal(15);
    });

    it("Should make the account array of length one after adding an account", async function (){        

        const AccountManager = await ethers.getContractFactory("AccountManager");
        const accountManager = await AccountManager.deploy();
        [owner, addr1, addr2] = await ethers.getSigners();
        const contract = await accountManager.deployed();

        let accounts_before_adding = await contract.GetAccounts();
        expect(accounts_before_adding.length).to.equal(0); // The length of the array should be zero initially

        await contract.SignUp("Ivan");

        let accounts_after_adding = await contract.GetAccounts();
        expect(accounts_after_adding.length).to.equal(1); // The length of the array should be one after adding a person
    });
    
    it("Should create an account with the correct user address and name", async function(){

        const AccountManager = await ethers.getContractFactory("AccountManager");
        const accountManager = await AccountManager.deploy();
        [owner, user1, user2] = await ethers.getSigners();
        const contract = await accountManager.deployed();
        
        //.connect(user1) lets us sign the transaction with an address given by ethers.js
        // {from: owner, value: 5000} is another way of doing this
        await contract.connect(user1).SignUp("Ivan"); // Signing up with the name Ivan and an address given by us by hardhat
        let account = await contract.accountAddressMap(user1.address);
        
        expect(account.accountName).to.equal("Ivan");
        
    });


});