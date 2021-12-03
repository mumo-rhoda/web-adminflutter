import 'package:flutter/material.dart';
import 'info_card_small.dart';


class OverviewCardsSmallScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
   double _width = MediaQuery.of(context).size.width;

    return  Container(
      height: 400,
      child: Column(
        children: [
          InfoCardSmall(
                        title: "AppUsers",
                        value: "7",
                        onTap: () {},
                        isActive: true,
                      ),
                      SizedBox(
                        height: _width / 64,
                      ),
                      InfoCardSmall(
                        title: "EmergencyReports",
                        value: "17",
                        onTap: () {},
                      ),
                     SizedBox(
                        height: _width / 64,
                      ),
                          InfoCardSmall(
                        title: "Closed Emergencies",
                        value: "3",
                        onTap: () {},
                      ),
                      SizedBox(
                        height: _width / 64,
                      ),
                      InfoCardSmall(
                        title: "PendingEmergencies",
                        value: "32",
                        onTap: () {},
                      ),
                  
        ],
      ),
    );
  }
}