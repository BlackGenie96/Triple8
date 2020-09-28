import 'package:flutter/material.dart';
import 'play.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'DatabaseHelper.dart';
import 'userDB.dart';

//Activity list class definitions
class Activities extends StatefulWidget{

  userDB user;
  Activities({this.user});

  @override
  _ActivitiesState createState() => new _ActivitiesState(user:this.user);
}

class _ActivitiesState extends State<Activities> {
  //holder listview values
  List<Play> list = List<Play>();

  //user variable
  userDB user;
  _ActivitiesState({this.user});

  @override
  void initState(){
    super.initState();
    print(user.name+" "+user.surname+" "+user.bankName+" "+user.bankAccNum+" "+user.money.toString());
  }

  @override
  Widget build(BuildContext context) {
    return new Theme(
      data:Theme.of(context).copyWith(
        scaffoldBackgroundColor: Color(0xff231f20),
        accentColor: Colors.white,
        primaryColor: Colors.white,
      ),
      child: new Builder(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: Text("Activity List"),
            backgroundColor: Color(0xfff4c111),
            iconTheme: IconTheme.of(context).copyWith(
              color: Color(0xff231f20),
            )
          ),
          body: Center(
            child:FutureBuilder<List<Play>>(
                future: getUserActivity(),
                builder: (context, snapshot){
                  if(snapshot.hasData){
                    //custom code here
                    List<Play> data = snapshot.data;
                    return _buildList(data);
                  }else if(snapshot.hasError){
                    return Text('${snapshot.error}');
                  }

                  return CircularProgressIndicator();
                }
            ),
          ),
        ),
      ),
    );
  }

  //listview builder
  Widget _buildList(List<Play> data) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        var num = data[index].playNum.toString();
        var cost = data[index].playCost.toString();
        var time = data[index].playTime.toString();
        return ListTile(
          title: Text('Play Result -> $num : E $cost', style:TextStyle(color:Colors.white)),
          subtitle: Text('$time',style:TextStyle(color:Colors.white)),
        );
      },
    );
  }

  //builds row in the listview
  //TODO : change the userDB instance and define a new instance for play data
  Widget _buildRow(Play data) {
    var _playNum = data.playNum;
    var _playCost = data.playCost;
    var _playTime = data.playTime;

    // (title)xxxxxxxxxx at E 5.00,
    // (subtitle) date
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xfff4c111), width: 2),
        color: Color(0xff231f20),
      ),
      margin: const EdgeInsets.only(top: 5),
      height: 150,
      width: MediaQuery
          .of(context)
          .size
          .width,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                _playNum + _playCost,
                style: TextStyle(
                  fontFamily: 'Raleway',
                  fontSize: 25,
                  color: Colors.white,
                ),
              ),
              Text(
                _playTime,
                style: TextStyle(
                  fontFamily: 'Raleway',
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //get plays from database of type iterable
  Future<List<Play>> getUserActivity() async {
    //get data from the server

    //dummy data for testing, actual data comes from SQFLite database
    Map<String, dynamic> postData = {
      "name": user.name,
      "surname": user.surname,
      "phone": user.phone,
      "bankAccNum": user.bankAccNum,
      "bankName": user.bankName,
      "money": user.money
    };

    print('data: ${json.encode(postData)}');

    //variables
    final url = "http://192.168.43.56/triple888/getUserPlays.php";
    Map<String, String> headers = {"Content-Type": "application/json"};
    http.Response serverList = await http.post(
        url,
        headers: headers,
        body: json.encode(postData)
    );

    print(serverList.body);

    if(serverList.statusCode == 200){
      List jsonResponse = json.decode(serverList.body);
      return jsonResponse.map((item) => Play.fromJson(item)).toList();
    }else{
      throw Exception('Failed to load data from server API');
    }
  }
}