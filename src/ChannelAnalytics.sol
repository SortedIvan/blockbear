// SPDX-License-Identifier: CC-BY-SA-4.0
pragma solidity ^0.8.7;

contract ChannelAnalytics {

    bytes32 public constant OWNER = keccak256(abi.encodePacked("OWNER"));
    bytes32 public constant ADMIN = keccak256(abi.encodePacked("ADMIN"));
    bytes32 public constant USER = keccak256(abi.encodePacked("USER"));
    bytes32 public constant NONE = keccak256(abi.encodePacked("NONE"));

    event GrantRole(bytes32 indexed role, address indexed account, string channelHandle);
    event AcceptRole(bytes32 indexed role, address indexed account, string channelHandle);
    event RevokeRole(bytes32 indexed role, address indexed account, string channelHandle);

    mapping(string => mapping(address => bytes32)) public invitedToRole;
    mapping(string => mapping(address => bytes32)) public rolesInChannel;

    modifier onlyOwnerAndAdmin(string memory _channelHandle) {
        bytes32 _tempRole = rolesInChannel[_channelHandle][msg.sender];
        require(_tempRole == ADMIN || _tempRole == OWNER, "Only admin can assign roles!");
        _;
    }

    constructor(string memory _channelHandle) {
        invitedToRole[_channelHandle][msg.sender] = OWNER;
    }

    function acceptRole(string memory _channelHandle) external {
        rolesInChannel[_channelHandle][msg.sender] = invitedToRole[_channelHandle][msg.sender];
        invitedToRole[_channelHandle][msg.sender] = NONE;
        emit AcceptRole(rolesInChannel[_channelHandle][msg.sender], msg.sender, _channelHandle);
    }

    function getUserRoleByChannel(string memory _channelHandle) external view returns (bytes32) {
        return invitedToRole[_channelHandle][msg.sender];
    }

    function grantRole(bytes32 _role, address _account, string memory _channelHandle) external onlyOwnerAndAdmin(_channelHandle) {
        invitedToRole[_channelHandle][_account] = _role;
        emit GrantRole(_role, _account, _channelHandle);
    }

    function revokeRole(bytes32 _role, address _account, string memory _channelHandle) external onlyOwnerAndAdmin(_channelHandle) {
        rolesInChannel[_channelHandle][_account] = NONE;
        emit RevokeRole(_role, _account, _channelHandle);
    }
}