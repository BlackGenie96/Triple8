import 'package:flutter/material.dart';
import 'Login.dart';

//Second Activity Definition
class SecondActivity extends StatefulWidget{
  @override
  _SecondActivityState createState() => new _SecondActivityState();
}

class _SecondActivityState extends State<SecondActivity>{
  @override
  Widget build(BuildContext context){
    return new Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              child:Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Container(
                    width: 80,
                    height:80,
                    child: Image.asset('assets/logo.png'),
                    margin: const EdgeInsets.only(
                      top: 40,
                      bottom: 40,
                    ),
                  ),
                  Container(
                    child: Text(
                      'How To Win',
                      style: TextStyle(
                        fontFamily: 'Raleway',fontSize: 37,color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    width: 200,
                    height: 30,
                    margin: const EdgeInsets.only(
                      top: 4,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(0xfff4c111),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    ),
                    child: Padding(
                        padding: EdgeInsets.fromLTRB(0,6,0,0),
                        child: Text(
                          'GET SINGLE 8',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'Raleway',
                            color: Colors.white,
                          ),
                        )
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.only(
                          top: 3
                      ),
                      child: Text(
                          'E 200.00',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 35,
                              fontFamily: 'Raleway',
                              fontWeight: FontWeight.bold,
                              color: Color(0xfff4c111)
                          )
                      )
                  ),
                  Container(
                    width: 200,
                    height: 30,
                    margin: const EdgeInsets.only(
                      top: 20,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(0xfff4c111),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    ),
                    child: Padding(
                        padding: EdgeInsets.fromLTRB(0,6,0,0),
                        child: Text(
                          'GET DOUBLE 8',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'Raleway',
                            color: Colors.white,
                          ),
                        )
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.only(
                          top: 3
                      ),
                      child: Text(
                          'E 500.00',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Raleway',
                              color: Color(0xfff4c111)
                          )
                      )
                  ),
                  Container(
                    width: 200,
                    height: 30,
                    margin: const EdgeInsets.only(
                      top: 20,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(0xfff4c111),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    ),
                    child: Padding(
                        padding: EdgeInsets.fromLTRB(0,6,0,0),
                        child: Text(
                          'GET TRIPLE 8',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'Raleway',
                            color: Colors.white,
                          ),
                        )
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.only(
                          top: 3
                      ),
                      child: Text(
                          'E 1 000.00',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Raleway',
                            color: Color(0xfff4c111),
                          )
                      )
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xfff4c111),
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    ),
                    width:MediaQuery.of(context).size.width * 0.6,
                    height:50,
                    margin: const EdgeInsets.only(
                      top: 20,
                      bottom: 15,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: GestureDetector(
                        onTap: (){
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (BuildContext context){
                                    return new MaterialApp(
                                        home: Login(),
                                        theme: ThemeData(
                                          scaffoldBackgroundColor: Color(0xff231f20),
                                          primaryColor: Colors.white,
                                          accentColor: Colors.white,
                                        )
                                    );
                                  }
                              )
                          );
                        },
                        child: Text(
                          'Next',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Raleway',
                            fontSize: 22,
                            color: Color(0xff231f20),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
      ),
    );
  }
}

