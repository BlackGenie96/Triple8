import 'package:flutter/material.dart';
import 'PlayMenu.dart';

//play results display activity
class PlayResult extends StatefulWidget{
  final message;
  final number;
  PlayResult(this.message, this.number);
  @override
  _PlayResultState createState() {
    return new _PlayResultState(this.message, this.number);
  }
}

class _PlayResultState extends State<PlayResult>{
  //variables used in this screen
  String _number;
  String _message;

  //constructor
  _PlayResultState(this._message, this._number);
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: Column(
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(
                      top: 100,
                    ),
                    width: 80,
                    height: 80,
                    child: Image.asset("assets/logo.png"),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top:30,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xfff4c111), width:2),
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      color: Color(0xff231f20),
                    ),
                    width: MediaQuery.of(context).size.width * 0.65,
                    height: 50,
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: Text(
                        this._number,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Raleway',
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      top: 20,
                    ),
                    width:MediaQuery.of(context).size.width * 0.8,
                    child: Padding(
                        padding: EdgeInsets.all(5),
                        child: Text(
                          this._message,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Raleway',
                            fontSize: 20,
                            color: Color(0xffeeeeee),
                          ),
                        )
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 20,
                      bottom: 20,
                    ),
                    width: MediaQuery.of(context).size.width * 0.65,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      color: Color(0xfff4c111),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(top:13 ),
                      child: GestureDetector(
                        onTap: (){
                          _goToPlayHomeMenu(context);
                        },
                        child: Text(
                          'Play Again',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Raleway',
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  //go to play menu activity
  _goToPlayHomeMenu(BuildContext context){
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (BuildContext context){
          return new MaterialApp(
            home: PlayMenu(),
            theme: ThemeData(
              scaffoldBackgroundColor: Color(0xff231f20),
              accentColor: Colors.white,
              primaryColor: Colors.white,
            )
          );
        }
      )
    );
  }
}
