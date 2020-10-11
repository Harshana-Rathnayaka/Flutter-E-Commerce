import 'package:e_commerce/components/constants.dart';
import 'package:flutter/material.dart';

class LoadingDialog extends StatelessWidget {
  final String message;
  const LoadingDialog({
    Key key,
    this.message,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      key: key,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularProgressIndicator(),
          SizedBox(
            height: 10.0,
          ),
          Text(
            message,
            style: TextStyle(fontFamily: fontRegular),
          )
        ],
      ),
      title: Text(
        'Processing..',
        style: TextStyle(fontFamily: fontBold),
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
    );
  }
}
