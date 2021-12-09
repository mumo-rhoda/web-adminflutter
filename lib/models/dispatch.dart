import 'package:flutter_web_dashboard/models/users.dart';

class Dispatch {

  String Name;
  String Location;
  String Type;
  String Contact;
  String uid;


  Dispatch({
    this.Name,
    this.Location,
    this.Type,
    this.Contact,

  });
  
  String get _Name => Name;
  String get _Location => Location;
  String get _Type => Type;
  String get _Contact => Contact;
  
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

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map['Name'] = Name;
    map['Location'] = Location;
    map['Contact'] = Contact;
    map['Type'] = Type;
    return map;
  }
 Dispatch.fromMapObject(Map<dynamic, dynamic> map) {
    this.Name = map['Name'] ?? '';
    this.Location = map['Location'] ?? '';
    this.Type = map['Type'] ?? '';
    this.Contact = map['Contact'] ?? '';

 }
}