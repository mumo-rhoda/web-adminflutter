import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_web_dashboard/constants/style.dart';
import 'package:flutter_web_dashboard/models/users.dart';
import 'package:flutter_web_dashboard/services/FirestoreDB.dart';
import 'package:flutter_web_dashboard/widgets/custom_text.dart';

/// Example without datasource
class UsersTable extends StatelessWidget {

  List<Users> users;
  UsersTable({this.users});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
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
              rows:  users.map((user) {

                return DataRow(
                    cells: [
                      DataCell(CustomText(text: user.fullname)),
                      DataCell(CustomText(text: user.email)),
                      DataCell(CustomText(text: user.phonenumber)),
                      DataCell(CustomText(text: user.userType)),
                      DataCell(
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [

                              IconButton(
                                onPressed: ()async{


                                },
                                hoverColor: Colors.grey,
                                icon: Icon(Icons.edit),
                                color: Colors.blue,
                              ),
                              IconButton(
                                onPressed: ()async{


                                },
                                hoverColor: Colors.grey,
                                icon: Icon(Icons.delete),
                                color: Colors.red,
                              ),
                              IconButton(
                                onPressed: () async{


                                },
                                hoverColor: Colors.grey,
                                icon: Icon(Icons.check_circle),
                                color: Colors.green,
                              ),
                            ],

                          )),

                    ]);}).toList()),
        );
      }
    );
  }
}
