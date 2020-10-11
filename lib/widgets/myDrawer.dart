import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/components/constants.dart';
import 'package:e_commerce/config/config.dart';
import 'package:e_commerce/screens/authentication/authentication.dart';
import 'package:e_commerce/screens/cart.dart';
import 'package:e_commerce/screens/home.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 25.0, bottom: 10.0),
            child: Column(
              children: [
                Material(
                  elevation: 10.0,
                  borderRadius: BorderRadius.circular(80),
                  child: CircleAvatar(
                    radius: 70,
                    child: CachedNetworkImage(
                      imageUrl: ECommerceApp.sharedPreferences
                          .getString(ECommerceApp.userAvatarUrl),
                      imageBuilder: (context, imageProvider) => Container(
                        width: 80.0,
                        height: 80.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: imageProvider, fit: BoxFit.cover),
                        ),
                      ),
                      width: 140,
                      height: 140,
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  ECommerceApp.sharedPreferences
                      .getString(ECommerceApp.userName),
                  style: TextStyle(fontFamily: fontSemibold, fontSize: 18.0),
                ),
                Text(
                  ECommerceApp.sharedPreferences
                      .getString(ECommerceApp.userEmail),
                  style: TextStyle(fontFamily: fontSemibold, fontSize: 12.0),
                )
              ],
            ),
          ),
          SizedBox(height: 12.0),
          Container(
            padding: const EdgeInsets.only(top: 1.0),
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.home),
                  title:
                      Text('Home', style: TextStyle(fontFamily: fontRegular)),
                  onTap: () {
                    Route route =
                        MaterialPageRoute(builder: (context) => HomePage());
                    Navigator.pushReplacement(context, route);
                  },
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.shopping_basket),
                  title: Text('My Orders',
                      style: TextStyle(fontFamily: fontRegular)),
                  onTap: () {
                    Route route =
                        MaterialPageRoute(builder: (context) => HomePage());
                    Navigator.pushReplacement(context, route);
                  },
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.shopping_cart),
                  title: Text('My Cart',
                      style: TextStyle(fontFamily: fontRegular)),
                  onTap: () {
                    Route route =
                        MaterialPageRoute(builder: (context) => CartPage());
                    Navigator.pushReplacement(context, route);
                  },
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.search),
                  title:
                      Text('Search', style: TextStyle(fontFamily: fontRegular)),
                  onTap: () {
                    Route route =
                        MaterialPageRoute(builder: (context) => HomePage());
                    Navigator.pushReplacement(context, route);
                  },
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.add_location),
                  title: Text('Add New Address',
                      style: TextStyle(fontFamily: fontRegular)),
                  onTap: () {
                    Route route =
                        MaterialPageRoute(builder: (context) => HomePage());
                    Navigator.pushReplacement(context, route);
                  },
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.exit_to_app),
                  title:
                      Text('Logout', style: TextStyle(fontFamily: fontRegular)),
                  onTap: () {
                    ECommerceApp.firebaseAuth.signOut().then((value) {
                      Route route = MaterialPageRoute(
                          builder: (context) => Authentication());
                      Navigator.pushReplacement(context, route);
                    });
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
