import 'package:flutter/material.dart';
import 'package:flutter_web_dashboard/models/emegercies.dart';
import 'package:flutter_web_dashboard/models/users.dart';
import 'package:flutter_web_dashboard/pages/overview/widgets/info_card.dart';


class OverviewCardsLargeScreen extends StatelessWidget {
  List<Emergencies> emergencies;
  List<Users> users;
  OverviewCardsLargeScreen({this.emergencies, this.users});

  @override
  Widget build(BuildContext context) {
   double _width = MediaQuery.of(context).size.width;

    return  Row(
              children: [
                InfoCard(
                  title: "App Users",
                  value: users.length.toString(),
                  onTap: () {},
                  topColor: Colors.orange,
                ),
                SizedBox(
                  width: _width / 64,
                ),
                InfoCard(
                  title: "Emergency_Reports",
                  value: emergencies.length.toString(),
                  topColor: Colors.lightGreen,
                  onTap: () {},
                ),
                SizedBox(
                  width: _width / 64,
                ),
                InfoCard(
                  title: "ClosedEmergencyCase",
                  value: emergencies.where((element) => element.ReportStatus == "Closed").toList().length.toString(),

                  onTap: () {},
                ),
                SizedBox(
                  width: _width / 64,
                ),
                InfoCard(
                  title: "PendingCases",
                  value: emergencies.where((element) => element.ReportStatus == "Pending").toList().length.toString(),
                    onTap: () {},
                ),
              ],
            );
  }
}