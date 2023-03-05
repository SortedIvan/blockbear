// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.9;
import "./ChannelFactory.sol";
import "./AccessControl.sol";
import "../User/AccoundModel.sol";
import "../Post/PostManager.sol";

contract ChannelManager is ChannelFactory, AccessControl {

    uint32 private constant USER_CHANNEL_LIMIT = 3;

    mapping(string => mapping(address => bool)) isUserFollowingChannel;
    mapping(string => Account[]) allChannelFollowers;
    mapping(address => Channel[]) userOwnedChannels;
    mapping(string => Channel) handleToChannel;

    Channel[] public allChannels;

    event channelCreated(address indexed _from, string _channelName);

    modifier channelAlreadyFollowed(string memory _channelHandle, address _address) {
        require(!isUserFollowingChannel[_channelHandle][msg.sender], "Channel already followed");
        _;
    }

    modifier isChannelExists(string memory _channelHandle){ 
        handleToChannel[_channelHandle].valid
        ? require(handleToChannel[_channelHandle].valid, "Channel does not exist.")
        : require(!handleToChannel[_channelHandle].valid, "Channel already exists"); 
        _;
    }
    
    function followChannel(string memory _channelHandle) external isChannelExists(_channelHandle) channelAlreadyFollowed(_channelHandle, msg.sender){
       isUserFollowingChannel[_channelHandle][msg.sender] = true; // The channel is followed
    }

    function unfollowChannel(string memory _channelHandle) external isChannelExists(_channelHandle) {
        require(isUserFollowingChannel[_channelHandle][msg.sender], "You are not following this channel.");
        isUserFollowingChannel[_channelHandle][msg.sender] = false;
    }

    function getAllUsersInChannel(string memory _channelHandle) external view returns (Account[] memory){
        return allChannelFollowers[_channelHandle];
    }

    function getUsersInChannelCount(string memory _channelHandle) external view returns (uint256){ 
        return allChannelFollowers[_channelHandle].length;
    }

    function getUserOwnedChannels() internal view returns(uint256){
        return userOwnedChannels[msg.sender].length;
    }

    function createNewChannel(string memory _channelName, string memory _channelHandle) external isChannelExists(_channelHandle){
        require(getUserOwnedChannels() <= USER_CHANNEL_LIMIT, "Channel limit reached");

        // If the channel handle is available, we can create the channel
        Channel memory channel = createChannel(_channelName, _channelHandle);
        userOwnedChannels[msg.sender].push(channel); // Create the channel
        handleToChannel[_channelHandle] = channel;

        isUserFollowingChannel[_channelHandle][msg.sender] = true; // Making sure the owner follows his own channel on create
        makeOwner(_channelHandle); // Ensuring that the channel's owner is the msg.sender

        emit channelCreated(msg.sender, _channelName);
    }

    // // @channel_name
    // // the _account that is making the post
    // createNewPost(string memory _channelHandle, address _account) {
    //     Post memory newPost = CreatePost(_account, "test");
    //     //posts.push(newPost);
    // }
}