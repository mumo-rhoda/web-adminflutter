// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_web_dashboard/models/emegercies.dart';
import 'package:flutter_web_dashboard/models/users.dart';
import 'package:flutter_web_dashboard/pages/Emergencies/emergencies.dart';
import 'package:flutter_web_dashboard/pages/overview/widgets/info_card.dart';
import 'package:flutter_web_dashboard/pages/users/users.dart';
import 'package:flutter_web_dashboard/pages/users/widgets/users_table.dart';

class OverviewCardsMediumScreen extends StatelessWidget {
  List<Emergencies> emergencies;
  List<Users> users;
  OverviewCardsMediumScreen({this.emergencies, this.users});

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            InfoCard(
              title: "AppUsers",
              value: users
                  .where((element) => element.userType != "Deleted")
                  .toList()
                  .length
                  .toString(),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UsersPage(),)
                );
              },
              topColor: Colors.orange,
            ),
            SizedBox(
              width: _width / 64,
            ),
            InfoCard(
              title: "Emergency Reports",
              value: emergencies.length.toString(),
              topColor: Colors.lightGreen,
              onTap: () {Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EmergenciesPage(),)
              );},
            ),
          ],
        ),
        SizedBox(
          height: _width / 64,
        ),
        Row(
          children: [
            InfoCard(
              title: "Closed Emergencies",
              value: emergencies
                  .where((element) => element.ReportStatus == "Closed")
                  .toList()
                  .length
                  .toString(),
              topColor: Colors.redAccent,
              onTap: () {},
            ),
            SizedBox(
              width: _width / 64,
            ),
            InfoCard(
              title: "Pending Emergencies",
              value: emergencies
                  .where((element) => element.ReportStatus == "Pending")
                  .toList()
                  .length
                  .toString(),
              onTap: () {},
            ),
          ],
        ),
      ],
    );
  }
}
