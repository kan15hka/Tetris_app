//board dimensions
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

int rowLength = 10;
int colLength = 15;

//enum for directions
enum Direction { left, right, down }

// enum for Tetromino
enum Tetromino {
  L,
  J,
  I,
  O,
  S,
  Z,
  T,
  /*
   o
   o
   o o

     o
     o
   o o
   
   o
   o
   o
   o

   o o
   o o

     o o
   o o

   o o
     o o

   o
   o o
   o  
  */
}

const Map<Tetromino, Color> tetrominoColors = {
  Tetromino.L: Color.fromARGB(255, 233, 112, 13),
  Tetromino.J: Color.fromARGB(255, 18, 16, 141),
  Tetromino.I: Color.fromARGB(255, 81, 177, 201),
  Tetromino.O: Color.fromARGB(255, 224, 205, 31),
  Tetromino.S: Color.fromARGB(255, 29, 128, 29),
  Tetromino.Z: Color.fromARGB(255, 168, 19, 8),
  Tetromino.T: Color.fromARGB(255, 110, 11, 134),
};

const Color tetrisElementColor = Color.fromARGB(255, 158, 156, 156);

var tetrisTextStyle =
    TextStyle(color: Colors.grey[400], fontFamily: 'tetris', fontSize: 12.0);
var tetrisTitleTextStyle =
    TextStyle(color: Colors.grey[400], fontFamily: 'tetris', fontSize: 20.0);
