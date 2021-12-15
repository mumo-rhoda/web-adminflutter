import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_web_dashboard/models/dispatch.dart';
import 'package:flutter_web_dashboard/models/emegercies.dart';
import 'package:flutter_web_dashboard/models/users.dart';

class FirestoreDB {
  final String uid;
  final String service;
  final Emergencies emergency;
  final String teamID;


  FirestoreDB({this.uid, this.service, this.emergency, this.teamID});

  Future<bool> updateEmergency(Emergencies emergency) async {
    return await FirebaseFirestore.instance
        .collection("Reports")
        .doc(emergency.EmergencyID)
        .update(emergency.toMap())
        .then((value) {
      return true;
    });
  }


  Future<bool> updateUser(Users user) async {
    return await FirebaseFirestore.instance
        .collection("Users")
        .doc(user.uid)
        .update(user.toMap())
        .then((value) {
      return true;
    });
  }
  Future<bool> updateDispatchTeam(Dispatch dispatch) async {
    return await FirebaseFirestore.instance
        .collection("DispatchTeams")
        .doc(dispatch.teamID)
        .update(dispatch.toMap())
        .then((value) {
      return true;
    });
  }
  



  Stream<QuerySnapshot> get mEmergenciesStream {
    return FirebaseFirestore.instance.collection("Reports").snapshots();
  }

  Stream<QuerySnapshot> get mUserstream {
    return FirebaseFirestore.instance.collection("Users").snapshots();
  }

  Stream<QuerySnapshot> get mDispatchstream {
    return FirebaseFirestore.instance.collection("DispatchTeams").snapshots();
  }
}
