import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:tetris/board.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        SizedBox(
          height: 20.0,
        ),
        Text(
          "TETRIS",
          style: TextStyle(
              color: Colors.grey[400], fontFamily: 'tetris', fontSize: 30.0),
        ),
        //Lottie Asset
        LottieBuilder.asset('assets/cube_grid.json'),
        //Play game
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(20.0),
                backgroundColor: Colors.grey[900],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                side: BorderSide(
                    color: Color.fromARGB(255, 189, 189, 189), width: 2.0)),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => GameBoard()));
            },
            child: Text(
              "PLAY TETRIS",
              style: TextStyle(
                  color: Colors.grey[400],
                  fontFamily: 'tetris',
                  fontSize: 18.0),
            )),
        //Quitgame
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(20.0),
                backgroundColor: Colors.grey[900],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                side: BorderSide(
                    color: Color.fromARGB(255, 189, 189, 189), width: 2.0)),
            onPressed: () {
              SystemNavigator.pop();
            },
            child: Text(
              "QUIT TETRIS",
              style: TextStyle(
                  color: Colors.grey[400],
                  fontFamily: 'tetris',
                  fontSize: 18.0),
            )),
      ]),
    );
  }
}
