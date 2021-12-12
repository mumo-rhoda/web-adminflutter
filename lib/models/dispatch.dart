import 'package:flutter_web_dashboard/models/users.dart';

class Dispatch {
  String teamID;
  String Name;
  String Location;
  String Type;
  String Contact;
  String status;


  Dispatch({
  this.teamID,
    this.Name,
    this.Location,
    this.Type,
    this.Contact,
    this.status,

  });

  String get _teamID => teamID;
  String get _Name => Name;
  String get _Location => Location;
  String get _Type => Type;
  String get _Contact => Contact;
  String get _status => status;

  set _teamID(String newteamID){
    this.teamID = newteamID;
  }
  
  set _Name(String newName){
    this.Name = newName;
  }
  set _Location(String newLocation) {
    this.Location = newLocation;
  }
  set _Type(String newType) {
    this.Type = newType;
  }

  set _Contact(String newContact) {
    this.Contact = newContact;
  }
set _status(String newstatus) {
    this.status = newstatus;
}
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['teamID'] = teamID;
    map['Name'] = Name;
    map['Location'] = Location;
    map['Contact'] = Contact;
    map['Type'] = Type;
    map['status']= status;
    return map;
  }
 Dispatch.fromMapObject(Map<dynamic, dynamic> map) {
    this.teamID = map['teamID'] ?? '';
    this.Name = map['Name'] ?? '';
    this.Location = map['Location'] ?? '';
    this.Type = map['Type'] ?? '';
    this.Contact = map['Contact'] ?? '';
    this.status = map['status'] ?? '';

 }
}