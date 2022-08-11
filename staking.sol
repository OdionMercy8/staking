// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;
   
contract staking{
    mapping(address => uint) balances;

    uint timeReached;

    event events(address sender, uint balance);

    function stake() public payable {
        uint timeForCount = block.timestamp + 5 minutes;
        timeReached = timeForCount;

        require(msg.value > 0, 'no amount available');
        balances[msg.sender] += msg.value;

        emit events(msg.sender, msg.value);
    }


    function withdraw() public{
        require(block.timestamp > timeReached, 'not matured');
        require(balances[msg.sender] > 0, 'no amount');

        payable(msg.sender).transfer(balances[msg.sender]);
    }

    function showStake() external returns(uint){

    }

    receive() external payable{
        stake();
    }

    function timeLeft() external view returns(uint){
        return timeReached - block.timestamp;
    }
}   