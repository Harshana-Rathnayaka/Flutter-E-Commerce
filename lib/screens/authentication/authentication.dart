import 'package:e_commerce/components/constants.dart';
import 'package:e_commerce/screens/authentication/login.dart';
import 'package:e_commerce/screens/authentication/registration.dart';
import 'package:flutter/material.dart';

class Authentication extends StatefulWidget {
  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'ShopDreeko',
            style: TextStyle(fontSize: 25.0, fontFamily: fontBold),
          ),
          centerTitle: true,
          bottom: TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.lock),
                text: 'Login',
              ),
              Tab(
                icon: Icon(Icons.person_add),
                text: 'Register',
              )
            ],
          ),
        ),
        body: Container(
          child: TabBarView(children: [
            Login(),
            Registration(),
          ]),
        ),
      ),
    );
  }
}
