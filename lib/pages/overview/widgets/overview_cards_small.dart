import 'package:flutter/material.dart';
import 'package:flutter_web_dashboard/models/emegercies.dart';
import 'package:flutter_web_dashboard/models/users.dart';
import 'info_card_small.dart';


class OverviewCardsSmallScreen extends StatelessWidget {
  List<Emergencies> emergencies;
  List<Users> users;
  OverviewCardsSmallScreen({this.emergencies, this.users});

  @override
  Widget build(BuildContext context) {
   double _width = MediaQuery.of(context).size.width;

    return  Container(
      height: 400,
      child: Column(
        children: [
          InfoCardSmall(
                        title: "AppUsers",
                        value: users.length.toString(),
                        onTap: () {},
                        isActive: true,
                      ),
                      SizedBox(
                        height: _width / 64,
                      ),
                      InfoCardSmall(
                        title: "EmergencyReports",
                        value: emergencies.length.toString(),
                        onTap: () {},
                      ),
                     SizedBox(
                        height: _width / 64,
                      ),
                          InfoCardSmall(
                        title: "Closed Emergencies",
                        value: emergencies.where((element) => element.ReportStatus == "Closed").toList().length.toString(),
                           onTap: () {},
                      ),
                      SizedBox(
                        height: _width / 64,
                      ),
                      InfoCardSmall(
                        title: "PendingEmergencies",
                        value: emergencies.where((element) => element.ReportStatus == "Pending").toList().length.toString(),

                        onTap: () {},
                      ),
                  
        ],
      ),
    );
  }
}