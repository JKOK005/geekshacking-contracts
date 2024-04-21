// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";
import "openzeppelin-contracts/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "openzeppelin-contracts/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "openzeppelin-contracts/contracts/access/Ownable.sol";

contract HackOMania2024Contract is ERC721, ERC721Enumerable, ERC721URIStorage, Ownable {
    event Mint(address to, uint256 tokenId);

    uint256 private _tokenId;
    mapping(address => bool) private assigned;

    constructor(string memory name, string memory symbol)
        ERC721(name, symbol)
        Ownable(msg.sender)
    {}

    function _increaseBalance(address account, uint128 value)
        internal
        override (ERC721, ERC721Enumerable)
    {
        super._increaseBalance(account, value);
    }

    function _update(address to, uint256 tokenId, address auth)
        internal
        override (ERC721, ERC721Enumerable)
        returns (address)
    {
        return super._update(to, tokenId, auth);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable, ERC721URIStorage)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }

    function safeMint(address to, string memory uri)
        public
        onlyOwner
    {
        require(assigned[to] == false, "Address has already minted");

        uint256 _id = _tokenId;
        _safeMint(to, _id);
        _setTokenURI(_id, uri);
        _tokenId++;
        assigned[to] = true;

        emit Mint(to, _id);
    }

    function safeMintBatch(address[] calldata allTo, string memory uri)
        public
        onlyOwner
    {
        for (uint i = 0; i < allTo.length; i++) {
            safeMint(allTo[i], uri);
        }
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721URIStorage, ERC721)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }
}
