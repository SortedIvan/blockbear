// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.9;

contract ChannelFactory {

    string NULL_STRING = "";
    struct Channel {
        address channelCreator;
        string channelName;
        string channelHandle; // Must be unique @thecoolchannel for example
        bool valid;
    }

    function createChannel(string memory channelName, string memory channelHandle) internal view returns(Channel memory){
        // Making sure that the provided channel name and handle are not empty
        require(keccak256(abi.encodePacked(channelHandle)) != keccak256(abi.encodePacked(NULL_STRING)));
        require(keccak256(abi.encodePacked(channelName)) != keccak256(abi.encodePacked(NULL_STRING)));
        return Channel(
          msg.sender,
          channelName,
          string.concat("@",channelHandle),
          true
        );
    }
    
}
