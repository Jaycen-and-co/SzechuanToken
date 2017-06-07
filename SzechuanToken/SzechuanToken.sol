pragma solidity 0.4.8;



contract SzechuanToken{

	adress public minter;
	uint public totalCoins;

	event LogCoinsMinted(address deliveredTo, uint amount);
	event LogCoinsSent(address sentTo,uint amount);

	mapping (address => uint) balances;
	function SzechuanToken(uint initialCoins){
		minter = msg.sender;
		totalCoins = initialCoins;
		balances[minter] = initialCoins;
	}

	function mint(address owner, uint amount){
		if (msg.sender != minter) return;
		balances[owner] += amount;
		totalCoins += amount;
		LogCoinsMinted(owner, amount);
	}

	function send(address receiver, uint amount){
		if (balances[msg.sender] < amount) return;
		balances[msg.sender] -= amount;
		balances[receiver] += amount;
		LogCoinsSent(receiver,amount);
	}

	function queryBalance(address addr) constant returns (uint balance) {
		return balances[addr];
	}

	function killCoin() returns (bool status){
		if (msg.sender != minter) throw;
		selfdestruct(miinter);
		
	}
}