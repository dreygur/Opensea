// contracts/AmiGadhaBolchi.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract AmiGadhaBolchiR is ERC721, Ownable {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIdTracker;

    string private _ipfsUrl;
    uint private _totalSupply;

    modifier maxOwnable {
        _maxOwnable();
        _;
    }

    constructor(string memory _ipfsUri, uint _maxSupply) ERC721("AmiGadhaBolchiR", "AGB") {
        _ipfsUrl = _ipfsUri;
        _totalSupply = _maxSupply;

        /// Set default

        for (uint128 i = 0; i < _totalSupply; i++) {
            mint();
            // _setTokenURI(i, _ipfsUri);
        }
    }

    function _maxOwnable() internal view virtual {
        require(balanceOf(msg.sender) == 0, "Each address may only own one Token");
    }

    function transferOwnership(address newOwner) override public virtual onlyOwner maxOwnable {
        // require(newOwner != address(0), "Ownable: new owner is the zero address");
        super.transferOwnership(newOwner);
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

    function totalSupply() public view virtual returns (uint) {
        return _totalSupply;
    }

    /// Overrides
    function approve(address to, uint256 tokenId) override public virtual maxOwnable {
        _approve(to, tokenId);
    }

    function transferFrom(address from, address to, uint tokenId) override public virtual maxOwnable {
        super.transferFrom(from, to, tokenId);
    }

    function safeTransferFrom(address from, address to, uint tokenId) override public virtual maxOwnable {
        super.safeTransferFrom(from, to, tokenId);
    }

    function mintTo(address _to) public onlyOwner maxOwnable {
        uint256 currentTokenId = _tokenIdTracker.current();
        _tokenIdTracker.increment();
        _safeMint(_to, currentTokenId);
    }

}
