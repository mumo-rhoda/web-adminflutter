import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_dashboard/constants/style.dart';
import 'package:flutter_web_dashboard/models/dispatch.dart';
import 'package:flutter_web_dashboard/pages/Emergencies/widgets/emergencies_table.dart';
import 'package:flutter_web_dashboard/pages/dispatchTeam/widgets/updateDispatchTeam.dart';
import 'package:flutter_web_dashboard/services/FirestoreDB.dart';
import 'package:flutter_web_dashboard/widgets/alertDialog.dart';
import 'package:flutter_web_dashboard/widgets/custom_text.dart';

import 'addDispatchTeam.dart';

class DispatchTable extends StatelessWidget{
  List<Dispatch> dispatch;
  DispatchTable({this.dispatch});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context){
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
              DataColumn2(
                  label: Text("Name"),
              size: ColumnSize.L,
              ),
              DataColumn(
                label: Text('Type'),
              ),
              DataColumn(
                label: Text('Location'),
              ),
              DataColumn(
                label: Text('Contacts'),
              ),
              DataColumn(
                label: Text('Status'),
              ),
              DataColumn(
                label: Text('Actions'),
              ),
            ],
            rows: dispatch.map((dispatch){
              return DataRow(cells: [
                DataCell(CustomText(text: dispatch.Name)),
                DataCell(CustomText(text: dispatch.Type)),
                DataCell(CustomText(text: dispatch.Location)),
                DataCell(CustomText(text: dispatch.Contact)),
                DataCell(CustomText(text: dispatch.status)),
              DataCell(Row(
                   mainAxisSize: MainAxisSize.min,
                    children: [
                       IconButton(onPressed: ()  {
                         Navigator.push(
                             context,
                             MaterialPageRoute(
                               builder: (context) => AddDispatchTeamPage(),
                             )
                         );
                       },
                              hoverColor: Colors.grey,
                            icon: Icon(Icons.edit),
                               color: Colors.blue,
                                 ),
                         IconButton(
                           onPressed: () async {


                              dispatch.status = "Deleted";
                              await FirestoreDB().updateDispatchTeam(dispatch);
                              callsAlertDialog( context);
              },
                            hoverColor: Colors.grey,
                              icon: Icon(Icons.delete),
                             color: Colors.red,
                         ),
                   IconButton(
                      onPressed: ()  {
                             Navigator.push(
                                     context,
                                      MaterialPageRoute(
                        builder: (context) => AddDispatchTeamPage(),
                                      )
                             );
                             },
                            hoverColor: Colors.grey,
                           icon: Icon(Icons.add_task),
                            color: Colors.green,
                    ),
            ],
      )),
      ]);
            }).toList()),
      );
    });
  }

  void callsAlertDialog(BuildContext context) {

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
                        description: "Team Deleted successfully!", icon: 'Alert',)),
              ),

            );


          }
      );


    }
  }
