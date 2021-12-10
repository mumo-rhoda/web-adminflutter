import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UpdateEmergencies extends StatefulWidget {
  final String id;
  UpdateEmergencies({Key key, this.id}) : super(key: key);

  @override
  _UpdateEmergenciesState createState() => _UpdateEmergenciesState();
}

class _UpdateEmergenciesState extends State<UpdateEmergencies> {
  final _formKey = GlobalKey<FormState>();

  // Updating emergencyTeam
  CollectionReference emergencies =
  FirebaseFirestore.instance.collection('Reports');
//not added the database function

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Emergency Team"),
      ),
      body: Form(
          key: _formKey,
          // Getting Specific Data by ID
          child: FutureBuilder <DocumentSnapshot>(
            future: FirebaseFirestore.instance
                .collection('Reports')
                .doc(widget.id)
                .get(),
            builder: (_, snapshot) {
              if (snapshot.hasError) {
                print('Something Went Wrong');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              var data = snapshot.data.data();
              var emergencyType = data['emergencyType'];
              var reportParty = data['reportParty'];
              var reportStatus = data['reportSatatus'];
              var  description = data['description'];

              return Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                child: ListView(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10.0),
                      child: TextFormField(
                        initialValue: emergencyType,
                        autofocus: false,
                        onChanged: (value) => emergencyType = value,
                        decoration: InputDecoration(
                          labelText: 'Emergency Type: ',
                          labelStyle: TextStyle(fontSize: 20.0),
                          border: OutlineInputBorder(),
                          errorStyle:
                          TextStyle(color: Colors.redAccent, fontSize: 15),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter EmergencyType';
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10.0),
                      child: TextFormField(
                        initialValue: reportParty,
                        autofocus: false,
                        onChanged: (value) => reportParty = value,
                        decoration: InputDecoration(
                          labelText: 'Report Party: ',
                          labelStyle: TextStyle(fontSize: 20.0),
                          border: OutlineInputBorder(),
                          errorStyle:
                          TextStyle(color: Colors.redAccent, fontSize: 15),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter the reporter';
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10.0),
                      child: TextFormField(
                        initialValue: reportStatus,
                        autofocus: false,
                        onChanged: (value) => reportStatus = value,
                        obscureText: false,
                        decoration: InputDecoration(
                          labelText: 'reportStatus: ',
                          labelStyle: TextStyle(fontSize: 20.0),
                          border: OutlineInputBorder(),
                          errorStyle:
                          TextStyle(color: Colors.redAccent, fontSize: 15),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter reportStatus';
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10.0),
                      child: TextFormField(
                        initialValue: description,
                        autofocus: false,
                        onChanged: (value) => description = value,
                        decoration: InputDecoration(
                          labelText: 'Description: ',
                          labelStyle: TextStyle(fontSize: 20.0),
                          border: OutlineInputBorder(),
                          errorStyle:
                          TextStyle(color: Colors.redAccent, fontSize: 15),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter description';
                          }
                          return null;
                        },
                      ),
                    ),


                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              // Validate returns true if the form is valid, otherwise false.

                                Navigator.pop(context);

                            },
                            child: Text(
                              'Update',
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () => {},
                            child: Text(
                              'Reset',
                              style: TextStyle(fontSize: 18.0),
                            ),
                            style: ElevatedButton.styleFrom(
                                primary: Colors.blueGrey),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          )),
    );
  }
}