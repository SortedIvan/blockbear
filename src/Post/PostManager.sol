//SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;
import "./PostFactory.sol";



contract PostManager is PostFactory {
    mapping(string => mapping(address => Post[])) accountPostsInChannel;
    mapping(string => Post[]) channelPosts;
    mapping(string => mapping(address => mapping(uint256 => Post))) usersCertainPost;

    // create modifier to check if the user, creating the post is indeed in the channel
    function createPostInChannel(string memory _channelHandle, string memory _content) external {
        uint256 _tempPostCount = channelPosts[_channelHandle].length;
        Post memory post = CreatePost(msg.sender, _content,_tempPostCount);

        accountPostsInChannel[_channelHandle][msg.sender].push(post);
        channelPosts[_channelHandle].push(post);
        usersCertainPost[_channelHandle][msg.sender][_tempPostCount] = post;
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