class Play {

  //variables
  var playId;
  var userName;
  var userPhone;
  var playTime;
  var playNum;
  var playCost;

  Play({this.playId, this.userName, this.userPhone, this.playTime, this.playNum, this.playCost});

  factory Play.fromJson(Map<String, dynamic> json){
    return Play(
      playId: json["playId"],
      userName: json["userName"] ,
      userPhone: json["userPhone"],
      playTime: json["playTime"],
      playNum: json["playNum"],
      playCost: json["playCost"]
    );
  }

  Map<String, dynamic> toJson(){
    return{
      'playId': playId,
      'userName': userName,
      'userPhone': userPhone,
      'playTime': playTime,
      'playNum': playNum,
      'playCost': playCost
    };
  }


  /*
    Play:
      "playId" : int
      "userName" : String
      "userPhone" : String
      "playTime" : String
      "playNum" : String
      "playCost" : String
  */
}