// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.9;
    /*
        User content post
    */
struct Post {
    uint256 id;
    address owner;
    string content;
    uint likesAmount;
    uint commentsAmount;
}
