import 'package:e_commerce/components/constants.dart';
import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: colorBackgroundDefault,
        appBar: AppBar(
          title: Text(
            'ShopDreeko',
            style:
                TextStyle(fontSize: 25.0, fontFamily: fontBold, color: white),
          ),
          centerTitle: true,
        ),
      ),
    );
  }
}
