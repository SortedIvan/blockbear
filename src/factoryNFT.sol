//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract FactoryNFT is ERC721URIStorage {
    uint256 public tokenCount;
    mapping(address => uint256) public profiles;

    constructor() ERC721("BlockBearProfileImage", "BPI") {}

    function createProfilePicuteNFT(string memory _tokenURI) external returns (uint256) {
        tokenCount++;
        _safeMint(msg.sender, tokenCount);
        _setTokenURI(tokenCount, _tokenURI);
        setProfilePictureNFT(tokenCount);
        return (tokenCount);
    }

    function setProfilePictureNFT(uint256 _id) public {
        require(ownerOf(_id) == msg.sender, "You must own the NFT, to select it as your profile picture!");
        profiles[msg.sender] = _id;
    }

    function getAllProfilePicturesNFT() external view returns (uint256[] memory _ids) {
        _ids = new uint256[](balanceOf(msg.sender));
        uint256 currentIndex;
        uint256 _tokenCount = tokenCount;
        for (uint256 i = 0; i < _tokenCount; i++) {
            if (ownerOf(i + 1) == msg.sender) {
                _ids[currentIndex] = i + 1;
                currentIndex++;
            }
        }
    }
}