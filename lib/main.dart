import 'package:flutter/material.dart';
import 'SplashScreen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'userDB.dart';
import 'play.dart';
//import 'sql.dart';
import 'DatabaseHelper.dart';

void main() => runApp(BaseApp());

class BaseApp extends StatefulWidget{
  @override
  _BaseAppState createState() => new _BaseAppState();
}

class _BaseAppState extends State<BaseApp>{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: SplashScreen(),
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xff231f20),
        accentColor: Color(0xffFF4081),
      ),
    );
  }
}

//TODO: I just thought of an activity screen that will be a menu for buying more playing tokens
//TODO: There will also be an activities button to keep track of plays the users does, this is stored in the sqflite database
//TODO: In this new menu will also be contained the about us and contact us information