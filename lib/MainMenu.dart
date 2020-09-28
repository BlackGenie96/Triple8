import 'package:flutter/material.dart';
import 'Instructions.dart';
import 'PlayMenu.dart';
import 'Activities.dart';
import 'BuyTokens.dart';
import 'DatabaseHelper.dart';
import 'Login.dart';
import 'userDB.dart';
import 'dart:convert';

//Main Menu Activity class definitions
class MainMenu extends StatefulWidget{
  @override
  _MainMenuState createState() => new _MainMenuState();
}

class _MainMenuState extends State<MainMenu>{

  //class variables
  final dbHelper = DatabaseHelper.instance;

  //global user class object instance
  userDB user;

  @override
  void initState(){
    super.initState();
    getDataFromRows();
  }

  @override
  Widget build(BuildContext context){
    return new Scaffold(
      body: SafeArea(
        child:SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: <Widget>[
                Container(
                  margin:const EdgeInsets.only(
                    top: 30,
                  ),
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Image.asset('assets/logo.png'),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    color: Color(0xfff4c111),
                  ),
                  margin: const EdgeInsets.only(
                    top: 30,
                  ),
                  width: MediaQuery.of(context).size.width * 0.65,
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: GestureDetector(
                      onTap:(){
                        print("Instructions has been clicked.");
                        goToInstructions();
                      },
                      child: Text(
                        'Instructions',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Raleway',
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          color: Color(0xff231f20),
                        ),
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
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    border: Border.all(color: Color(0xfff4c111)),
                    color: Color(0xff231f20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: GestureDetector(
                      onTap: (){
                        print("Play button clicked.");
                        goToPlay();
                      },
                      child: Text(
                        'Play',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Raleway',
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 30,
                  ),
                  width: MediaQuery.of(context).size.width * 0.65,
                  height:50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    color: Color(0xff231f20),
                    border: Border.all(color: Color(0xfff4c111), width: 1),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: GestureDetector(
                      onTap: (){
                        print("Buy tokens for playing clicked");
                        goBuyTicket();
                      },
                      child: Text(
                        'Buy Playing Units',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Raleway',
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
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
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    color: Color(0xfff4c111),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: GestureDetector(
                      onTap: (){
                        print("Going to activities screen");
                        goToActivities();
                      },
                      child: Text(
                        'Activity',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Raleway',
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff231f20),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    top:30,
                    bottom: 20,
                  ),
                  child: GestureDetector(
                      onTap: (){
                        print("Logout button clicked");
                        logOut();
                      },
                      child: Text(
                        'Logout',
                        style: TextStyle(
                          fontFamily: 'Raleway',
                          fontSize: 22,
                          color: Colors.white,
                        ),
                      )
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //go to play menu method
  void goToPlay(){
    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (BuildContext context) => PlayMenu(),
      ),
    );
  }

  //go to instructions method
  void goToInstructions(){
    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (BuildContext context)=> Instructions()
      ),
    );
  }

  //go to buy ticket menu
  void goBuyTicket(){
    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (BuildContext context) => BuyTokens()
      ),
    );
  }

  //go to activities screen
  void goToActivities(){
    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (BuildContext context) => Activities(user: this.user)
      ),
    );
  }

  //go to login screen
  void goToLogin(){
    Navigator.of(context).push(
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

  //handle logout
  void logOut() async{
    //delete according to id which is 1
    final id = await dbHelper.queryRowCount();
    final rowDeleted = await dbHelper.delete(id);
    print('deleted $rowDeleted row(s): row $id');
    goToLogin();
  }

  //get all rows
  void getDataFromRows() async{
    final allRows = await dbHelper.queryAllRows();
    print("Query all rows: ");
    allRows.forEach(
            (row){
          //extract required data into helper variables
          var _id = row["id"];
          var _userName = row["name"];
          var _userSurname = row["surname"];
          var _userPhone = row["phone"];
          var _userBankName = row["bankName"];
          var _userBankAccNum = row["bankAccNum"];
          var _userMoney = row["money_amount"];
          user = new userDB(_id, _userName, _userSurname, _userPhone, _userBankAccNum, _userBankName, _userMoney);
        }
    );

    print("User set: "+" "+user.name+" "+user.surname+" "+user.money.toString());
  }
}