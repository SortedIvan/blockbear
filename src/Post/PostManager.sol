//SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;
import "./PostFactory.sol";

contract PostManager is PostFactory {
    Post[] public posts;

    // users in their feed have posts
    // channels have posts
    // users in channels have posts
    // the general feed can have posts

    //post -> id/owner

    mapping(string => mapping(address => Post[])) accountPostsInChannel;
    mapping(string => Post[]) channelPosts;

    // create modifier to check if the user, creating the post is indeed in the channel
    function createPostInChannel(string memory _channelHandle, string memory _content) external {
        accountPostsInChannel[_channelHandle][msg.sender].push(CreatePost(msg.sender, _content));
        channelPosts[_channelHandle].push(CreatePost(msg.sender, _content));
    }

    function getAllPostsInChannel(string memory _channelHandle) external view returns (Post[] memory) {
        return channelPosts[_channelHandle];
    }

    function getCertainPostFromAccountInChannel(string memory _channelHandle, address _account, uint256 _index) external view returns (Post memory) {
        return accountPostsInChannel[_channelHandle][_account][_index];
    }

    function getAllPostsFromAccountInChannel(string memory _channelHandle, address _account) external view returns (Post[] memory) {
        return accountPostsInChannel[_channelHandle][_account];
    }
}