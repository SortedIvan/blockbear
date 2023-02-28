// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.9;
import "./ChannelFactory.sol";

contract ChannelManager is ChannelFactory {

    uint32 USER_CHANNEL_LIMIT = 3;

    mapping(address => Channel[]) userChannels;
    mapping(string => bytes32) handleToChannel;

    event ChannelCreated(address indexed _from, string _channelName);

    function CreateNewChannel(string memory _channelName, string memory channelHandle) external {
        require(CheckChannelHandleAvailable(channelHandle) == false, "Channel name already taken.");
        require(GetUserChannelCount() <= USER_CHANNEL_LIMIT, "Channel limit reached");
        // If the channel handle is available, we can create the channel
        Channel memory channel = CreateChannel(_channelName, channelHandle);
        userChannels[msg.sender].push(channel); // Create the channel
        handleToChannel[channel.channelHandle] = channel.channel_id;

        emit ChannelCreated(msg.sender, _channelName);
    }

    function GetUserChannelCount() internal view returns(uint){
        return userChannels[msg.sender].length;
    }

    function CheckChannelHandleAvailable(string memory channelHandle) view internal returns(bool){
        if (keccak256(abi.encodePacked(handleToChannel[channelHandle])) == keccak256(abi.encodePacked(bytes32(0)))){
            return true;
        }
        return false;
    }
   
}