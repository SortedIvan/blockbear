// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.9;

contract PostFactory {

    /*
        User content post
    */
    struct Post {
        address owner;
        string content;
        uint likesAmount;
        uint commentsAmount;
    }

    /*
        An abstraction over creating user posts
        @param _owner The address of the post owner
        @param _content The content of the post
    */
    function CreatePost(address _owner, string memory _content) internal pure returns (Post memory) {
        Post memory post = Post(
            _owner,
            _content,
            0,
            0
        );
        return post;
    }
}