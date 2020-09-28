import 'package:flutter/material.dart';
import 'dart:convert';
import 'Login.dart';
import 'package:http/http.dart' as http;
import 'MainMenu.dart';
import 'DatabaseHelper.dart';

//Create Account activity class definitions
class CreateAccount extends StatefulWidget{
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount>{

  //database instance
  final dbHelper = DatabaseHelper.instance;

  //variables to keep the sign up information for the user
  String _name;
  String _surname;
  String _phoneNum;
  String _bankName;
  String _accNum;
  String _idNumber;

  //controllers for getting text from TextField
  final _nameController = TextEditingController();
  final _surnameController = TextEditingController();
  final _phoneNumController = TextEditingController();
  final _bankNameController = TextEditingController();
  final _accNumController = TextEditingController();
  final _idNumController = TextEditingController();

  @override
  Widget build(BuildContext context){
    return new Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: <Widget>[
                Container(
                    margin: const EdgeInsets.only(
                      top: 40,
                    ),
                    width: 90,
                    height: 90,
                    child: Image.asset('assets/logo.png')
                ),
                Container(
                  margin: const EdgeInsets.only(
                    top: 20,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(
                      'Create Account',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Raleway',
                        fontSize: 35,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.65,
                  height: 50,
                  margin: const EdgeInsets.only(
                    top: 30,
                  ),
                  child: TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: 'Name',
                        labelStyle: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Raleway',
                        ),
                      ),
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontFamily: 'Raleway',
                        color: Colors.white,
                      ),
                      keyboardType: TextInputType.text,
                      onSubmitted: (text){
                        _name = text;
                      },
                      onChanged: (text){
                        _name = text;
                      }
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.65,
                  height: 50,
                  margin: const EdgeInsets.only(
                    top: 30,
                  ),
                  child: TextField(
                    controller: _surnameController,
                    decoration: InputDecoration(
                      labelText: 'Surname',
                      labelStyle: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Raleway',
                      ),
                    ),
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Raleway',
                    ),
                    keyboardType: TextInputType.text,
                    onSubmitted: (text){
                      _surname = text;
                    },
                    onChanged: (text){
                      _surname = text;
                    },
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width *0.65,
                  height: 50,
                  margin: const EdgeInsets.only(
                    top: 30,
                  ),
                  child: TextField(
                      controller: _phoneNumController,
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
                        labelStyle: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Raleway',
                        ),
                      ),
                      keyboardType: TextInputType.phone,
                      onSubmitted: (text){
                        _phoneNum = text;
                      },
                      onChanged: (text){
                        _phoneNum = text;
                      },
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Raleway',
                      ),
                  ),
                ),
                Container(
                  width:MediaQuery.of(context).size.width * 0.65,
                  height: 50,
                  margin:const EdgeInsets.only(
                    top:30
                  ),
                  child: TextField(
                    controller: _idNumController,
                    decoration: InputDecoration(
                      labelText: 'Identification Number',
                      labelStyle: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Raleway',
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontFamily: 'Raleway',
                      color: Colors.white,
                    ),
                  )
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.65,
                  height: 50,
                  margin: const EdgeInsets.only(
                    top: 30,
                  ),
                  child: TextField(
                      controller: _bankNameController,
                      decoration: InputDecoration(
                        labelText: 'Bank Name',
                        labelStyle: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Raleway',
                        ),
                      ),
                      keyboardType: TextInputType.text,
                      onSubmitted: (text){
                        _bankName = text;
                      },
                      onChanged: (text){
                        _bankName = text;
                      },
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontFamily : 'Raleway',
                        color: Colors.white,
                      ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.65,
                  height: 50,
                  margin: const EdgeInsets.only(
                    top: 30,
                  ),
                  child: TextField(
                    controller: _accNumController,
                    decoration: InputDecoration(
                      labelText: 'Account Number',
                      labelStyle: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Raleway',
                      ),
                    ),
                    textAlign : TextAlign.start,
                    style: TextStyle(
                      fontFamily: 'Raleway',
                      color: Colors.white,
                    ),
                    keyboardType: TextInputType.number,
                    onSubmitted: (text){
                      _accNum = text;
                    },
                    onChanged: (text){
                      _accNum = text;
                    },
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    color: Color(0xfff4c111),
                  ),
                  margin: const EdgeInsets.only(
                    top: 45,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: GestureDetector(
                      onTap:(){
                        //dioPost();
                        createDialog();
                      },
                      child: Text(
                        'CREATE ACCOUNT',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Raleway',
                          color: Color(0xff231f20),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    top:30,
                    bottom: 15,
                  ),
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap:(){
                      print("Go to login.");
                      goToLogin();
                    },
                    child:Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('Already have an account?', style: TextStyle(fontFamily: 'Raleway',fontSize: 18,color:Color(0xffeeeeee))),
                        Text('Sign in',style: TextStyle(fontFamily: 'Raleway',fontSize:18 ,color: Color(0xfff4c111))),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //get data from server
  _createAccountRequest() async{
    //get input data from controller
    _name = _nameController.text;
    _surname = _surnameController.text;
    _phoneNum = _phoneNumController.text;
    _bankName = _bankNameController.text;
    _accNum = _accNumController.text;
    _idNumber = _idNumController.text;

    //storing post data
    Map<String,dynamic> postData = {
      "name": _name,
      "surname": _surname,
      "phoneNum": _phoneNum,
      "bankName": _bankName,
      "accNum": _accNum,
      "idNum" : _idNumber
    };

    print(jsonEncode(postData));
    var url = 'http://192.168.43.56/triple8/register.php';
    Map<String,String> headers = {"Content-Type":"application/json"};
    http.Response response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(postData),
    );
    Map<String,dynamic> data = jsonDecode(response.body);
    int success = data['success'];
    String message = data['message'];

    if(success == 1){
      print(message);
      //insert userdata into sqflite database
      _insert();
      goToMain();
    }else{
      print(message);
    }
  }

  //create alert dialog
  void createDialog() async{
    await showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(
            title: Text('Terms Of Use'),
            actions: <Widget>[
              MaterialButton(
                child: Text('Ok'),
                onPressed: (){
                  _createAccountRequest();
                  Navigator.of(context).pop();
                },
              ),
              MaterialButton(
                child: Text('Cancel'),
                onPressed: () => Navigator.of(context).pop()
              ),
            ],
            content: Text(
              'You are warned that this service is only for people over the age of 18. If you are below 18 and happen to win, know that you will not get any rewards from the facilitators of this service.',
              textAlign: TextAlign.center,
            ),
          )
    );
  }

  //insert into database table
  void _insert() async{
    Map<String, dynamic> row = {
      DatabaseHelper.columnId : 1,
      DatabaseHelper.columnName: _name,
      DatabaseHelper.columnSurname : _surname,
      DatabaseHelper.columnPhone : _phoneNum,
      DatabaseHelper.columnBankName : _bankName,
      DatabaseHelper.columnBankAccNum : _accNum,
      DatabaseHelper.columnMoney : 0
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
              ),
            );
          }),
    );
  }

  //go to login
  void goToLogin(){
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return MaterialApp(
            home: Login(),
            theme: ThemeData(
              scaffoldBackgroundColor: Color(0xff231f20),
            ),
          );
        },
      ),
    );
  }
}
