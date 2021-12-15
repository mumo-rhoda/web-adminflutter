// ignore_for_file: unused_import, must_be_immutable

import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_web_dashboard/constants/style.dart';
import 'package:flutter_web_dashboard/models/users.dart';
import 'package:flutter_web_dashboard/pages/users/widgets/updateUsers.dart';
import 'package:flutter_web_dashboard/services/FirestoreDB.dart';
import 'package:flutter_web_dashboard/widgets/alertDialog.dart';
import 'package:flutter_web_dashboard/widgets/custom_text.dart';

import 'addUsers.dart';

/// Example without datasource
class UsersTable extends StatelessWidget {
  List<Users> users;
  UsersTable({this.users});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
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
                label: Text("FullName"),
                size: ColumnSize.L,
              ),
              DataColumn(
                label: Text('Email'),
              ),
              DataColumn(
                label: Text('PhoneNumber'),
              ),
              DataColumn(
                label: Text('Type'),
              ),
              DataColumn(
                label: Text('Action'),
              ),
            ],
            rows: users.map((user) {
              return DataRow(cells: [
                DataCell(CustomText(text: user.fullname)),
                DataCell(CustomText(text: user.email)),
                DataCell(CustomText(text: user.phonenumber)),
                DataCell(CustomText(text: user.userType)),
                DataCell(Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () =>
                      {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddUsers(),
                          ),
                        )
                      },
                      hoverColor: Colors.grey,
                      icon: Icon(Icons.edit),
                      color: Colors.blue,
                    ),
                    IconButton(
                        onPressed: () async {
                          user.userType = "Deleted";
                          await FirestoreDB().updateUser(user);
                          callsAlertDialog( context);
                        },

                      hoverColor: Colors.grey,
                      icon: Icon(Icons.delete),
                      color: Colors.red,
                    ),
                    IconButton(
                      onPressed: () =>
                      {
                         Navigator.push(
                         context,
                          MaterialPageRoute(
                             builder: (context) => AddUsers(),
                            ),
                            )
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
                      description: "User Deleted successfully!", icon: 'person',)),
            ),

          );


        }
    );
  }
}
