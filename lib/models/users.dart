

class Users{
  String uid;
  String email;
  String phonenumber;
  String fullname;
  String userType;
  String status;
  String username;



  Users({
    this.uid,
    this.email,
    this.phonenumber,
    this.fullname,
    this.userType,
    this.status,
    this.username,
  });

  String get _uid => uid;
  String get _email => email;
  String get _fullname => fullname;
  String get _userType => userType;
  String get _status => status;
  String get _phonenumber => phonenumber;
  String get _username => username;


  set _uid(String newID){
    this.uid = newID;
  }

  set _email(String newEmail){
    this.email = newEmail;
  }

  set _fullname(String newfullname){
    this.fullname = newfullname;
  }

  set _userType(String newUserType){
    this.userType = newUserType;
  }

  set _status(String newStatus){
    this.status = newStatus;
  }



  set _phonenumber(String newPhonenumber){
    this.phonenumber = newPhonenumber;
  }


  set _username(String newusername){
    this.username = newusername;
  }








  //Convert Users into a Map object
  Map<String, dynamic> toMap(){
    var map = Map<String, dynamic>();


    map['uid'] = uid;
    map['email'] = email;
    map['fullname'] = fullname;
    map['userType'] = userType;
    map['status'] = status;
    map['phonenumber'] = phonenumber;
    map['username'] = username;
    return map;
  }


  //Extract a Userss object from a Map object
  Users.fromMapObject(Map<dynamic, dynamic> map){
    this.uid = map['uid'] ?? '';
    this.email = map['email'] ?? '';
    this.fullname = map['fullname'] ?? '';
    this.userType = map['userType'] ?? '';
    this.status = map['status'] ?? '';
    this.phonenumber = map['phonenumber'] ?? '';
    this.username = map['username'] ?? '';
    }

}