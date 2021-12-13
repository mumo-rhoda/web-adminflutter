// ignore_for_file: must_be_immutable

import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_dashboard/bloc/SortingBloc.dart';
import 'package:flutter_web_dashboard/constants/style.dart';
import 'package:flutter_web_dashboard/models/emegercies.dart';
import 'package:flutter_web_dashboard/models/users.dart';
import 'package:flutter_web_dashboard/pages/Emergencies/widgets/updateEmergencies.dart';
import 'package:flutter_web_dashboard/pages/overview/widgets/mapsWidget.dart';
import 'package:flutter_web_dashboard/services/FirestoreDB.dart';
import 'package:flutter_web_dashboard/widgets/alertDialog.dart';
import 'package:flutter_web_dashboard/widgets/custom_text.dart';
import 'package:intl/intl.dart';

/// Example without datasource
class Emergenciestable extends StatelessWidget {
  List<Emergencies> emergencies;
  List<Users> users;

  Emergenciestable({this.emergencies, this.users});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SortingBloc, String>(

        builder: (context, sortingValue) {

          List<Emergencies> uEmergencies = [];
          emergencies.forEach((element) {

            if(checkSortingCondition(element, sortingValue)){
              uEmergencies.add(element);
            }

          });



          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: active.withOpacity(.4), width: .5),
              boxShadow: [
                BoxShadow(
                    offset: Offset(0, 6),
                    color: lightGrey.withOpacity(.1),
                    blurRadius: 12)
              ],
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.all(16),
            margin: EdgeInsets.only(bottom: 30),
            child: DataTable2(
                columnSpacing: 12,
                horizontalMargin: 12,
                minWidth: 600,
                columns: [
                  DataColumn(
                    label: Text('Date'),
                  ),
                  DataColumn2(
                    label: Text("Victim Name"),
                    size: ColumnSize.L,
                  ),
                  DataColumn(
                    label: Text('Type'),
                  ),
                  DataColumn(
                    label: Text('Description'),
                  ),
                  DataColumn(
                    label: Text('Action'),
                  ),
                ],
                rows: uEmergencies.map((emergency) {
                  Users victim = users
                      .where((element) => element.uid == emergency.VictimID)
                      .first;

                  return DataRow(cells: [
                    DataCell(CustomText(text: getDateTime(emergency.dateTime))),
                    DataCell(
                        CustomText(text: "${victim.username} ${victim.fullname}")),
                    DataCell(CustomText(text: emergency.ReportType)),
                    DataCell(CustomText(text: emergency.Description)),
                    DataCell(Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        InkWell(
                          onTap: () {
                            showEmergencyLocation(emergency, victim, context);
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CustomText(text: "Location"),
                              Icon(
                                Icons.add_location ,
                                color: Colors.blue,
                              )
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () async {

                            emergency.ReportStatus = "Deleted";
                            await FirestoreDB().updateEmergency(emergency);
                            callAlertDialog(context);
                          },
                          hoverColor: Colors.grey,
                          icon: Icon(Icons.delete),
                          color: Colors.red,
                        ),
                        IconButton(
                          onPressed: () async {
                            //set emergency's status to closed
                            //emergency.ReportStatus = "Closed";
                            //await FirestoreDB().updateEmergency(emergency);

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => UpdateEmergencies(),
                                  )
                              );
                            },
                            //callAlertDialog();

                          hoverColor: Colors.grey,
                          icon: Icon(Icons.check_circle),
                          color: Colors.green,
                        ),
                      ],
                    )),
                  ]);
                }).toList()));
      }
    );
  }

  void showEmergencyLocation(
      Emergencies emergency, Users user, BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 0,
            insetPadding: EdgeInsets.symmetric(horizontal: 16),
            backgroundColor: Colors.transparent,
            child: MapsWidget(emergency: emergency, user: user),
          );
        });
  }
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

String getDateTime(DateTime dateTime){
  return DateFormat('dd-MM-yyyy HH:mm:ss').format(dateTime);
}


void callAlertDialog(BuildContext context, ) {




  showDialog(
      context: context,
      builder: (context){

        return Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 500.0),
            child: Container(
              width: 80,
              child: AlertDialogWidget(
                  context: context,
                  title: "Success",
                  primaryButtonText: "OK",
                  description: "Emergency Deleted successfully!")),
            ),

        );


      }
  );


}