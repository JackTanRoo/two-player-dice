pragma solidity ^0.7.1;


// <!-- REQUIREMENTS -->

// <!-- 1) 2 players play the game -->
// <!-- 2) Fixed bet size from each size-->
// <!-- 3) Roll 5 times, if odd, then player 1 wins winnings, if even player 2 wins -->
// <!-- 3) 1% fee to house -->


contract Dice {

	struct Bet{
//		uint8  currentBet;
//		bool  isBetSet; //default value is false
		uint8  score;
    uint8  turns;
	}

  address public lastPlayed_;
  address public player1_;
  address public player2_;
  address public winner_;
  uint8 private randomFactor;

	mapping(address => Bet) private bets;

  // check initial

  function init() external view returns (string memory) {
    return "I am working";
  }

  // start the game with 2 players

  function startGame(address _player1, address _player2) external returns (address[2] memory) {
    player1_ = _player1;
    player2_ = _player2;

    return [player1_, player2_];
  }

  // dice roll generator

  function random() private view returns (uint8) {
    uint256 blockValue = uint256(blockhash(block.number-1 + block.timestamp));
    blockValue = blockValue + uint256(randomFactor);
    return uint8(blockValue % 5) + 1;
  }

  // take turns to roll the dice and increment the score

  function takeTurn () external returns (address){
    bets[msg.sender].score += random();
    bets[msg.sender].turns += 1;
    return msg.sender;
  }

  // return gameStatus of each player

  function getStatus () external view returns (uint8[2] memory) {
    return [bets[player1_].score, bets[player2_].score];
  }

  // if both players are at 5 turns, then find winner

}
