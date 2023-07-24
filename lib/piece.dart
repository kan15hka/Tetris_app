import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:tetris/board.dart';
import 'package:tetris/values.dart';

class Piece {
  //type of tetris piece
  Tetromino type;
  Piece({required this.type});
  //the piece is just a list if numbers
  List<int> position = [];

  // color of tetris piece
  Color get color {
    return tetrominoColors[type] ?? Colors.white;
  }

  //generate the integers
  void initializePiece() {
    switch (type) {
      case Tetromino.L:
        position = [-26, -16, -6, -5];
        break;
      case Tetromino.J:
        position = [-25, -15, -5, -6];
        break;
      case Tetromino.I:
        position = [-4, -5, -6, -7];
        break;
      case Tetromino.O:
        position = [-15, -16, -5, -6];
        break;
      case Tetromino.S:
        position = [-15, -14, -6, -5];
        break;
      case Tetromino.Z:
        position = [-17, -16, -6, -5];
        break;
      case Tetromino.T:
        position = [-26, -16, -6, -15];
        break;
      default:
    }
  }

  //move piece
  void movePiece(Direction direction) {
    switch (direction) {
      case Direction.down:
        for (int i = 0; i < position.length; i++) {
          position[i] += rowLength;
        }
        break;
      case Direction.left:
        for (int i = 0; i < position.length; i++) {
          position[i] -= 1;
        }
        break;
      case Direction.right:
        for (int i = 0; i < position.length; i++) {
          position[i] += 1;
        }
        break;

      default:
    }
  }

  //rotate piece
  int rotationState = 1;
  void rotatePiece() {
    //new position
    List<int> newPosition;
    //rotate the piece based on its type
    switch (type) {
      //TETROMINO L
      case Tetromino.L:
        switch (rotationState) {
          case 0:
            /*
            o
            o
            o o
            */
            //get the new position
            newPosition = [
              position[1] - rowLength,
              position[1],
              position[1] + rowLength,
              position[1] + rowLength + 1,
            ];
            //check that this mew position isavalid move before assign it to the real positon
            if (piecePositionIsValid(newPosition)) {
              //update position
              position = newPosition;
              //update rotation State
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 1:
            /*
            o o o
            o
            */
            //get the new position
            newPosition = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + rowLength - 1,
            ];
            //check that this mew position isavalid move before assign it to the real positon
            if (piecePositionIsValid(newPosition)) {
              //update position
              position = newPosition;
              //update rotation State
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 2:
            /*
            o o
              o
              o
            */
            //get the new position
            newPosition = [
              position[1] + rowLength,
              position[1],
              position[1] - rowLength,
              position[1] - rowLength - 1,
            ];
            //check that this mew position isavalid move before assign it to the real positon
            if (piecePositionIsValid(newPosition)) {
              //update position
              position = newPosition;
              //update rotation State
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 3:
            /*
                o
            o o o
            */
            //get the new position
            newPosition = [
              position[1] - rowLength + 1,
              position[1],
              position[1] + 1,
              position[1] - 1,
            ];
            //check that this mew position isavalid move before assign it to the real positon
            if (piecePositionIsValid(newPosition)) {
              //update position
              position = newPosition;
              //update rotation State
              rotationState = (rotationState + 1) % 4;
            }
            break;
        }
        break;
      // TETROMINO J
      case Tetromino.J:
        switch (rotationState) {
          case 0:
            /*
              o
              o
            o o
            */
            //get the new position
            newPosition = [
              position[1] - rowLength,
              position[1],
              position[1] + rowLength,
              position[1] + rowLength - 1,
            ];
            //check that this mew position isavalid move before assign it to the real positon
            if (piecePositionIsValid(newPosition)) {
              //update position
              position = newPosition;
              //update rotation State
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 1:
            /*
            o
            o o o
            */
            //get the new position
            newPosition = [
              position[1] - rowLength - 1,
              position[1],
              position[1] - 1,
              position[1] + 1,
            ];
            //check that this mew position isavalid move before assign it to the real positon
            if (piecePositionIsValid(newPosition)) {
              //update position
              position = newPosition;
              //update rotation State
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 2:
            /*
            o o
            o
            o 
            */
            //get the new position
            newPosition = [
              position[1] + rowLength,
              position[1],
              position[1] - rowLength,
              position[1] - rowLength + 1,
            ];
            //check that this mew position isavalid move before assign it to the real positon
            if (piecePositionIsValid(newPosition)) {
              //update position
              position = newPosition;
              //update rotation State
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 3:
            /*
            o o o
                o
            */
            //get the new position
            newPosition = [
              position[1] + 1,
              position[1],
              position[1] - 1,
              position[1] + rowLength + 1,
            ];
            //check that this mew position isavalid move before assign it to the real positon
            if (piecePositionIsValid(newPosition)) {
              //update position
              position = newPosition;
              //update rotation State
              rotationState = (rotationState + 1) % 4;
            }
            break;
        }
        break;
      //TEROMINO I
      case Tetromino.I:
        switch (rotationState) {
          case 0:
            /*
            o o o o
            */
            //get the new position
            newPosition = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + 2,
            ];
            //check that this mew position isavalid move before assign it to the real positon
            if (piecePositionIsValid(newPosition)) {
              //update position
              position = newPosition;
              //update rotation State
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 1:
            /*
            o
            o
            o
            o
            */
            //get the new position
            newPosition = [
              position[1] - rowLength,
              position[1],
              position[1] + rowLength,
              position[1] + 2 * rowLength,
            ];
            //check that this mew position isavalid move before assign it to the real positon
            if (piecePositionIsValid(newPosition)) {
              //update position
              position = newPosition;
              //update rotation State
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 2:
            /*
            o o o o
            */
            //get the new position
            newPosition = [
              position[1] + 1,
              position[1],
              position[1] - 1,
              position[1] - 2,
            ];
            //check that this mew position isavalid move before assign it to the real positon
            if (piecePositionIsValid(newPosition)) {
              //update position
              position = newPosition;
              //update rotation State
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 3:
            /*
            o
            o
            o
            o
            */
            //get the new position
            newPosition = [
              position[1] + rowLength,
              position[1],
              position[1] - rowLength,
              position[1] - 2 * rowLength,
            ];
            //check that this mew position isavalid move before assign it to the real positon
            if (piecePositionIsValid(newPosition)) {
              //update position
              position = newPosition;
              //update rotation State
              rotationState = (rotationState + 1) % 4;
            }
            break;
        }
        break;
      // TETROMINO O
      case Tetromino.O:
        /*
        o o 
        o o
        O has no rotations
        */
        break;
      //TETROMINO S
      case Tetromino.S:
        switch (rotationState) {
          case 0:
            /*
              o o
            o o
            */
            //get the new position
            newPosition = [
              position[1],
              position[1] + 1,
              position[1] + rowLength - 1,
              position[1] + rowLength,
            ];
            //check that this mew position isavalid move before assign it to the real positon
            if (piecePositionIsValid(newPosition)) {
              //update position
              position = newPosition;
              //update rotation State
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 1:
            /*
            o 
            o o
              o
            */
            //get the new position
            newPosition = [
              position[0] - rowLength,
              position[0],
              position[0] + 1,
              position[0] + rowLength + 1,
            ];
            //check that this mew position isavalid move before assign it to the real positon
            if (piecePositionIsValid(newPosition)) {
              //update position
              position = newPosition;
              //update rotation State
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 2:
            /*
              o o
            o o
            */
            //get the new position
            newPosition = [
              position[1],
              position[1] + 1,
              position[1] + rowLength - 1,
              position[1] + rowLength,
            ];
            //check that this mew position isavalid move before assign it to the real positon
            if (piecePositionIsValid(newPosition)) {
              //update position
              position = newPosition;
              //update rotation State
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 3:
            /*
            o
            o o
              o 
            */
            //get the new position
            newPosition = [
              position[0] - rowLength,
              position[0],
              position[0] + 1,
              position[0] + rowLength + 1,
            ];
            //check that this mew position isavalid move before assign it to the real positon
            if (piecePositionIsValid(newPosition)) {
              //update position
              position = newPosition;
              //update rotation State
              rotationState = (rotationState + 1) % 4;
            }
            break;
        }
        break;
      //TETROMINO Z
      case Tetromino.Z:
        switch (rotationState) {
          case 0:
            /*
            o o
              o o
           
            */
            //get the new position
            newPosition = [
              position[0] + rowLength - 2,
              position[1],
              position[2] + rowLength - 1,
              position[3] + 1,
            ];
            //check that this mew position isavalid move before assign it to the real positon
            if (piecePositionIsValid(newPosition)) {
              //update position
              position = newPosition;
              //update rotation State
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 1:
            /*
              o
            o o
            o  
            */
            //get the new position
            newPosition = [
              position[0] - rowLength + 2,
              position[1],
              position[2] - rowLength + 1,
              position[3] - 1,
            ];
            //check that this mew position isavalid move before assign it to the real positon
            if (piecePositionIsValid(newPosition)) {
              //update position
              position = newPosition;
              //update rotation State
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 2:
            /*
            o o
              o o
            */
            //get the new position
            newPosition = [
              position[0] + rowLength - 2,
              position[1],
              position[2] + rowLength - 1,
              position[3] + 1,
            ];
            //check that this mew position isavalid move before assign it to the real positon
            if (piecePositionIsValid(newPosition)) {
              //update position
              position = newPosition;
              //update rotation State
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 3:
            /*
              o
            o o
            o
            */
            //get the new position
            newPosition = [
              position[0] - rowLength + 2,
              position[1],
              position[2] - rowLength + 1,
              position[3] - 1,
            ];
            //check that this mew position isavalid move before assign it to the real positon
            if (piecePositionIsValid(newPosition)) {
              //update position
              position = newPosition;
              //update rotation State
              rotationState = (rotationState + 1) % 4;
            }
            break;
        }
        break;
      //TETROMINO T
      case Tetromino.T:
        switch (rotationState) {
          case 0:
            /*
            o
            o o
            o 
            */
            //get the new position
            newPosition = [
              position[2] - rowLength,
              position[2],
              position[2] + 1,
              position[2] + rowLength,
            ];
            //check that this mew position isavalid move before assign it to the real positon
            if (piecePositionIsValid(newPosition)) {
              //update position
              position = newPosition;
              //update rotation State
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 1:
            /*
            o o o
              o
            */
            //get the new position
            newPosition = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + rowLength,
            ];
            //check that this mew position isavalid move before assign it to the real positon
            if (piecePositionIsValid(newPosition)) {
              //update position
              position = newPosition;
              //update rotation State
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 2:
            /*
              o
            o o
              o
            */
            //get the new position
            newPosition = [
              position[1] - rowLength,
              position[1] - 1,
              position[1],
              position[1] + rowLength,
            ];
            //check that this mew position isavalid move before assign it to the real positon
            if (piecePositionIsValid(newPosition)) {
              //update position
              position = newPosition;
              //update rotation State
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 3:
            /*
              o
            o o o
            */
            //get the new position
            newPosition = [
              position[2] - rowLength,
              position[2] - 1,
              position[2],
              position[2] + 1,
            ];
            //check that this mew position isavalid move before assign it to the real positon
            if (piecePositionIsValid(newPosition)) {
              //update position
              position = newPosition;
              //update rotation State
              rotationState = (rotationState + 1) % 4;
            }
            break;
        }
        break;

      default:
    }
  }

  bool positionIsValid(int position) {
    //get the row and the column of position
    int row = (position / rowLength).floor();
    int col = position % rowLength;
    //if the possition is taken return false
    if (row < 0 || col < 0 || gameBoard[row][col] != null) {
      return false;
    } else {
      return true;
    }
  }

  //check if place is valid position
  bool piecePositionIsValid(List<int> piecePosition) {
    bool firstColOccupied = false;
    bool lastColOccupied = false;
    for (int pos in piecePosition) {
      //return false if any poation is alredy taken
      if (!positionIsValid(pos)) {
        return false;
      }
      //get the col of the position
      int col = pos % rowLength;
      //check if the first and last col is occupied
      if (col == 0) {
        firstColOccupied = true;
      }
      if (col == rowLength - 1) {
        lastColOccupied = true;
      }
    }
    //if there is a piece in flirst and last col ,it is going through the wall
    return !(firstColOccupied && lastColOccupied);
  }
}
