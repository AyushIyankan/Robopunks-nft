// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.4;

import '@openzepplin/contracts/token/ERC721/ERC721.sol';
import '@openzepplin/contracts/access/Ownable.sol';

contract Robopunk is ERC721, Ownable {
    uint256 public mintPrice;
    uint256 public totalSupply;
    uint256 public maxSupply;
    uint256 public maxPerWallet;
    bool public isPublicMintEnabled;
    string internal baseTokenUrl;
    address payable public withdrawWallet;
    mapping(address => uint256) public walletMints;

    constructor() payable ERC721('RoboPunks', 'RP') {
        mintPrice = 0.02 ether;
        totalSupply = 0;
        maxSupply = 1000;
        maxperWallet = 3;
        // withdrawWallet = 

    }

    function isPublicMintEnabled(bool isPublicMintEnabled_) external onlyOwner {
        isPublicMintEnabled = isPublicMintEnabled_;
    }

    function setBaseTokenUrl(string calldata baseTokenUrl_) external onlyOwner {
        baseTokenUrl = baseTokenUrl_;
    }

    function tokenURI(uint256 tokenId) public view returns (string memory) {
        require(_exists(tokenId_), 'Token does not exist!');
        return string(abi.encodePacked(baseTokenUri, String.toString(tokenId_), ".json"));
    }

    function witdraw() external onlyOwner {
        (bool success, ) = withdrawWallet.call{ value : address(this).balance }('');
        require(success, 'withdraw failed');
    }
}