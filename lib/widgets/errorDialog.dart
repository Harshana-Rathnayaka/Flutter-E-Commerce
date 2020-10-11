import 'package:e_commerce/components/constants.dart';
import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  final String message;
  const ErrorDialog({
    Key key,
    this.message,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      key: key,
      content: Text(
        message,
        style: TextStyle(fontFamily: fontRegular),
      ),
      actions: [
        SizedBox(
          width: 150,
          child: RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            onPressed: () {
              Navigator.pop(context);
            },
            color: Colors.redAccent,
            child: Center(
              child: Text('OK'),
            ),
          ),
        ),
      ],
      title: Text(
        'Oops!',
        style: TextStyle(fontFamily: fontBold),
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
    );
  }
}
