// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Minter is ERC721, Ownable {
    //Price create one
    uint256 public mintPrice= 0.05 ether;

    //Minted nfts
    uint256 public totalSupply;

    //Max minted nfts
    uint256 public maxSupply;

    //Mint boolean enable
    bool public MintEnable;

    mapping(address => uint256) public mintedWallets;

    constructor () payable ERC721("Name","Symbol"){
        maxSupply=5;
    }

    function toggleIsMintEnabled () external onlyOwner{
        MintEnable = !MintEnable;
    }

    function setMaxSupply(uint256 _maxSupply) external onlyOwner{
        maxSupply=_maxSupply;
    }

    function mit() external payable{
        require(MintEnable,"Mint not enabled");
        require(mintedWallets[msg.sender]<1, "You cant mint more than one token");
        require(msg.value >= mintPrice, "Not enought Ethereum");
        require(maxSupply > totalSupply, "Max supply achieve");

        mintedWallets[msg.sender]++;
        totalSupply++;

        uint256 tokenId = totalSupply;

        _safeMint(msg.sender, tokenId);
    }
}