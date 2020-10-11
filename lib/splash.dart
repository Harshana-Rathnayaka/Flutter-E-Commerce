import 'dart:async';

import 'package:e_commerce/components/constants.dart';
import 'package:e_commerce/config/config.dart';
import 'package:e_commerce/screens/authentication/authentication.dart';
import 'package:e_commerce/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    displaySplash();
  }

  displaySplash() {
    Timer(Duration(seconds: 2), () async {
      if (ECommerceApp.firebaseAuth.currentUser != null) {
        Route route = MaterialPageRoute(builder: (_) => HomePage());
        Navigator.pushReplacement(context, route);
      } else {
        Route route = MaterialPageRoute(builder: (_) => Authentication());
        Navigator.pushReplacement(context, route);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: colorBackgroundDefault,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: SvgPicture.asset(welcomeImage),
          ),
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(white),
          ),
          SizedBox(
            height: 10.0,
          ),
        ],
      ),
    );
  }
}
