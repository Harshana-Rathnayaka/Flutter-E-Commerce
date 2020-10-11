import 'package:e_commerce/config/config.dart';
import 'package:flutter/cupertino.dart';

class CartItemCounter extends ChangeNotifier {
  int _counter = ECommerceApp.sharedPreferences
          .getStringList(ECommerceApp.userCartList)
          .length -
      1;
  int get count => _counter;
}
