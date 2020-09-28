import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:triple_eight/userDB.dart';
import 'PlayResult.dart';
import 'DatabaseHelper.dart';

//Play menu class definitions
class PlayMenu extends StatefulWidget{
  @override
  _PlayMenuState createState() => new _PlayMenuState();
}

class _PlayMenuState extends State<PlayMenu>{

  //database instance
  final dbHelper = DatabaseHelper.instance;

  //helper variables
  var _id;
  var _userName;
  var _userSurname;
  var _userPhone;
  var _userBankName;
  var _userBankAccNum;
  var _userMoney;
  var secondMoney;

  initState(){
    super.initState();
    getDataFromRows();
  }

  @override
  Widget build(BuildContext context){
    //populate data to be sent to the server

    return new Theme(
      data:Theme.of(context).copyWith(
        scaffoldBackgroundColor: Color(0xff231f20),
      ),
      child: new Builder(
        builder:(context) =>Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xff231f20),
            iconTheme: IconTheme.of(context).copyWith(
              color:Colors.white,
            ),
            elevation: 0,
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Center(
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
                        margin: const EdgeInsets.only(
                          top: 20.0,
                          bottom: 12,
                        ),
                        child: Text(
                          'E $secondMoney.00',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Raleway',
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                          border: Border.all(color: Color(0xfff4c111), width: 1,),
                          color: Color(0xff231f20),
                        ),
                        width: MediaQuery.of(context).size.width * 0.65,
                        height: 55,
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: GestureDetector(
                            onTap: (){
                              print('General play has been clicked.');
                              createDialog(2);
                            },
                            child: Text(
                              'Play - E 2.00',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Raleway',
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Color(0xfff4c111), width: 1),
                          color: Color(0xff231f20),
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        ),
                        width: MediaQuery.of(context).size.width *0.65,
                        height: 55,
                        margin: const EdgeInsets.only(
                          top: 20,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: GestureDetector(
                            onTap:(){
                              print("Premium play has been clicked.");
                              createDialog(5);
                            },
                            child: Text(
                              'Play - E 5.00',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Raleway',
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Color(0xfff4c111), width: 1),
                          color: Color(0xff231f20),
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        ),
                        width: MediaQuery.of(context).size.width *0.65,
                        height: 55,
                        margin: const EdgeInsets.only(
                          top: 20,
                          bottom: 20,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: GestureDetector(
                            onTap:(){
                              print("Gold play has been clicked.");
                              createDialog(10);
                            },
                            child: Text(
                              'Play - E 10.00',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Raleway',
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white,
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
        ),
      ),
    );
  }

  //dialog to confirm the extraction of money from the users account
  void createDialog(int amount) async{
    await showDialog(
      context : context,
      builder: (context) =>
          AlertDialog(
            title: Text('Confirm Transaction :'),
            actions: <Widget>[
              MaterialButton(
                child: Text('Accept'),
                onPressed: (){
                  switch(amount){
                    case 2:
                      playGeneral();
                      break;
                    case 5:
                      playPremium();
                      break;
                    case 10:
                      playGold();
                      break;
                  }
                  Navigator.of(context).pop();
                },
              ),
              MaterialButton(
                child: Text('Cancel'),
                onPressed: (){
                  Navigator.of(context).pop();
                },
              ),
            ],
            content: Text('Are you sure you want to deduct E $amount.00 from E $secondMoney.00 ?'),
          )
    );
  }

  //update money upon successful play
  void updateMoney() async{
    //row to update
    Map<String, dynamic> row = {
      DatabaseHelper.columnId: 1,
      DatabaseHelper.columnName: _userName,
      DatabaseHelper.columnSurname: _userSurname,
      DatabaseHelper.columnPhone: _userPhone,
      DatabaseHelper.columnBankName: _userBankName,
      DatabaseHelper.columnBankAccNum: _userBankAccNum,
      DatabaseHelper.columnMoney: _userMoney
    };

    final rowsAffected = await dbHelper.update(row);
    setMoney(this._userMoney.toString());
    print('updated $rowsAffected row(s)');
  }

  //get all rows
  void getDataFromRows() async{
    final allRows = await dbHelper.queryAllRows();
    print("Query all rows: ");
    allRows.forEach(
        (row){
          //extract required data into helper variables
          this._id = row["id"];
          this._userName = row["name"];
          this._userSurname = row["surname"];
          this._userPhone = row["phone"];
          this._userBankName = row["bankName"];
          this._userBankAccNum = row["bankAccNum"];
          this._userMoney = row["money_amount"];
          var temp = row["money_amount"];
          setMoney(temp.toString());
          print("Helper variables have been set : "+" "+_userName+" "+_userPhone+" "+_userMoney.toString());
        }
    );
  }

  setMoney(var newUserMoney){
    setState(() {
      this.secondMoney = newUserMoney;
    });
  }
  //methods for handling click events on the play buttons
  void playGeneral() async{

    _userMoney = _userMoney - 2;

    //store in map to post in json
    Map<String, dynamic> postData = {
      "play": "1",
      "name": _userName,
      "phone": _userPhone,
      "money": _userMoney
    };

    print(jsonEncode(postData));

    String url = "http://192.168.43.56/triple888/play2.php";
    Map<String,String> headers = {"Content-Type": "application/json"};
    http.Response response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(postData)
    );

    //decode json response from the server
    Map<String, dynamic> data = jsonDecode(response.body);
    int success = data["success"];
    String number = data["number"];
    String message = data["message"];

    //display results screen
    if(success == 1){
      //play response data was retrieved successfully.
      //first print the response body then go to the results activity
      print(number+" - "+message);
      updateMoney();
      goToPlayResults(message, number);
    }else{
      print("There was a problem at the server => "+response.body);
    }
  }

  void playPremium() async{

    _userMoney = _userMoney - 5;

    //store data to post
    Map<String,dynamic> json = {
      "play": "1",
      "name": _userName,
      "phone": _userPhone,
      "money": _userMoney
    };

    print(jsonEncode(json));
    String url = "http://192.168.43.56/triple888/play5.php";
    Map<String, String> headers = {"Content-Type": "application/json"};
    http.Response response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(json),
    );

    //handle server response
    Map<String, dynamic> data = jsonDecode(response.body);
    int success = data["success"];
    String number = data["number"];
    String message = data["message"];

    //display results on screen
    if(success == 1){
      print(number+" - "+message);
      updateMoney();
      goToPlayResults(message, number);
    }else{
      print("There was a problem at the server => "+response.body);
    }
  }

  void playGold() async{

    _userMoney = _userMoney - 10;
    //store data to post
    Map<String, dynamic> json = {
      "play": "1",
      "name": _userName,
      "phone": _userPhone,
      "money": _userMoney
    };

    print(jsonEncode(json));
    String url = "http://192.168.43.56/triple888/play10.php";
    Map<String,String> headers = {"Content-Type": "application/json"};
    http.Response response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(json)
    );

    //handle server response
    Map<String, dynamic> data = jsonDecode(response.body);
    int success = data["success"];
    String number = data["number"];
    String message = data["message"];

    //display results
    if(success == 1){
      //valid response was gotten from server
      //go to results screen
      print(number+" - "+message);
      updateMoney();
      goToPlayResults(message, number);
    }else{
      print("There was a problem at the server : "+response.body);
    }
  }

  //function to go to play results screen
  void goToPlayResults(String message, String number){
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder:(BuildContext context){
              return new MaterialApp(
                  home: PlayResult(message, number),
                  theme: ThemeData(
                    scaffoldBackgroundColor: Color(0xff231f20),
                    primaryColor: Color(0xff231f20),
                  )
              );
            }
        )
    );
  }
}
