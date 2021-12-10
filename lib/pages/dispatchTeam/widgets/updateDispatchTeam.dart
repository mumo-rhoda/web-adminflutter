import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UpdateDispatchTeamPage extends StatefulWidget {
  final String id;
  UpdateDispatchTeamPage({Key key, this.id}) : super(key: key);

  @override
  _UpdateDispatchTeamPageState createState() => _UpdateDispatchTeamPageState();
}

class _UpdateDispatchTeamPageState extends State<UpdateDispatchTeamPage> {
  final _formKey = GlobalKey<FormState>();

  // Updaing DispatchTeam
  CollectionReference dispachref =
  FirebaseFirestore.instance.collection('DispatchTeams');

  Future updateDispatch(id, Contact, Location, Name, Type, status) {
    return dispachref
        .doc(id)
        .update({'Name': Name, 'Contact': Contact, 'Location': Location, 'Type': Type, 'status': status,})
        .then((value) => print("Dispatch Team Updated"))
        .catchError((error) => print("Failed to update Dispatch Team: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Dispatch Team"),
      ),
      body: Form(
          key: _formKey,
          // Getting Specific Data by ID
          child: FutureBuilder <DocumentSnapshot>(
            future: FirebaseFirestore.instance
                .collection('DispatchTeams')
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
              var Name = data['Name'];
              var Contact = data['Contact'];
              var Location = data['Location'];
              var Type = data['Type'];
              var status = data['status'];
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                child: ListView(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10.0),
                      child: TextFormField(
                        initialValue: Name,
                        autofocus: false,
                        onChanged: (value) => Name = value,
                        decoration: InputDecoration(
                          labelText: 'Name: ',
                          labelStyle: TextStyle(fontSize: 20.0),
                          border: OutlineInputBorder(),
                          errorStyle:
                          TextStyle(color: Colors.redAccent, fontSize: 15),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Name';
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10.0),
                      child: TextFormField(
                        initialValue: Contact,
                        autofocus: false,
                        onChanged: (value) => Contact = value,
                        decoration: InputDecoration(
                          labelText: 'Contact: ',
                          labelStyle: TextStyle(fontSize: 20.0),
                          border: OutlineInputBorder(),
                          errorStyle:
                          TextStyle(color: Colors.redAccent, fontSize: 15),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Contact';
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10.0),
                      child: TextFormField(
                        initialValue: Location,
                        autofocus: false,
                        onChanged: (value) => Location = value,
                        obscureText: false,
                        decoration: InputDecoration(
                          labelText: 'Location: ',
                          labelStyle: TextStyle(fontSize: 20.0),
                          border: OutlineInputBorder(),
                          errorStyle:
                          TextStyle(color: Colors.redAccent, fontSize: 15),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Location';
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10.0),
                      child: TextFormField(
                        initialValue: Type,
                        autofocus: false,
                        onChanged: (value) => Name = value,
                        decoration: InputDecoration(
                          labelText: 'Type: ',
                          labelStyle: TextStyle(fontSize: 20.0),
                          border: OutlineInputBorder(),
                          errorStyle:
                          TextStyle(color: Colors.redAccent, fontSize: 15),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Type';
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10.0),
                      child: TextFormField(
                        initialValue: status,
                        autofocus: false,
                        onChanged: (value) => Name = value,
                        decoration: InputDecoration(
                          labelText: 'status: ',
                          labelStyle: TextStyle(fontSize: 20.0),
                          border: OutlineInputBorder(),
                          errorStyle:
                          TextStyle(color: Colors.redAccent, fontSize: 15),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter status';
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
                              if (_formKey.currentState.validate()) {
                                updateDispatch(widget.id, Contact, Name, Location, Type, status);
                                Navigator.pop(context);
                              }
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