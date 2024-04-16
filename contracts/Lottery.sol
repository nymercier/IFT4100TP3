// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

contract Lottery {
 
    uint private storedData;
    address[] public participantList;

    address immutable player1;

    constructor(){
        player1 = 0xbE934830a53E59159de1ff923e927308D4FDc650;
    }

    function set(uint  data) public {
        storedData = data;
    }
    function get() public view returns (uint) {
        return storedData;
    }
    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
    function enroleInLottery() external payable {
        require(msg.value == 1 ether);
        participantList.push(msg.sender);
    }
    function getParticipants() public view returns(address[] memory){
        return participantList;
    }
}