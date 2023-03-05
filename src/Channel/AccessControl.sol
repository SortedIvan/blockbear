// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.7;

contract AccessControl {

    uint8 public constant OWNER = 3;
    uint8 public constant ADMIN = 2;
    uint8 public constant USER = 1;
    uint8 public constant NONE = 0;

    event MakeOwnerEvent(uint8 indexed role, address indexed account, string channelHandle);
    event GrantRoleEvent(uint8 indexed role, address indexed account, string channelHandle);
    event AcceptRoleEvent(uint8 indexed role, address indexed account, string channelHandle);
    event RevokeRoleEvent(uint8 indexed role, address indexed account, string channelHandle);

    mapping(string => mapping(address => uint8)) public invitedToRole;
    mapping(string => mapping(address => uint8)) public rolesInChannel;

    constructor (){ 
        rolesInChannel["@test"][msg.sender] = 3;
    }

    modifier isOwner(string memory _channelHandle) {
        require(rolesInChannel[_channelHandle][msg.sender] == OWNER, "Account is not an owner");
        _;
    }

    modifier isUser(string memory _channelHandle, address _account) {
        require(rolesInChannel[_channelHandle][_account] == USER, "Account is not a user");
        _;
    }

    modifier onlyOwnerAndAdmin(string memory _channelHandle) {
        require((rolesInChannel[_channelHandle][msg.sender] == ADMIN) || 
                (rolesInChannel[_channelHandle][msg.sender] == OWNER), 
                "Only owner and admin can assign roles!");
        _;
    }

    modifier onlyNotOwner(string memory _channelHandle, address _account) {
        require(rolesInChannel[_channelHandle][_account] != OWNER, "You cannot revoke role of the owner!");
        _;
    }

    modifier isAdmin(string memory _channelHandle, address _account) {
        require(rolesInChannel[_channelHandle][_account] == ADMIN, "This account isn't an admin!");
        _;
    }

    function makeOwner(string memory _channelHandle) internal{
        rolesInChannel[_channelHandle][msg.sender] = OWNER;
        emit MakeOwnerEvent(OWNER, msg.sender, _channelHandle);
    }

    function demoteAdminToUser(string memory _channelHandle, address _account) external isOwner(_channelHandle) isAdmin(_channelHandle,_account){
        rolesInChannel[_channelHandle][_account] = USER;
    }

    function demoteAdminToNone(string memory _channelHandle, address _account) external isOwner(_channelHandle) isAdmin(_channelHandle,_account){
        rolesInChannel[_channelHandle][_account] = NONE;
    }

    function demoteUserToNone(string memory _channelHandle, address _account) external onlyOwnerAndAdmin(_channelHandle) isUser(_channelHandle, _account){
        rolesInChannel[_channelHandle][_account] = NONE;
    }

    function acceptRole(string memory _channelHandle) external {
        rolesInChannel[_channelHandle][msg.sender] = invitedToRole[_channelHandle][msg.sender];
        invitedToRole[_channelHandle][msg.sender] = NONE;
        emit AcceptRoleEvent(rolesInChannel[_channelHandle][msg.sender], msg.sender, _channelHandle);
    }

    function getUserRoleByChannel(string memory _channelHandle) external view returns (uint8) {
        return rolesInChannel[_channelHandle][msg.sender];
    }

    function grantRole(uint8 _role, address _account, string memory _channelHandle) external onlyOwnerAndAdmin(_channelHandle) {
        invitedToRole[_channelHandle][_account] = _role;
        emit GrantRoleEvent(_role, _account, _channelHandle);
    }
}