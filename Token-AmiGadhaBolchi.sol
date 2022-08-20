// contracts/AmiGadhaBolchi.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract AmiGadhaBolchi is ERC721 {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIdTracker;

    string private _ipfsUrl;
    uint private _totalSupply;

    constructor(string memory ipfsUrl, uint totalSupply) ERC721("AmiGadhaBolchi", "AGB") {
        _ipfsUrl = ipfsUrl;
        _totalSupply = totalSupply;

        for (uint128 i = 0; i < totalSupply; i++) {
            mint();
        }
    }

    function mint() private {
        address to = _msgSender();
        _mint(to, _tokenIdTracker.current());
        _tokenIdTracker.increment();
    }

    function baseTokenURI() public view returns (string memory) {
        return _ipfsUrl;
    }

    function tokenURI(uint tokenId) override public view virtual returns (string memory) {
        return _ipfsUrl;
    }
}
