
import Foundation



//3 options a square can be
enum Letter{
	case x,o,e
}

// e = empty


struct Player {
	var hasWon = false;
	let letter: Letter;
	var name: String;
	var turn = 0
	var canMove = false
	
	
	
	init(theLetter: Letter) {
		letter = theLetter
		name = "Player \(letter)"
	}
	
	// these methods are not
	// used in the actual logic
	// but can be used for convienience
	// e.x. if you wanted to display a
	// message "you cannot move yet"
	// based on whether or not
	// the player is disabled
	
	// stops the player from moving
	mutating func disablePlayer(){
		self.canMove = false
	}
	
	// lets the player move
	mutating func enablePlayer(){
		self.canMove = true
	}
	
}

// create a multidimensional array
// that represents the
var gameBoard: [[Letter]] = [[.e,.e,.e,], //[0][0-2]
							 [.e,.e,.e,], //[1][0-2]
							 [.e,.e,.e,]] //[2][0-2]

// safely sets the square
// returns true if operation went sucessfully

func safeSetSquare(row x:Int, column y:Int, letter:Letter) -> (success: Bool, message:String) {
	
	print(x, y, letter)
	
	// array safety check
	if (x > 2 || y > 2) || ( x < 0 || y < 0) {
		//print("Array out of bounds")
		return (false, "error: array out of bounds")
	}
	
	
	let square = gameBoard[x][y]
	
	// if there is already a letter in the square,
	// we should not let us set a different letter
	if square != .e {
		
		//print("Square = x || o, cannot overwrite square")
		return (false, "error: letter is already in the selected square")
		
	} else {
		gameBoard[x][y] = letter;
		//print("setting letter")
		return (true, "successfully set letter")
		
	}
}


// optional because there might not be
// a winning letter yet

// only returns a letter if 
// there is a winner
func checkForWin() -> Letter?{
	
	for i in 0...2 {
		//check for row
		if (gameBoard[0][i] == gameBoard[1][i] && gameBoard[1][i] == gameBoard[2][i]) && gameBoard[0][i] != .e {
			//
			return gameBoard[0][i]
			
		 //check for column
		} else if (gameBoard[i][0] == gameBoard[i][1] && gameBoard[i][1] == gameBoard[i][2]) && gameBoard[i][0] != .e {
			return gameBoard[i][0]
			
			//diagonal left to right
		} else if (gameBoard[0][0] == gameBoard[1][1] && gameBoard[1][1] == gameBoard[2][2])  && gameBoard[0][0] != .e {
			return gameBoard[0][0]
			
			// diagonal right to left
		} else if (gameBoard[0][2] == gameBoard[1][1] && gameBoard[1][1] == gameBoard[2][0]) && gameBoard[0][2] != .e {
			return gameBoard[0][2]
		}
		
	}
	// if there is no winning letter
	return nil
	
}







// generates random 
// number between
func generateMove() -> (x: Int, y: Int){
	let randomX = Int(arc4random_uniform(3))
	let randomY = Int(arc4random_uniform(3))
	
	return (randomX, randomY)
}

var numberOfMoves = 0

func waitForMove(_ player: Player) {
	// dummy function that in real implementation
	// should wait until the current player has chosen
	// and then go on
	
	// for now, i am just going to have it randomly select a square
	
	
	var move: (success: Bool, message: String);
	
	// keep trying to select a square
	// until it successfully sets one
	repeat {
		move = safeSetSquare(row: generateMove().x, column: generateMove().y, letter: player.letter)
		
	} while move.success == false
	print(player.letter, move.message)
	sleep(1)
	
	numberOfMoves += 1;

}

var running = true

// create the 2 players
var playerX = Player(theLetter: .x)
var playerO = Player(theLetter: .o)

// x should have a turn 1 higher than o

playerX.turn += 1
// playerX.turn = 1
// playerY.turn = 0



// turn system
func play(){
	
	
	if playerX.turn == playerO.turn {
		playerO.disablePlayer() // playerX should always be +1 greater than player o
		playerX.enablePlayer()
		//print("x: ", playerX.turn, " o: ", playerO.turn)
		playerX.turn += 1
		
		// wait for move
		waitForMove(playerX)
		
		// if x just went, its o's turn
	} else if playerX.turn > playerO.turn {
		playerX.disablePlayer()
		playerO.enablePlayer()
		//print("x: ", playerX.turn, " o: ", playerO.turn)
		playerO.turn += 1
		waitForMove(playerO)
		
	}
	// if there is a winner
	if checkForWin() != nil {
		
		let winner = checkForWin()
		print(winner!, "has won! in \(numberOfMoves) moves")
		
		// set the correct person
		// as letter
		if playerX.letter == winner {
			playerX.hasWon = true
		} else {
			playerO.hasWon
		}
		// stop the gmae
		running = false
	}
	
}

// game loop
while running {
	
	play()
	print()
	// print the game board at
	// the end
	for row in gameBoard {
		for column in row {
			print(column, " ", terminator:"")
		}
		print("")
	}
	
	
}




/*
repeat {
	// check if player has won
	// define the possible of winning directions
	let row1 = gameBoard[0];
	let row2 = gameBoard[1];
	let row3 = gameBoard[2];
	let column1 = [gameBoard[0][0], gameBoard[1][0], gameBoard[2][0]]
	let column2 = [gameBoard[0][1], gameBoard[1][1], gameBoard[2][1]]
	let column3 = [gameBoard[0][2], gameBoard[1][2], gameBoard[2][2]]
	let diagLeftRight = [gameBoard[0][0], gameBoard[1][1],gameBoard[2][2]]
	let diagRightLeft = [gameBoard[0][2], gameBoard[1][1], gameBoard[2][0]]
	
	// check for x win
	
	if  (!row1.contains(.o) && !row1.contains(.e)) ||
		(!row2.contains(.o) && !row2.contains(.e)) ||
		(!row3.contains(.o) && !row3.contains(.e)) ||
		(!column1.contains(.o) && !column1.contains(.e)) ||
		(!column2.contains(.o) && !column2.contains(.e)) ||
		(!column3.contains(.o) && !column3.contains(.e)) ||
		(!diagLeftRight.contains(.o) && !diagLeftRight.contains(.e)) ||
		(!diagLeftRight.contains(.o) && !diagLeftRight.contains(.e))
	
	{
		print("x wins")
		aPlayerHasWon = true
		playerX.hasWon = true
		
	} else if  (!row1.contains(.x) && !row1.contains(.e)) ||
			(!row2.contains(.x) && !row2.contains(.e)) ||
			(!row3.contains(.x) && !row3.contains(.e)) ||
			(!column1.contains(.x) && !column1.contains(.e)) ||
			(!column2.contains(.x) && !column2.contains(.e)) ||
			(!column3.contains(.x) && !column3.contains(.e)) ||
			(!diagLeftRight.contains(.x) && !diagLeftRight.contains(.e)) ||
			(!diagLeftRight.contains(.x) && !diagLeftRight.contains(.e))
		
	{
		print("o wins")
		aPlayerHasWon = true
		playerO.hasWon = true
	} else {
		print("no one won yet")
	}
	
	
	safeSetSquare(row: 0, column: 0, letter: .x)
	safeSetSquare(row: 0, column: 1, letter: .x)
	safeSetSquare(row: 0, column: 2, letter: .x)
	
	//aPlayerHasWon = true;
	
	
} while aPlayerHasWon == false




var result = safeSetSquare(row: 0, column: 2, letter: Letter.x)

print(result)
print(gameBoard[2][0], terminator: "")
*/





// a way to iterate through the array
/*
for row in gameBoard {

for column in row {
if column != .e {
//letter = column
}
print(row)
}
}
*/
//print(letter)










