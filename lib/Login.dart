import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'MainMenu.dart';
import 'CreateAccount.dart';
import 'DatabaseHelper.dart';

//Login widget implementation
class Login extends StatefulWidget{
  @override
  _LoginState createState() => new _LoginState();
}

class _LoginState extends State<Login>{

  //Database helper
  final dbHelper = DatabaseHelper.instance;
  //response variables
  var responseName;
  var responseSurname;
  var responsePhone;
  var responseBankName;
  var responseBankAccNum;
  var responseMoney;

  //variable declarations
  var _name;
  var _phone;

  //controller for retrieving textfield data
  var _nameController = TextEditingController();
  var _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context){
    return new Scaffold(
        body: SingleChildScrollView(
          child: SafeArea(
            child:Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: <Widget>[
                  Container(
                    width: 90,
                    height: 90,
                    margin: const EdgeInsets.only(
                        top: 40
                    ),
                    child: Image.asset('assets/logo.png'),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      top: 30,
                    ),
                    child: Text(
                      'Login',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30,
                        fontFamily: 'Raleway_bold',
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    child: Padding(
                        padding: const EdgeInsets.only(
                            left: 12,
                            right: 12
                        ),
                        child: Text(
                          'Enter your credentials below and start playing.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Raleway',
                            color: Color(0xfff4c111),
                          ),
                        )
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width *0.65,
                    height: 50,
                    margin: const EdgeInsets.only(
                      top: 35,
                    ),
                    child: TextField(
                      controller: _nameController,
                      autofocus: false,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontFamily: 'Raleway',
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        labelText: "Name",
                        labelStyle: TextStyle(
                          fontFamily: 'Raleway',
                          color :Colors.white,
                        ),
                      ),
                      keyboardType: TextInputType.text,

                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.65,
                    height:50,
                    margin: const EdgeInsets.only(
                      top: 20,
                    ),
                    child: TextField(
                      controller: _phoneController,
                      autofocus: false,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontFamily: 'Raleway',
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
                        labelStyle: TextStyle(
                          fontFamily: 'Raleway',
                          color: Colors.white,
                        ),

                      ),
                      keyboardType: TextInputType.phone,
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    height: 50,
                    margin: const EdgeInsets.only(
                      top: 35,
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xfff4c111),
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: GestureDetector(
                          onTap:(){
                            //check login details and verify from server, then go to the menu activity
                            print('Login has been clicked. Go to Main');
                            loginRequest();
                          },
                          child: Text(
                            'Login',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color(0xff231f20),
                                fontFamily: 'Raleway',
                                fontSize: 22
                            ),
                          )
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 90,
                    height: 50,
                    margin: const EdgeInsets.only(
                      top: 10,
                    ),
                    child: GestureDetector(
                      onTap: (){
                        print('Register Activity Click.');
                        goToCreate();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text('Don\'t have an account\?', style:TextStyle(fontSize: 18, fontFamily:'Raleway', color: Color(0xffeeeeee))),
                          Text('Register', style: TextStyle(fontSize: 18, fontFamily: 'Raleway', color: Color(0xfff4c111))),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }

  //login method using http library/package
  loginRequest() async {

    //initialize
    _name = _nameController.text;
    _phone = _phoneController.text;

    Map<String, dynamic> postData = {
      "name" : _name,
      "phone" : _phone
    };
    var jsonVar = json.encode(postData);

    print(json);
    Map<String, String> headers = {
      "Content-Type": "application/json"
    };
    final url = "http://192.168.43.56/triple888/login.php";

    //request from the server
    http.Response response = await http.post(
      url,
      headers: headers,
      body: jsonVar,
    );

    //handle response
    var data = jsonDecode(response.body);
    print(data.toString());

    Map<String, dynamic> object = jsonDecode(response.body);
    int success = object["success"];
    String message = object["message"];
    responseName = object["userName"];
    responseSurname = object["userSurname"];
    responsePhone = object["userPhone"];
    responseBankName = object["bankName"];
    responseBankAccNum = object["bankAccNum"];
    responseMoney = object["money"];

    if(success == 1){
      //delete the current values in the sqflite database and insert the confirmed data
      print(message+" "+responseName+" "+responseSurname+" "+responsePhone+" "+responseBankAccNum+" "+responseBankName+" "+responseMoney);
      _insert();
      goToMain();
    }else{
      print(message);
    }
  }

  //method to insert data into database
  void _insert() async{
    //row insert
    Map<String, dynamic> row = {
      DatabaseHelper.columnId : 1,
      DatabaseHelper.columnName : responseName,
      DatabaseHelper.columnSurname: responseSurname,
      DatabaseHelper.columnPhone : responsePhone,
      DatabaseHelper.columnBankName: responseBankName,
      DatabaseHelper.columnBankAccNum: responseBankAccNum,
      DatabaseHelper.columnMoney: responseMoney
    };

    final id = await dbHelper.insert(row);
    print('inserted row id : $id');
  }
  //go to main menu
  void goToMain(){
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
          builder: (BuildContext context){
            return MaterialApp(
              home: MainMenu(),
              theme: ThemeData(
                scaffoldBackgroundColor: Color(0xff231f20),
                accentColor: Colors.white,
                primaryColor: Colors.white,
              ),
            );
          }),
    );
  }

  //go to create account
  void goToCreate(){
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
          builder: (BuildContext context){
            return MaterialApp(
              home: CreateAccount(),
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
