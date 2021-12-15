import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_web_dashboard/constants/controllers.dart';
import 'package:flutter_web_dashboard/helpers/reponsiveness.dart';
import 'package:flutter_web_dashboard/models/dispatch.dart';
import 'package:flutter_web_dashboard/pages/dispatchTeam/widgets/dispatchTeamTable.dart';
import 'package:flutter_web_dashboard/services/FirestoreDB.dart';
import 'package:flutter_web_dashboard/widgets/custom_text.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class DispatchTeam extends StatefulWidget {
  DispatchTeam({Key key}): super(key: key);

  @override
  State<DispatchTeam> createState() => _DispatchTeamState();
}
class _DispatchTeamState extends State<DispatchTeam>{
  List<Dispatch> dispatchList = [];

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
              () => Row(
                children: [Container(
                  margin: EdgeInsets.only(
                    top: ResponsiveWidget.isSmallScreen(context) ? 56 : 6),
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
                stream: FirestoreDB().mDispatchstream,
                builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot> snapshot) {
                  dispatchList.clear();
                  if (snapshot.data != null && snapshot.hasData){
                    if (snapshot.data.docs.isNotEmpty) {
                      snapshot.data.docs.forEach((element){
                        Dispatch dispatch = Dispatch.fromMapObject(element.data());

                            dispatchList.add(dispatch);

                       });

                  }
                      return StreamBuilder<QuerySnapshot>(
                      stream: FirestoreDB().mDispatchstream,
                      builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                        dispatchList.clear();
                        if (snapshot.data != null && snapshot.hasData) {
                          if (snapshot.data.docs.isNotEmpty) {
                            snapshot.data.docs.forEach((element) {
                              Dispatch dispatch = Dispatch
                                  .fromMapObject(element.data());

                              if (dispatch.status != "Deleted") {
                                dispatchList.add(dispatch);
                              }
                            });
                          }


                          return ListView(
                            children: [
                              DispatchTable(
                                dispatch: dispatchList,
                              )
                            ],
                          );
                        } else
                          return Container();
                      });
                  } else
                    return Container();
                } )),],
      ),
    );
  }

}

