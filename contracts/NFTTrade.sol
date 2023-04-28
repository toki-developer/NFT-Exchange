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

    function createOrder(address _senderNFTContractAddress, uint256 _senderNFTTokenId, address _receiverNFTContractAddress, uint256 _receiverNFTTokenId) public {
        IERC721 orderSenderNFT = IERC721(_senderNFTContractAddress);

        if(orderSenderNFT.getApproved(_senderNFTTokenId) != address(this)) revert();

        myOrder[msg.sender] =  Order(_senderNFTContractAddress, _senderNFTTokenId, _receiverNFTContractAddress, _receiverNFTTokenId);
    }
    function approveOrder(address orderSender) public {

        //TODO: オーダーが存在するか確認

        Order memory order = myOrder[orderSender];
        IERC721 orderSenderNFT = IERC721(order.senderNFTContractAddress);
        IERC721 orderReceiverNFT = IERC721(order.receiverNFTContractAddress);

        //持ち主確認
        //TODO: エラーメッセージ追加
        if(orderSenderNFT.ownerOf(order.senderNFTTokenId) == orderSender) revert();
        if(orderReceiverNFT.ownerOf(order.receiverNFTTokenId) == msg.sender) revert();

        //NFT交換
        //TODO: エラーメッセージ追加
        orderSenderNFT.transferFrom(orderSender, msg.sender, order.senderNFTTokenId);
        orderReceiverNFT.transferFrom(msg.sender, orderSender, order.receiverNFTTokenId);

        delete myOrder[orderSender];
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