import 'package:e_commerce/components/constants.dart';
import 'package:e_commerce/counters/cart_item_counter.dart';
import 'package:e_commerce/screens/cart.dart';
import 'package:e_commerce/widgets/myDrawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
          actions: [
            Stack(children: [
              IconButton(
                  icon: Icon(
                    Icons.shopping_cart,
                    color: white,
                  ),
                  onPressed: () {
                    Route route =
                        MaterialPageRoute(builder: (context) => CartPage());
                    Navigator.pushReplacement(context, route);
                  }),
              Positioned(
                child: Stack(
                  children: [
                    Icon(
                      Icons.brightness_1,
                      size: 17.0,
                      color: Colors.redAccent,
                    ),
                    Positioned(
                      top: 2.0,
                      bottom: 4.0,
                      left: 5.0,
                      child: Consumer<CartItemCounter>(
                          builder: (context, notifier, child) {
                        return Text(
                          notifier.count.toString() == null
                              ? '0'
                              : notifier.count.toString(),
                          style: TextStyle(
                              color: white,
                              fontSize: 12.0,
                              fontFamily: fontSemibold),
                        );
                      }),
                    ),
                  ],
                ),
              )
            ]),
          ],
        ),
        drawer: MyDrawer(),
      ),
    );
  }
}
