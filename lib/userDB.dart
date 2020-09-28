class userDB {
  final int id;
  final String name;
  final String surname;
  final String phone;
  final String bankAccNum;
  final String bankName;
  final int money;

  static final columns = ["id", "name", "surname", "phone", "bankAccNum", "bankName", "money"];

  userDB(this.id, this.name, this.surname, this.phone, this.bankAccNum, this.bankName, this.money);

  factory userDB.fromMap(Map<String, dynamic> data){
    return userDB(
      data['id'],
      data['name'],
      data['surname'],
      data['phone'],
      data['bankAccNum'],
      data['bankName'],
      data['money']
    );
  }

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "surname": surname,
    "phone": phone,
    "bankAccNum": bankAccNum,
    "bankName": bankName,
    "money": money
  };

  //returns the objects phone literal
  String getPhone(){
    return this.phone;
  }
}