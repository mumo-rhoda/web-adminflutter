// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class AlertDialogWidget extends StatelessWidget {
  String icon,
      title,
      description,
      primaryButtonText,
      secondaryButtonText,
      secondaryButtonText2;

  Function primaryAction;
  Function secondaryAction;
  Function secondaryAction2;

  BuildContext context;

  AlertDialogWidget(
      {@required this.context,
      @required this.icon,
      @required this.title,
      @required this.description,
      this.primaryButtonText,
      this.secondaryButtonText,
      this.secondaryButtonText2,
      this.secondaryAction,
      this.secondaryAction2,
      this.primaryAction});

  @override
  Widget build(BuildContext _context) {
    if (primaryButtonText == null) {
      primaryButtonText = "";
    }
    if (secondaryButtonText == null) {
      secondaryButtonText = "";
    }
    if (secondaryButtonText2 == null) {
      secondaryButtonText2 = "";
    }

    return Row(
      children: [
        Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 0,
          insetPadding: EdgeInsets.symmetric(horizontal: 16),
          backgroundColor: Colors.transparent,
          child: dialogContent(context),
        ),
      ],
    );
  }

  dialogContent(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 70, bottom: 16, left: 5, right: 5),
          margin: EdgeInsets.only(top: 16),
          decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0.0, 10.0))
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Colors.black),
              ),
              SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  description,
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    secondaryButtonText == null || secondaryButtonText == ""
                        ? SizedBox()
                        : Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(60),
                              color: Colors.yellow[700],
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(2),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(60),
                                  color: Colors.white,
                                ),
                                child: TextButton(
                                    onPressed: () {
                                      moveToPreviousScreen();
                                      secondaryAction();
                                    },
                                    child: Text(
                                      secondaryButtonText,
                                      style: TextStyle(
                                          color: Colors.yellow[700],
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14),
                                    )),
                              ),
                            ),
                          ),
                    Container(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          secondaryButtonText == null ||
                                  secondaryButtonText == ""
                              ? SizedBox()
                              : Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(60),
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(1.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(60),
                                        color: Colors.white,
                                      ),
                                      child: TextButton(
                                          onPressed: () {
                                            moveToPreviousScreen();
                                            secondaryAction2();
                                          },
                                          child: Text(
                                            secondaryButtonText2,
                                            style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )),
                                    ),
                                  ),
                                ),
                          SizedBox(
                            width: secondaryButtonText == null ||
                                    secondaryButtonText == ""
                                ? 20
                                : 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(60),
                              color: Theme.of(context).primaryColor,
                            ),
                            child: TextButton(
                                onPressed: () {
                                  moveToPreviousScreen();
                                  primaryAction();
                                },
                                child: FittedBox(
                                  child: Text(
                                    primaryButtonText,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  void moveToPreviousScreen() {
    Navigator.pop(context, true);
  }
}
