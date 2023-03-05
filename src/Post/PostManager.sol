//SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;
import "./PostFactory.sol";

contract PostManager is PostFactory {
    Post[] public posts;

    // users have posts
    // channels have posts

    //post -> id/owner

    //channels have posts
    mapping(string => mapping(address => Post[])) userPosts;
    mapping(string => mapping(address => mapping(uint => Post))) usersCertainPost;
    mapping(string => Post[]) channelPosts;
}