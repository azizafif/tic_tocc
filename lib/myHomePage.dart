import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int user = 1;

  List<List<String>> matrix = [["", "", ""], ["", "", ""], ["", "", ""]];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:
            [
              Text("The current Player: ", style: TextStyle(fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF43637F)),),
              Text(user == 1 ? "X" : "O",
                style: TextStyle(fontWeight: FontWeight.bold,
                    fontSize: 30.0,
                    color: user == 1 ? Color(0xFF3989D4) : Color(0xFF39BCD4)),
              ),
            ],),
          SizedBox(height: 20.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildBox(0, 0),
              _buildBox(0, 1),
              _buildBox(0, 2),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildBox(1, 0),
              _buildBox(1, 1),
              _buildBox(1, 2),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildBox(2, 0),
              _buildBox(2, 1),
              _buildBox(2, 2),
            ],),
          Row(),
        ],
      ),
    );
  }

  _buildBox(int line, int column) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (user == 1) {
            matrix[line][column] = "X";
            user = 2;

          }
          else {
            matrix[line][column] = "O";
            user = 1;
          }
          _verifWinner(line,column);
        });
      },
      child: Padding(padding: EdgeInsets.all(1),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Container(
            width: 100,
            height: 100,
            color: Color(0xFFeddcd2),
            child: Center(
              child: Text(matrix[line][column].toString(),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 50.0,
                    color: matrix[line][column] == "X"
                        ? Color(0xFF3989D4)
                        : Color(0xFF39BCD4)
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _verifWinner(int line, int column) {
    var nbCol = 0,
        nbLine = 0,
        nbDiagR = 0,
        nbDiagoL = 0;
    var player = matrix[line][column];
    for (int i = 0; i<3 ; i++)
    {
      if(matrix[line][i] == player)
        nbCol ++ ;
      if(matrix[i][column]== player)
        nbLine ++;
      if(matrix[i][i]==player)
        nbDiagoL ++ ;
      if(matrix[i][2-i] == player)
        nbDiagR ++ ;
    }
    if(nbDiagoL == 3 || nbDiagR == 3 || nbLine == 3 || nbCol == 3)
      showWinner(context,user);
  }
  void showWinner(BuildContext context, int player ){


    Widget cancelButton = FlatButton(onPressed: (){
      Navigator.pop(context);
    }, child: Text("Exit"),);
    Widget continueButton = FlatButton(onPressed:() {
      setState(() {
        user = 1;
        _initMatrix();
      });

      Navigator.pop(context);
    }, child: Text("OK"),);
    AlertDialog alertDialog = AlertDialog(
      title: Text(" The player $player Won the match"),
      content: Text(" Click on OK to replay "),
      actions: <Widget>[
        cancelButton,
        continueButton,
      ],
    );
    showDialog(context: context, builder: (BuildContext context)
    {
      return alertDialog;
    });
  }
  _initMatrix(){
    for(int i=0; i<3;i++){
      for(int j = 0 ; j<3; j++)
      {

        matrix[i][j]= "";
      }

    }

  }
}