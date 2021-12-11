import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddDispatchTeamPage extends StatefulWidget {
  AddDispatchTeamPage({Key key}) : super(key: key);

  @override
  _AddDispatchTeamPageState createState() => _AddDispatchTeamPageState();
}

class _AddDispatchTeamPageState extends State<AddDispatchTeamPage> {
  final _formKey = GlobalKey<FormState>();

  var Name = "";
  var Contact = "";
  var Location = "";
  var Type = "";
  var status ="";
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final NameController = TextEditingController();
  final ContactController = TextEditingController();
  final LocationController = TextEditingController();
  final TypeController = TextEditingController();
  final statusController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    NameController.dispose();
    ContactController.dispose();
    LocationController.dispose();
    TypeController.dispose();
    statusController.dispose();

    super.dispose();
  }

  clearText() {
    NameController.clear();
    ContactController.clear();
    LocationController.clear();
    TypeController.clear();
    statusController.clear();
  }

  // Adding Dispatch
  CollectionReference dispatch =
  FirebaseFirestore.instance.collection('DispatchTeams');

  Future<void> addDispatch() {
    return dispatch
        .add({'Name': Name, 'Contact': Contact, 'Location': Location, 'Type': Type, 'status': status })
        .then((value) => print('DispatchTeam Added'))
        .catchError((error) => print('Failed to Add user: $error'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Dispatch team"),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
          child: ListView(
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.0),
                child: TextFormField(
                  autofocus: false,
                  decoration: InputDecoration(
                    labelText: 'Name: ',
                    labelStyle: TextStyle(fontSize: 20.0),
                    border: OutlineInputBorder(),
                    errorStyle:
                    TextStyle(color: Colors.redAccent, fontSize: 15),
                  ),
                  controller: NameController,
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
                  autofocus: false,
                  decoration: InputDecoration(
                    labelText: 'Contact: ',
                    labelStyle: TextStyle(fontSize: 20.0),
                    border: OutlineInputBorder(),
                    errorStyle:
                    TextStyle(color: Colors.redAccent, fontSize: 15),
                  ),
                  controller: ContactController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter the DispatchContact';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.0),
                child: TextFormField(
                  autofocus: false,
                  obscureText: false,
                  decoration: InputDecoration(
                    labelText: 'Location: ',
                    labelStyle: TextStyle(fontSize: 20.0),
                    border: OutlineInputBorder(),
                    errorStyle:
                    TextStyle(color: Colors.redAccent, fontSize: 15),
                  ),
                  controller: LocationController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter the Current Location of Dispatch Team';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.0),
                child: TextFormField(
                  autofocus: false,
                  obscureText: false,
                  decoration: InputDecoration(
                    labelText: 'Type: ',
                    labelStyle: TextStyle(fontSize: 20.0),
                    border: OutlineInputBorder(),
                    errorStyle:
                    TextStyle(color: Colors.redAccent, fontSize: 15),
                  ),
                  controller: TypeController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter what the DispatchTeam covers';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.0),
                child: TextFormField(
                  autofocus: false,
                  obscureText: false,
                  decoration: InputDecoration(
                    labelText: 'Status: ',
                    labelStyle: TextStyle(fontSize: 20.0),
                    border: OutlineInputBorder(),
                    errorStyle:
                    TextStyle(color: Colors.redAccent, fontSize: 15),
                  ),
                  controller: statusController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter the Current Status of the Dispatch Team';
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
                          setState(() {
                            Name = NameController.text;
                            Contact = ContactController.text;
                            Location = LocationController.text;
                            Type = TypeController.text;
                            status = statusController.text;
                            addDispatch();
                            clearText();
                          });
                        }
                      },
                      child: Text(
                        'Create',
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => {clearText()},
                      child: Text(
                        'Cancel',
                        style: TextStyle(fontSize: 18.0),
                      ),
                      style: ElevatedButton.styleFrom(primary: Colors.blueGrey),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}