// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract EvolvingNFT is ERC721URIStorage, Ownable {
    uint256 public tokenCounter;

    // Passez l'adresse initiale au constructeur de Ownable
    constructor() ERC721("EvolvingNFT", "EVNFT") Ownable(msg.sender) {
        tokenCounter = 0;
    }

    function createNFT(string memory initialURI) public onlyOwner returns (uint256) {
        uint256 tokenId = tokenCounter;
        _safeMint(msg.sender, tokenId);
        _setTokenURI(tokenId, initialURI);
        tokenCounter++;
        return tokenId;
    }

    function updateTokenURI(uint256 tokenId, string memory newURI) public onlyOwner {
        require(ownerOf(tokenId) != address(0), "ERC721: URI set of nonexistent token");
        _setTokenURI(tokenId, newURI);
    }
}
