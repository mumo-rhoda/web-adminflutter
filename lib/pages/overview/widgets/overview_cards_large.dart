// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_web_dashboard/models/emegercies.dart';
import 'package:flutter_web_dashboard/models/users.dart';
import 'package:flutter_web_dashboard/pages/Emergencies/emergencies.dart';
import 'package:flutter_web_dashboard/pages/overview/widgets/info_card.dart';
import 'package:flutter_web_dashboard/pages/users/users.dart';
import 'package:flutter_web_dashboard/pages/users/widgets/users_table.dart';

class OverviewCardsLargeScreen extends StatelessWidget {
  List<Emergencies> emergencies;
  List<Users> users;
  OverviewCardsLargeScreen({this.emergencies, this.users});

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;

    return Row(
      children: [
        InfoCard(
          title: "App Users",
          value: users
              .where((element) => element.userType != "Deleted")
              .toList()
              .length
              .toString(),
          onTap: () {Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => UsersPage(),)
          );},
          topColor: Colors.orange,
        ),
        SizedBox(
          width: _width / 64,
        ),
        InfoCard(
          title: "Emergency_Reports",
          value: emergencies.length.toString(),
          topColor: Colors.lightGreen,
          onTap: () {Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => EmergenciesPage(),)
          );},
        ),
        SizedBox(
          width: _width / 64,
        ),
        InfoCard(
          title: "ClosedEmergencyCase",
          value: emergencies
              .where((element) => element.ReportStatus == "Closed")
              .toList()
              .length
              .toString(),
          onTap: () {},
        ),
        SizedBox(
          width: _width / 64,
        ),
        InfoCard(
          title: "PendingCases",
          value: emergencies
              .where((element) => element.ReportStatus == "Pending")
              .toList()
              .length
              .toString(),
          onTap: () {},
        ),
      ],
    );
  }
}
