import 'package:flutter/material.dart';
import 'DatabaseHelper.dart';
import 'dart:async';
import 'FirstActivity.dart';
import 'MainMenu.dart';

//Splash screen implementation
class SplashScreen extends StatefulWidget{
  @override
  SplashScreenState createState() => new SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>{

  final dbHelper = DatabaseHelper.instance;

  @override
  void initState(){
    //SQLiteDbProvider.db.initDB();
    super.initState();
    Timer(
        Duration(seconds: 3), (){
      checkLogin();
    });
  }

  //function to check if user has logged in before, or has data inserted in the sqflite database
  checkLogin() async{
    final rows = await dbHelper.queryRowCount();
    //get the row count. if the count is less than 0, then user has no registered
    print('row $rows');
    if(rows > 0){
      Navigator.of(context).pushReplacement(
          MaterialPageRoute<void>(
              builder:(BuildContext context){
                return new MaterialApp(
                  home: MainMenu(),
                  theme: ThemeData(
                    scaffoldBackgroundColor: Color(0xff231f20),
                    accentColor: Colors.white,
                    primaryColor: Colors.white,
                  ),
                );
              }
          )
      );
    }else{
      Navigator.of(context).pushReplacement(
        MaterialPageRoute<void>(
          builder: (BuildContext context){
            return new MaterialApp(
              home: FirstActivity(),
              theme: ThemeData(
                scaffoldBackgroundColor: Color(0xff231f20),
                accentColor: Colors.white,
                primaryColor: Colors.white,
              ),
            );
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Center(
        child: Image.asset(
          'assets/logo.png',
          width: 130,
          height: 130,
        ),
      ),
    );
  }
}
