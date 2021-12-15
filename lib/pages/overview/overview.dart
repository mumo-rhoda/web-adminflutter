// ignore_for_file: unused_import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_dashboard/bloc/SortingBloc.dart';
import 'package:flutter_web_dashboard/helpers/reponsiveness.dart';
import 'package:flutter_web_dashboard/constants/controllers.dart';
import 'package:flutter_web_dashboard/models/emegercies.dart';
import 'package:flutter_web_dashboard/models/users.dart';
import 'package:flutter_web_dashboard/pages/overview/widgets/latestemergencycases.dart';
import 'package:flutter_web_dashboard/pages/overview/widgets/mapsWidget.dart';
import 'package:flutter_web_dashboard/pages/overview/widgets/overview_cards_large.dart';
import 'package:flutter_web_dashboard/pages/overview/widgets/overview_cards_medium.dart';
import 'package:flutter_web_dashboard/pages/overview/widgets/overview_cards_small.dart';
import 'package:flutter_web_dashboard/services/FirestoreDB.dart';

import 'package:flutter_web_dashboard/widgets/custom_text.dart';
import 'package:get/get.dart';

class OverviewPage extends StatefulWidget {
  @override
  State<OverviewPage> createState() => _OverviewPageState();
}

class _OverviewPageState extends State<OverviewPage> {
  List<Emergencies> uRequestsList = [];
  List<Users> usersList = [];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SortingBloc, String>(

        builder: (context, sortingValue) {

        return StreamBuilder<QuerySnapshot>(
            stream: FirestoreDB().mUserstream,
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                            Emergencies emergency = Emergencies.fromMapObject(element.data());

                            if(checkSortingCondition(emergency, sortingValue) && emergency.ReportStatus != "Deleted"){
                              uRequestsList.add(emergency);
                            }


                          });
                        }
                        return Container(
                          child: Column(
                            children: [
                              Obx(
                                () => Row(
                                  children: [
                                    Container(
                                        margin: EdgeInsets.only(
                                            top: ResponsiveWidget.isSmallScreen(
                                                    context)
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
                                  child: ListView(
                                children: [
                                  if (ResponsiveWidget.isLargeScreen(context) ||
                                      ResponsiveWidget.isMediumScreen(context))
                                    if (ResponsiveWidget.isCustomSize(context))
                                      OverviewCardsMediumScreen(
                                        emergencies: uRequestsList,
                                        users: usersList,
                                      )
                                    else
                                      OverviewCardsLargeScreen(
                                        emergencies: uRequestsList,
                                        users: usersList,
                                      )
                                  else
                                    OverviewCardsSmallScreen(
                                      emergencies: uRequestsList,
                                      users: usersList,
                                    ),
                                  LatestEmergencyCases(
                                    emergencies: uRequestsList,
                                    users: usersList,
                                  ),
                                ],
                              ))
                            ],
                          ),
                        );
                      } else {
                        return Container();
                      }
                    });
              } else {
                return Container();
              }
            });
      }
    );
  }

  bool checkSortingCondition(Emergencies emergency, String searchCriteria) {
    DateTime mDateTime = DateTime.now();
    print ("searchCriteria $searchCriteria");

    switch (searchCriteria){
      case "All": return true;
      break;
      case "Today": return emergency.dateTime.day == mDateTime.day && emergency.dateTime.month == mDateTime.month && emergency.dateTime.year == mDateTime.year;
      break;
      case "This Month": return  emergency.dateTime.month == mDateTime.month && emergency.dateTime.year == mDateTime.year;
      break;
      case "This year": return emergency.dateTime.year == mDateTime.year;
      break;
      default: return true;

    }

  }
}
