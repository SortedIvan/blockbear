//SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract FactoryNFT is ERC721URIStorage {

    uint256 public tokenCount;
    mapping(address => uint256) public accounts;
    mapping(address => uint256[]) public images;
    mapping(string => bool) public imageExists;

    constructor() ERC721("BlockBearProfileImage", "BPI") {}

    function add(uint256 a, uint256 b) private pure returns (uint256) {
        uint256 c = a + b;
        assert(c >= a);
        return c;
    }

    function createProfilePictureNFT(string memory _tokenURI) external returns (uint256) {
        require(!imageExists[_tokenURI], "Image URI already exists!");

        tokenCount = add(1, tokenCount); //@dev first, increment the token_uri so the supply starts from 1
        _safeMint(msg.sender, tokenCount);
        _setTokenURI(tokenCount, _tokenURI);
        setProfilePictureNFT(tokenCount);
        images[msg.sender].push(tokenCount);
        imageExists[_tokenURI] = true;

        return (tokenCount);
    }

    function setProfilePictureNFT(uint256 _id) public {
        require(ownerOf(_id) == msg.sender, "You must own the NFT, to select it as your profile picture!");
        accounts[msg.sender] = _id;
    }

    function getAllProfilePictureIds() external view returns (uint256[] memory _ids) {
        return images[msg.sender];
    }
}