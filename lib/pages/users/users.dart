// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_dashboard/constants/controllers.dart';
import 'package:flutter_web_dashboard/helpers/reponsiveness.dart';
import 'package:flutter_web_dashboard/models/users.dart';
import 'package:flutter_web_dashboard/pages/users/widgets/users_table.dart';
import 'package:flutter_web_dashboard/services/FirestoreDB.dart';
import 'package:flutter_web_dashboard/widgets/custom_text.dart';
import 'package:get/get.dart';

class UsersPage extends StatefulWidget {
  UsersPage({Key key}) : super(key: key);

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage>{

  List<Users> usersList = [];

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Obx(
                () =>
                Row(
                  children: [
                    Container(
                        margin: EdgeInsets.only(
                            top: ResponsiveWidget.isSmallScreen(context)
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
              child: StreamBuilder<QuerySnapshot>(
                  stream: FirestoreDB().mUserstream,
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    usersList.clear();
                    if (snapshot.data != null && snapshot.hasData) {
                      if (snapshot.data.docs.isNotEmpty) {
                        snapshot.data.docs.forEach((element) {
                          Users user = Users.fromMapObject(element.data());

                          usersList.add(user);
                        });
                      }
                      return StreamBuilder<QuerySnapshot>(
                          stream: FirestoreDB().mUserstream,
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            usersList.clear();
                            if (snapshot.data != null && snapshot.hasData) {
                              if (snapshot.data.docs.isNotEmpty) {
                                snapshot.data.docs.forEach((element) {
                                  Users user = Users
                                      .fromMapObject(element.data());

                                  if (user.userType != "Deleted") {
                                    usersList.add(user);
                                  }
                                });
                              }


                              return ListView(
                                children: [
                                  UsersTable(
                                    users: usersList,
                                  )
                                ],
                              );
                            } else
                              return Container();
                          });
                    } else
                      return Container();
                  })),
        ],
      ),
    );
  }





}
