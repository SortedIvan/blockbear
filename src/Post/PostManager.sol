//SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;
import "./PostFactory.sol";

contract PostManager is PostFactory {
    Post[] public posts;

    // users have posts
    // channels have posts

    //post -> id/owner

    // @channel => 0x123 => all the posts of 0x123
    mapping(string => mapping(address => Post[])) userPosts;
    // @channel => all the posts in a channel
    mapping(string => Post[]) channelPosts;

    // create modifier to check if the user, creating the post is indeed in the channel
    function createPostInChannel(string memory _channelHandle, string memory _content) external {
        userPosts[_channelHandle][msg.sender].push(CreatePost(msg.sender, _content));
        channelPosts[_channelHandle].push(CreatePost(msg.sender, _content));
    }

    function getAllPostsInChannel(string memory _channelHandle) external view returns (Post[] memory) {
        return channelPosts[_channelHandle];
    }

    function getCertainPostFromAccountInChannel(string memory _channelHandle, address _account, uint256 _index) external view returns (Post memory) {
        return userPosts[_channelHandle][_account][_index];
    }

    function getAllPostsFromAccountInChannel(string memory _channelHandle, address _account) external view returns (Post[] memory) {
        return userPosts[_channelHandle][_account];
    }
}