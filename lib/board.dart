import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tetris/piece.dart';
import 'package:tetris/pixel.dart';
import 'package:tetris/values.dart';
import 'package:lottie/lottie.dart';

/*
GAME BOARD
This is a 2x2 grid with null representing an empty space.
A non empty space will have the color to represent the landed piece
*/
//create the game board
List<List<Tetromino?>> gameBoard =
    List.generate(colLength, (i) => List.generate(rowLength, (j) => null));

class GameBoard extends StatefulWidget {
  const GameBoard({super.key});

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  //current tetris piece
  Piece currentPiece = Piece(type: Tetromino.L);
  //current score
  int currentScore = 0;
  //game over bool
  bool gameOver = false;
  @override
  void initState() {
    super.initState();
    startGame();
  }

  void startGame() {
    currentPiece.initializePiece();
    //frame refresh rate
    Duration frameRate = Duration(milliseconds: 800);
    gameLoop(frameRate);
  }

  // game Loop
  void gameLoop(Duration frameRate) {
    Timer.periodic(frameRate, (timer) {
      setState(() {
        //clear lines
        clearLines();
        //check landing
        checkLanding();
        //checkif game is over
        if (gameOver == true) {
          timer.cancel();
          showGameOverDialog();
        }
        //move current piece down
        currentPiece.movePiece(Direction.down);
      });
    });
  }

  //game over message
  void showGameOverDialog() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: Colors.grey[900],
              shape: RoundedRectangleBorder(
                side: BorderSide(
                    color: Color.fromARGB(255, 189, 189, 189), width: 2.0),
                borderRadius: BorderRadius.circular(15.0),
              ),
              title: Center(
                  child: Text(
                'GAME OVER',
                style: tetrisTitleTextStyle,
              )),
              content: Container(
                width: 300.0,
                height: 200.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    //Lottie asset
                    Lottie.asset('assets/cube_grid.json', height: 150.0),
                    SizedBox(
                      height: 15.0,
                    ),
                    //Score
                    Text(
                      'Score: $currentScore',
                      style: tetrisTextStyle,
                    ),
                  ],
                ),
              ),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[800],
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            side: BorderSide(
                                color: Color.fromARGB(255, 189, 189, 189),
                                width: 2.0)),
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        child: Text(
                          'END GAME',
                          style: tetrisTextStyle,
                        )),
                    TextButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[800],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          side: BorderSide(
                              color: Color.fromARGB(255, 189, 189, 189),
                              width: 2.0)),
                      onPressed: () {
                        //reset the game
                        resetGame();
                        Navigator.pop(context);
                      },
                      child: Text(
                        'PLAY AGAIN',
                        style: tetrisTextStyle,
                      ),
                    )
                  ],
                )
              ],
            ));
  }

  void resetGame() {
    //clear the game board
    gameBoard =
        List.generate(colLength, (i) => List.generate(rowLength, (j) => null));
    //new game
    gameOver = false;
    currentScore = 0;
    //create new pIece
    createNewPiece();
    //start the game
    startGame();
  }

  //check for collision detection in future position
  // return true if collision else return false
  bool checkCollision(Direction direction) {
    //loop through each position of current piece
    for (int i = 0; i < currentPiece.position.length; i++) {
      //calculate the row and column of the current piece
      int row = (currentPiece.position[i] / rowLength).floor();
      int col = currentPiece.position[i] % rowLength;
      //adjust column base on the direction
      if (direction == Direction.left) {
        col -= 1;
      } else if (direction == Direction.right) {
        col += 1;
      } else if (direction == Direction.down) {
        row += 1;
      }
      //check if the piece is out of bounds(either too low or too far tothe left or right)
      if (row >= colLength || col < 0 || col >= rowLength) {
        return true;
      } else if (col > 0 && row > 0 && gameBoard[row][col] != null) {
        return true;
      }
    }
    //if no collisions are detected return false
    return false;
  }

  //Check Landing
  void checkLanding() {
    //if going downis occupied
    if (checkCollision(Direction.down)) {
      //mark position as occupied on the gameboard
      for (int i = 0; i < currentPiece.position.length; i++) {
        int row = (currentPiece.position[i] / rowLength).floor();
        int col = currentPiece.position[i] % rowLength;

        if (row >= 0 && col >= 0) {
          gameBoard[row][col] = currentPiece.type;
        }
      }
      //once landed, create the next piece
      createNewPiece();
    }
  }

  void createNewPiece() {
    // create a random object to generate random tetromino types
    Random rand = Random();
    // create a new piece with random type
    Tetromino randomType =
        Tetromino.values[rand.nextInt(Tetromino.values.length)];
    currentPiece = Piece(type: randomType);
    currentPiece.initializePiece();
    //instead of checking whether game is over in every frame rate it is better to
    //check at every instance a new piece is created
    if (isGameOver()) {
      gameOver = true;
    }
  }

  //move left
  void moveLeft() {
    //make sure the move is valid before movement
    if (!checkCollision(Direction.left)) {
      setState(() {
        currentPiece.movePiece(Direction.left);
      });
    }
  }

  //move right
  void moveRight() {
    //make sure the move is valid before movement
    if (!checkCollision(Direction.right)) {
      setState(() {
        currentPiece.movePiece(Direction.right);
      });
    }
  }

  // rotate piece
  void rotatePiece() {
    setState(() {
      currentPiece.rotatePiece();
    });
  }

  //clear lines
  void clearLines() {
    //step1: lets loopthrough each row of the gameBoard from bottom to top
    for (int row = colLength - 1; row >= 0; row--) {
      //step2:Initialize a variableto track if the row is full
      bool rowIsFull = true;
      //step3: Check if the row is full
      for (int col = 0; col < rowLength; col++) {
        if (gameBoard[row][col] == null) {
          rowIsFull = false;
          break;
        }
      }
      //step4:if the row is full shift the rows and clear top row
      if (rowIsFull) {
        //step5:Move all rows  doen by  one step
        for (int r = row; r > 0; r--) {
          gameBoard[r] = List.from(gameBoard[r - 1]);
        }
        //step6: top rowto empty
        gameBoard[0] = List.generate(row, (index) => null);
        //step7: increase the score
        currentScore++;
      }
    }
  }

  bool isGameOver() {
    //check if columns in the toprow are filled
    for (int col = 0; col < rowLength; col++) {
      if (gameBoard[0][col] != null) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          shape: Border(
              bottom: BorderSide(
                  color: Color.fromARGB(255, 189, 189, 189), width: 2.0)),
          elevation: 0.0,
          backgroundColor: Colors.grey[900],
          centerTitle: true,
          title: Text(
            'TETRIS',
            style: TextStyle(color: currentPiece.color, fontFamily: 'tetris'),
          ),
        ),
        backgroundColor: Colors.black,
        body: Column(
          children: [
            SizedBox(
              height: 10.0,
            ),
            //Game Board
            Expanded(
              child: GridView.builder(
                  itemCount: rowLength * colLength,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: rowLength),
                  itemBuilder: (context, index) {
                    //get row and column of each index
                    int row = (index / rowLength).floor();
                    int col = index % rowLength;
                    //current piece
                    if (currentPiece.position.contains(index)) {
                      return Pixel(
                        color: currentPiece.color,
                      );
                    }
                    //landed pieces
                    else if (gameBoard[row][col] != null) {
                      final Tetromino? tetrominoType = gameBoard[row][col];
                      return Pixel(
                        color: tetrominoColors[tetrominoType],
                      );
                    }
                    // blank pixel
                    else {
                      return Pixel(
                        color: Colors.grey[900],
                      );
                    }
                  }),
            ),
            //Score
            Text(
              'Score: ${currentScore}',
              style: TextStyle(
                  color: tetrisElementColor,
                  fontFamily: 'tetris',
                  fontSize: 15.0),
            ),
            SizedBox(
              height: 20.0,
            ),
            //Game Controls
            Container(
              height: 100.0,
              decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(15.0)),
              padding: EdgeInsets.only(bottom: 50.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //left
                  IconButton(
                      iconSize: 40.0,
                      onPressed: moveLeft,
                      color: tetrisElementColor,
                      icon: Icon(Icons.arrow_back_ios_new_rounded)),
                  //rotate
                  IconButton(
                      iconSize: 35.0,
                      onPressed: rotatePiece,
                      color: tetrisElementColor,
                      icon: Icon(
                        Icons.rotate_90_degrees_cw_rounded,
                        color: currentPiece.color,
                      )),

                  //right
                  IconButton(
                      iconSize: 40.0,
                      onPressed: moveRight,
                      color: tetrisElementColor,
                      icon: Icon(Icons.arrow_forward_ios_rounded)),
                ],
              ),
            )
          ],
        ));
  }
}
