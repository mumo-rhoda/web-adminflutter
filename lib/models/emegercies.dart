// ignore_for_file: unused_element, unused_import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

class Emergencies {
  String EmergencyID;

  String VictimID;
  String ReportStatus;
  String ReportType;
  String ReportParty;
  String Description;
  DateTime dateTime;
  LatLng locationLatLng;

  Emergencies(
      {this.EmergencyID,
      this.VictimID,
      this.ReportStatus,
      this.ReportType,
      this.ReportParty,
      this.Description,
      this.locationLatLng,
      this.dateTime});

  String get _EmergencyID => EmergencyID;
  String get _VictimID => VictimID;
  String get _ReportStatus => ReportStatus;
  String get _ReportType => ReportType;
  String get _ReportParty => ReportParty;
  LatLng get _locationLatLng => locationLatLng;

  set _EmergencyID(String newEmergencyID) {
    this.EmergencyID = newEmergencyID;
  }

  set _VictimID(String newVictimID) {
    this.VictimID = newVictimID;
  }

  set _ReportStatus(String newReportStatus) {
    this.ReportStatus = newReportStatus;
  }

  set _ReportType(String newReportType) {
    this.ReportType = newReportType;
  }

  set _ReportParty(String newReportParty) {
    this.ReportParty = newReportParty;
  }

  set _locationLatLng(LatLng newlocationLatLng) {
    this.locationLatLng = newlocationLatLng;
  }

  set _DateTime(DateTime newDateTime) {
    this.dateTime = newDateTime;
  }

  //Convert Emergencies into a Map object
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map['reportID'] = EmergencyID;
    map['uid'] = VictimID;
    map['reportStatus'] = ReportStatus;
    map['emergencyType'] = ReportType;
    map['reportParty'] = ReportParty;
    map['description'] = Description;
    if (dateTime != null) map['timestamp'] = dateTime;
    map['latitude'] = locationLatLng.latitude;
    map['longitude'] = locationLatLng.longitude;

    return map;
  }

  //Extract a Emergencies object from a Map object
  Emergencies.fromMapObject(Map<dynamic, dynamic> map) {
    this.EmergencyID = map['reportID'] ?? '';
    this.VictimID = map['uid'] ?? '';
    this.ReportStatus = map['reportStatus'] ?? '';
    this.ReportType = map['emergencyType'] ?? '';
    this.ReportParty = map['reportParty'] ?? '';
    this.Description = map['description'] ?? '';
    map['timestamp'] != null? this.dateTime =  (map['timestamp'] as Timestamp).toDate():
    this.dateTime = DateTime.now();


    this.locationLatLng =
        new LatLng(map['latitude'] ?? 1.6585, map['longitude'] ?? 29.2205);
  }
}
