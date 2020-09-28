import 'package:flutter/material.dart';
import 'package:triple_eight/MainMenu.dart';
import 'DatabaseHelper.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

//buy tokens class definitions
class BuyTokens extends StatefulWidget{
  @override
  _BuyTokensState createState() => new _BuyTokensState();
}

class _BuyTokensState extends State<BuyTokens>{

  //variable to store money being used
  var _buyingMoney;
  var _password;

  //database instance
  final dbHelper = DatabaseHelper.instance;

  //database variables
  var _id;
  var _name;
  var _surname;
  var _phone;
  var _bankName;
  var _bankAccNum;
  var _balance;

  final _passController = TextEditingController();
  final _buyController = TextEditingController();
  @override
  Widget build(BuildContext context){
    getDataFromRows();
    return new Theme(
      data: Theme.of(context).copyWith(
        scaffoldBackgroundColor: Color(0xff231f20),
        accentColor: Colors.white,
        primaryColor: Colors.white,
      ),
      child: new Builder(
        builder: (context) => Scaffold(
          appBar: AppBar(
            iconTheme: IconTheme.of(context).copyWith(
              color: Colors.white,
            ),
            elevation: 0,
            backgroundColor: Color(0xff231f20),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 30),
                    Container(
                      margin: EdgeInsets.only(
                        top: 20,
                      ),
                      width: 80,
                      height: 80,
                      child: Image.asset('assets/logo.png'),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: 30,
                      ),
                      width: MediaQuery.of(context).size.width *0.75,
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'Buy Playing Units',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Raleway',
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: 30,
                      ),
                      width: MediaQuery.of(context).size.width * 0.65,
                      height: 50,
                      child: TextField(
                        controller: _buyController,
                        decoration: InputDecoration(
                          labelText: 'Enter Amount',
                          labelStyle: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Raleway',
                          ),
                        ),
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Raleway'
                        ),
                        keyboardType: TextInputType.number,
                        onChanged: (text){
                          _buyingMoney = text;
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: 30,
                      ),
                      width: MediaQuery.of(context).size.width * 0.65,
                      height: 50,
                      child: TextField(
                        controller: _passController,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Raleway',
                          ),
                        ),
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Raleway'
                        ),
                        keyboardType: TextInputType.visiblePassword,
                        onChanged: (text){
                          _password = text;
                        },
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        color: Color(0xfff4c111),
                      ),
                      margin: EdgeInsets.only(
                        top: 20,
                      ),
                      width: MediaQuery.of(context).size.width * 0.5,
                      height: 50,
                      child: Padding(
                        padding: EdgeInsets.all(5),
                        child: GestureDetector(
                          onTap: (){
                            //TODO: display a dialog confirming the money, bank name and acc number
                            //write script to add money amount to the server database
                            //go to main menu after purchase has been confirmed
                            buyTokens();
                          },
                          child: Text(
                            'Buy',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Raleway',
                              fontSize: 20,
                              color: Color(0xff231f20),
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
    );
  }

  //get all rows
  void getDataFromRows() async{
    final allRows = await dbHelper.queryAllRows();
    print("Query all rows: ");
    allRows.forEach(
            (row){
          //extract required data into helper variables
          _id = row["id"];
          _name = row["name"];
          _surname = row["surname"];
          _phone = row["phone"];
          _bankName = row["bankName"];
          _bankAccNum = row["bankAccNum"];
          _balance = row["money_amount"];

          print("Helper variables have been set : "+" "+_name+" "+_phone+" "+_balance.toString());
        }
    );
  }

  //buy token script run
  buyTokens() async{
    Map<String, dynamic> data = {
      "name" : _name,
      "phone": _phone,
      "tokens": _buyingMoney,
      "bankAccNum" : _bankAccNum
    };

    print(jsonEncode(data));
    var url = "http://192.168.43.56/triple8/buy.php";
    Map<String, String> headers = {"Content-Type": "application/json"};
    http.Response response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(data)
    );

    //handle response
    Map<String, dynamic> result = jsonDecode(response.body);
    print(result);
    if(result.length == 7){
      update(result);
      goToMain();
    }else{
      print(result["message"]);
    }

  }

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

  //update money upon successful play
  void update(Map<String, dynamic> result) async{
    //row to update
    Map<String, dynamic> row = result;

    print("Internal database: "+row.toString());

    final rowsAffected = await dbHelper.update(row);
    print('updated $rowsAffected row(s)');
  }
}