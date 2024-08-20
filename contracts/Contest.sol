// File: contracts/eVote.sol
// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

contract Contest{
	
	struct Contestant{
		uint id;
		string name;
		uint voteCount;
		string party;
		uint age;
		string qualification;
	}

	struct Voter{
		bool hasVoted;
		uint vote;
		bool isRegistered;
	}

	address admin;
	mapping(uint => Contestant) public contestants; 
   // mapping(address => bool) public voters;
    mapping(address => Voter) public voters;
	uint public contestantsCount;
	// uint public counter;
	enum PHASE{reg, voting , done}
	PHASE public state;

	modifier onlyAdmin(){
		require(msg.sender==admin);
		_;
	}
	
	modifier validState(PHASE x){
	    require(state==x);
	    _;
	}

	constructor(){
		admin=msg.sender;
        state=PHASE.reg;
		// counter = 0;

	}

    function changeState(PHASE x) onlyAdmin public{
		require(x > state);
        state = x;
    }

	function addContestant(string memory _name , string memory _party , uint _age , string memory _qualification) public onlyAdmin validState(PHASE.reg){
		contestantsCount++;
		contestants[contestantsCount]=Contestant(contestantsCount,_name,0,_party,_age,_qualification);
	}

	function voterRegisteration(string memory _user) public onlyAdmin validState(PHASE.reg){
		address _voter_addr = parseAddr(_user);
		voters[_voter_addr].isRegistered=true;
	}

	function parseAddr(string memory _a) internal pure returns (address _parsedAddress) {
		bytes memory tmp = bytes(_a);
		uint160 iaddr = 0;
		uint160 b1;
		uint160 b2;
		for (uint i = 2; i < 2 + 2 * 20; i += 2) {
			iaddr *= 256;
			b1 = uint160(uint8(tmp[i]));
			b2 = uint160(uint8(tmp[i + 1]));
			if ((b1 >= 97) && (b1 <= 102)) {
				b1 -= 87;
			} else if ((b1 >= 65) && (b1 <= 70)) {
				b1 -= 55;
			} else if ((b1 >= 48) && (b1 <= 57)) {
				b1 -= 48;
			}
			if ((b2 >= 97) && (b2 <= 102)) {
				b2 -= 87;
			} else if ((b2 >= 65) && (b2 <= 70)) {
				b2 -= 55;
			} else if ((b2 >= 48) && (b2 <= 57)) {
				b2 -= 48;
			}
			iaddr += (b1 * 16 + b2);
		}
		return address(iaddr);
	}
	function vote(uint _contestantId) public validState(PHASE.voting){
        
		require(voters[msg.sender].isRegistered);
		require(!voters[msg.sender].hasVoted);
        require(_contestantId > 0 && _contestantId<=contestantsCount);
		contestants[_contestantId].voteCount++;
		voters[msg.sender].hasVoted=true;
		voters[msg.sender].vote=_contestantId;
	}
}