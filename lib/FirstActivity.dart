import 'package:flutter/material.dart';
import 'SecondActivity.dart';
import 'Login.dart';

//First activity implementation
class FirstActivity extends StatefulWidget{
  @override
  _FirstActivityState createState() => new _FirstActivityState();
}

class _FirstActivityState extends State<FirstActivity>{
  @override
  Widget build(BuildContext context){
    return new Scaffold(
      body: SafeArea(
        child:SingleChildScrollView(
            child:Column(
              children: <Widget>[
                Container(
                    child: Image.asset(
                      'assets/logo.png',
                      width: 80,
                      height: 80,
                    ),
                    margin: const EdgeInsets.only(
                      top:80,
                    )
                ),
                Container(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(80,0, 80, 0),
                    child: Text(
                      'Stand a chance to Win up to E 1 000.00',
                      style: TextStyle(
                        fontSize: 17,
                        fontFamily: 'Raleway',
                        color:Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  margin: EdgeInsets.only(
                    top: 80,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color:Color(0xfff4c111),
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  ),
                  width: MediaQuery.of(context).size.width * 0.6,
                  height: 50,
                  child:Padding(
                    padding: EdgeInsets.all(12),
                    child: GestureDetector(
                      child: Text(
                        'Next',
                        textDirection: TextDirection.ltr,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22,
                          fontFamily: 'Raleway',
                        ),
                      ),
                      onTap:(){
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (BuildContext context){
                            return MaterialApp(
                              home: SecondActivity(),
                              theme: ThemeData(
                                scaffoldBackgroundColor: Color(0xff231f20),
                                accentColor: Colors.white,
                                primaryColor: Colors.white,
                              ),
                            );
                          }),
                        );
                      },
                    ),
                  ),
                  margin: EdgeInsets.only(
                    top: 70,
                  ),
                ),
                Container(
                  width: 150,
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                    child: GestureDetector(
                      onTap:(){
                        skipButton(context);
                      },
                      child:Text(
                        'Skip',
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Raleway',
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  margin: const EdgeInsets.only(
                    top: 15,
                    bottom: 15,
                  ),
                ),
              ],
            )
        ),
      ),
    );
  }

  void skipButton(BuildContext context){
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
          builder: (BuildContext context){
            return new MaterialApp(
              home: Login(),
              theme: ThemeData(
                scaffoldBackgroundColor: Color(0xff231f20),
                accentColor: Colors.white,
                primaryColor: Colors.white,
              ),
            );
          }
      ),
    );
  }
}
