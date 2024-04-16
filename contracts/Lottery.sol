// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

contract Lottery {
     
    address[] public participantList;
    uint256 private pricePool;
    uint256 private jackPot;

    address immutable player1;

    constructor(){
        player1 = 0xbE934830a53E59159de1ff923e927308D4FDc650;
    }
    
    function getPricePool() public view returns (uint) {
        return pricePool;
    }

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }

    function enroleInLottery() external payable {
        require(msg.value == 1 ether);
        
        // On garde 10% pour un jackpot potentiel p-e? 1 chance sur 1000 de frappé le bonus
        pricePool += (msg.value * 90) / 100; 
        jackPot += (msg.value * 9) / 100;
        participantList.push(msg.sender);        
    }

    function getParticipants() public view returns(address[] memory){
        return participantList;
    }
}