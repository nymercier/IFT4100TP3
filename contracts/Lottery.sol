// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

contract Lottery {
    
    uint256 private prizePool;
    uint256 private jackPot;

    mapping(address => uint) player;
    address[] public players;

    constructor(){   
    }
    
    function getPricePool() public view returns (uint) {
        return prizePool;
    }

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }

    function getJackPot() public view returns (uint) {
        return jackPot;
    }

    function enroleInLottery() public payable {
       require(msg.value == 1 ether || msg.value == 2);
        
        player[msg.sender] = msg.value;
        players.push(msg.sender);

        // On garde 10% pour un jackpot potentiel p-e? 1 chance sur 1000 de frappé le bonus
        prizePool += (msg.value * 90) / 100; 
        jackPot += (msg.value * 9) / 100;             
    }

    function getParticipants() public view returns(address[] memory){
        return players;
    }

    function getAWinner() public returns(address){
        uint nbOfPlayers = players.length;
        uint randomHash = uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp)));
        uint winnerIndex = randomHash % nbOfPlayers;

        address winner = players[winnerIndex];
        return winner;
    }

    function sendPrize(address winner) private {
        uint prize = prizePool;
        prizePool = 0;
        payable(winner).transfer(prize);
    }
}