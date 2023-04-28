// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "hardhat/console.sol";

contract NFTExchange {

    mapping(address => Order) private myOrder;

    struct Order {
        address senderNFTContractAddress;
        uint256 senderNFTTokenId;
        address receiverNFTContractAddress;
        uint256 receiverNFTTokenId;
    }

    event OrderCreated(address indexed sender, address indexed senderNFTContractAddress, uint256 senderNFTTokenId, address indexed receiverNFTContractAddress, uint256 receiverNFTTokenId);
    event OrderApproved(address indexed sender, address indexed approver);

    function createOrder(address _senderNFTContractAddress, uint256 _senderNFTTokenId, address _receiverNFTContractAddress, uint256 _receiverNFTTokenId) public {
        if(IERC721(_senderNFTContractAddress).getApproved(_senderNFTTokenId) != address(this)) revert("NFT you hold is not approve");

        myOrder[msg.sender] =  Order(_senderNFTContractAddress, _senderNFTTokenId, _receiverNFTContractAddress, _receiverNFTTokenId);
        emit OrderCreated(msg.sender, _senderNFTContractAddress, _senderNFTTokenId, _receiverNFTContractAddress, _receiverNFTTokenId);
    }
    function approveOrder(address orderSender) public {
        if(myOrder[orderSender].senderNFTContractAddress == address(0)) revert("Order Not Found");

        Order memory order = myOrder[orderSender];
        IERC721 orderSenderNFT = IERC721(order.senderNFTContractAddress);
        IERC721 orderReceiverNFT = IERC721(order.receiverNFTContractAddress);

        if(orderSenderNFT.ownerOf(order.senderNFTTokenId) == orderSender) revert("Order Registrant does not have this NFT");
        if(orderReceiverNFT.ownerOf(order.receiverNFTTokenId) == msg.sender) revert("You do not have this NFT");

        orderSenderNFT.transferFrom(orderSender, msg.sender, order.senderNFTTokenId);
        orderReceiverNFT.transferFrom(msg.sender, orderSender, order.receiverNFTTokenId);

        delete myOrder[orderSender];
        emit OrderApproved(orderSender, msg.sender);
    }

    function getOrder(address orderSender) public view returns(Order memory) {
        return myOrder[orderSender];
    }

}

abstract contract IERC721 {
    function getApproved(uint256 tokenId) virtual external view returns (address operator) ;
    function ownerOf(uint256 tokenId) virtual external view returns (address owner);
    function transferFrom(address from, address to, uint256 tokenId) virtual external;

}