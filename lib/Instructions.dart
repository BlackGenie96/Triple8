import 'package:flutter/material.dart';

//Instructions class definitions
class Instructions extends StatefulWidget{
  @override
  _InstructionsState createState() => new _InstructionsState();
}

class _InstructionsState extends State<Instructions>{
  @override
  Widget build(BuildContext context){
    return new Theme(
      data: Theme.of(context).copyWith(
        scaffoldBackgroundColor: Color(0xff231f20),
      ),
      child: new Builder(
        builder: (context) => Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xff231f20),
            iconTheme: IconTheme.of(context).copyWith(
              color:Colors.white,
            ),
            elevation:0,
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: <Widget>[
                    Container(
                      margin:const EdgeInsets.only(
                        top: 40,
                        bottom: 10,
                      ),
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: MediaQuery.of(context).size.height * 0.2,
                      child: Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Image.asset('assets/logo.png'),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: 25,
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(5),
                        child: Text(
                            'Instructions',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Raleway',
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 32,
                            )
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: 20,
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(5),
                        child: Text(
                          'How to Play and Win',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 30,
                          ),
                        ),
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(
                          top: 20,
                          bottom: 15,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(5),
                          child: Text(
                            'Press the play button and three(3) options will be shown, from there you select which category you wish to play under, given there is money in the users account. A 10-digit random number will be generated. If that random number has an eight(8), you win E 200.00 cash. If the your random number has a double eight (88), you win E 500.00 cash and if your random number has a triple eight (888), you win E 1 000.00 cash.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Raleway',
                              color: Color(0xfff4c111),
                              fontSize: 20,
                            ),
                          ),
                        )
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
