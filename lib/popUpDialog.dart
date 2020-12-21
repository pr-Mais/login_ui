import 'package:flutter/material.dart';

Future popDialog(
    {String title,
    BuildContext context,
    String content,
    Function onPress}) async {
  // flutter defined function
  await showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      // return object of type Dialog
      return AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        title: Center(
            child: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20,
            color: Colors.black,
            fontFamily: 'Montserrat',
          ),
        )),
        content: Text(content),
      );
    },
  );
}
