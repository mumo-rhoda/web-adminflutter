 // ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_dashboard/constants/controllers.dart';
import 'package:flutter_web_dashboard/generate_report/createPdf.dart';
import 'package:flutter_web_dashboard/helpers/reponsiveness.dart';
import 'package:flutter_web_dashboard/models/dispatch.dart';
import 'package:flutter_web_dashboard/models/emegercies.dart';
import 'package:flutter_web_dashboard/models/users.dart';
import 'package:flutter_web_dashboard/pages/Emergencies/widgets/emergencies_table.dart';
import 'package:flutter_web_dashboard/services/FirestoreDB.dart';
import 'package:flutter_web_dashboard/widgets/custom_text.dart';
import 'package:flutter_web_dashboard/widgets/textFormField.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class EmergenciesPage extends StatefulWidget {
  EmergenciesPage({Key key}) : super(key: key);

  @override
  State<EmergenciesPage> createState() => _EmergenciesPageState();
}

class _EmergenciesPageState extends State<EmergenciesPage> {
  List<Emergencies> uRequestsList = [];
  List<Emergencies> filteredEmergencies = [];


  List<Users> usersList = [];
  List<Dispatch> dispatchList = [];

  String searchValue = '';

  TextEditingController searchController = TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDispatchTeams();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Obx(
                () =>
                Row(
                  children: [
                    Container(
                        margin: EdgeInsets.only(
                            top: ResponsiveWidget.isSmallScreen(context)
                                ? 56
                                : 6),
                        child: CustomText(
                          text: menuController.activeItem.value,
                          size: 24,
                          weight: FontWeight.bold,
                        )),
                  ],
                ),
          ),
          Expanded(
              child: StreamBuilder<QuerySnapshot>(
                  stream: FirestoreDB().mUserstream,
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    usersList.clear();
                    if (snapshot.data != null && snapshot.hasData) {
                      if (snapshot.data.docs.isNotEmpty) {
                        snapshot.data.docs.forEach((element) {
                          Users user = Users.fromMapObject(element.data());

                          usersList.add(user);
                        });
                      }

                      return StreamBuilder<QuerySnapshot>(
                          stream: FirestoreDB().mEmergenciesStream,
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            uRequestsList.clear();
                            if (snapshot.data != null && snapshot.hasData) {
                              if (snapshot.data.docs.isNotEmpty) {
                                snapshot.data.docs.forEach((element) {
                                  Emergencies emergency = Emergencies
                                      .fromMapObject(element.data());

                                  if (emergency.ReportStatus != "Deleted") {
                                    uRequestsList.add(emergency);
                                  }
                                });
                              }

                              if (searchValue != null && searchValue != "") {
                                filteredEmergencies = uRequestsList.where((
                                    emergency) =>

                                usersList
                                    .where((victim) =>
                                victim.fullname.toLowerCase().contains(
                                    searchValue.toLowerCase()) &&
                                    victim.uid == emergency.VictimID)
                                    .toList()
                                    .isNotEmpty
                                    || usersList
                                    .where((victim) =>
                                victim.username.toLowerCase().contains(
                                    searchValue.toLowerCase()) &&
                                    victim.uid == emergency.VictimID)
                                    .toList()
                                    .isNotEmpty
                                    ||
                                    DateFormat.MMMM().format(emergency.dateTime)
                                        .toLowerCase()
                                        .contains(searchValue.toLowerCase())


                                ).toList();
                              } else {
                                filteredEmergencies = uRequestsList;
                              }
                              return ListView(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          width: 350,
                                          child: textField(
                                              context,
                                              controller: searchController,
                                              onChangedFunction: () {
                                                setState(() {
                                                  searchValue =
                                                      searchController.text;
                                                });
                                              },
                                              onTapFunction: () {},
                                              hintText: "Search by Name or Date",
                                              labelText: "Search by Name or Date",
                                              errorMessage: ""),
                                        ),

                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 12.0),
                                          child: IconButton(
                                            icon: Icon(
                                              Icons.search,
                                              size: 30,
                                              color: Colors.red,
                                            ),
                                            onPressed: () {
                                              //executed when user presses back button
                                              setState(() {
                                                searchValue =
                                                    searchController.text;
                                                print("searchController");
                                              });
                                            },
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 60.0, top: 4, right: 12),
                                          child: InkWell(
                                            onTap: () {
                                              createPDF(filteredEmergencies,
                                                  usersList, dispatchList);
                                            },
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment: MainAxisAlignment
                                                  .center,
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .center,
                                              children: [
                                                Text("Generate Report"),
                                                Icon(
                                                  Icons.print,
                                                  color: Colors.redAccent,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Emergenciestable(
                                    emergencies: filteredEmergencies,
                                    users: usersList,
                                  ),
                                ],
                              );
                            } else
                              return Container();
                          });
                    } else
                      return Container();
                  })),
        ],
      ),
    );
  }



  void getDispatchTeams() {



      FirebaseFirestore.instance.collection("DispatchTeams").get().then((querySnapshot) {
        if(querySnapshot.docs.isNotEmpty){
          querySnapshot.docs.forEach((result) async {

            if(result.data() != null){
              setState(() {
                dispatchList.add(Dispatch.fromMapObject(result.data()));


              });
            }



          });
        }
      });



  }
}
