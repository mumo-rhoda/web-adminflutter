import 'package:flutter/material.dart';



  Widget dropdownButtonFormField({
    @required List<String> listItems,
    @required String currentSelection,
    @required String defaultSelection,
    @required Function onChangedSelectionFunction}){





    return Container(

      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(60)),
        color: Colors.red
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Sort By",
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.white
              ),
            ),
          ),
          Container(


            height: 50,
            width: 220,
            color: Colors.red[400],
            child: DropdownButtonFormField(

              value: currentSelection ?? '$defaultSelection',
              decoration:  InputDecoration(

                hintStyle: TextStyle(
                    fontSize: 15
                ),
                labelStyle: TextStyle(
                    fontSize: 15
                ),
                prefixIcon: Icon(
                  Icons.filter_list,
                  color: Colors.white,
                  size: 30,
                ),

              ),
              items: listItems.map((item){
                return DropdownMenuItem(

                  value: item,
                  child: Text(
                    '$item',
                    style:  TextStyle(
                        fontSize: 15,
                        color: Colors.white
                    ),
                  ),
                );
              },

              ).toList(),
              dropdownColor: Colors.red[500],

              onChanged: (val){
                onChangedSelectionFunction(val);

              },
            ),
          ),
        ],
      ),
    );
  }


