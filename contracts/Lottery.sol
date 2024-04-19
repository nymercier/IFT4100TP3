// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;



contract Lottery {
    address public owner;
    uint256 private jackPotOdds = 10;

    uint256 private prizePool;
    uint256 private jackPot;
    mapping(address => string) player;
    address[] public players;

    event ANewPlayerEnrolled(string message);

    // temporaire
        event fml(string, address);

    constructor(){   
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Fonction reserver au owner");
        _;
    }
    
    function setJackPotOdds(uint256 newOdds) public onlyOwner {   
        require(newOdds >= 0 && newOdds <= 100);     
        jackPotOdds = newOdds;
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

    function enroleInLottery(string memory playerName) public payable {
       require(msg.value == 1 ether);
       require(bytes(playerName).length > 0);
       require(players.length < 10);
        
        player[msg.sender] = playerName;
        players.push(msg.sender);

        // On garde 10% pour un jackpot potentiel 1 chance sur 10 de frappé le bonus
        prizePool += (msg.value * 90) / 100; 
        jackPot += (msg.value * 9) / 100;       

        emit ANewPlayerEnrolled(string(abi.encodePacked(player[msg.sender], " has enrolled!!! Good luck!")));
    }

    function getParticipants() public view returns(address[] memory){
        return players;
    }

    function getNumberOfParticipants() public view returns(uint){
        return players.length;
    }

    function getAWinner() public view returns(string memory){
        
        
        require(players.length == 10, "We do not have 10 participants yet ");
        uint nbOfPlayers = players.length;
        uint randomHash = uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp)));
        uint winnerIndex = randomHash % nbOfPlayers;

        address winner = players[winnerIndex];   

       //sendPrize(winner);

        //emit fml(player[winner], winner);
        
        return player[winner];
    }

    function getCalculatedPrizePool() public view returns (uint256){
        uint256 effectivePrize;        
        uint randomHash = uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp)));
        bool isJackpot = (randomHash % 100) <= jackPotOdds;

        if(isJackpot){
            effectivePrize = prizePool + jackPot;
        }

        return effectivePrize;
    }
    function sendPrize(address winner) private {
        uint prize = prizePool;
        prizePool = 0;
        payable(winner).transfer(prize);
    }
}