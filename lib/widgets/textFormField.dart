import 'package:flutter/material.dart';

Widget textField(BuildContext context,{

  @required TextEditingController controller,
  @required Function onChangedFunction,
  @required Function onTapFunction,
  @required String hintText,
  @required String labelText,
  @required String errorMessage}){

  return Container(
    decoration: BoxDecoration(
      color: Colors.red[200],
        borderRadius: BorderRadius.all(
            Radius.circular(100)
        )

    ),
    alignment: Alignment.centerLeft,
    height: 40,
    child: TextFormField(

      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              width: 2,
              color: Theme.of(context).primaryColor
          ),
          borderRadius: BorderRadius.all(
              Radius.circular(100)
          ),

        ),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Colors.white,
                width: 2
            ),
            borderRadius: BorderRadius.all(
                Radius.circular(100)
            )
        ),
      ),

      validator: null,
      controller: controller,
      onChanged: (val){

        onChangedFunction();
      },
      onTap: (){
        onTapFunction() ;
      },
    ),
  );
}
