import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/components/constants.dart';
import 'package:e_commerce/config/config.dart';
import 'package:e_commerce/screens/home.dart';
import 'package:e_commerce/widgets/errorDialog.dart';
import 'package:e_commerce/widgets/loadingDialog.dart';
import 'package:e_commerce/widgets/myTextField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailTextEditingController =
      TextEditingController();
  final TextEditingController _passwordTextEditingController =
      TextEditingController();

  double width;
  double height;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Container(
        
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              child: SvgPicture.asset(loginImage),
              height: 240.0,
              width: 240.0,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Login to your account.',
                style: TextStyle(color: white, fontFamily: fontRegular),
              ),
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: 10.0,
                  ),
                  CustomTextField(
                    controller: _emailTextEditingController,
                    hint: 'Email',
                    isEmail: true,
                    icon: Icon(
                      Icons.email,
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  CustomTextField(
                    controller: _passwordTextEditingController,
                    hint: 'Password',
                    isPassword: true,
                    icon: Icon(
                      Icons.lock,
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                ],
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 50.0,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0))),
                onPressed: () {
                  _emailTextEditingController.text.isNotEmpty &&
                          _passwordTextEditingController.text.isNotEmpty
                      ? _signIn()
                      : showDialog(
                          context: context,
                          builder: (context) {
                            return ErrorDialog(
                                message:
                                    'Please enter both email and password.');
                          });
                },
                color: Colors.teal,
                textColor: white,
                child: Text(
                  'Sign in',
                  style: TextStyle(fontFamily: fontSemibold, fontSize: 16.0),
                ),
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Container(
              height: 4.0,
              width: width * 0.8,
              color: Colors.teal,
            ),
            SizedBox(
              height: 10.0,
            ),
          ],
        ),
      ),
    );
  }

  void _signIn() async {
    auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;
    auth.User firebaseUser;
    showDialog(
        context: context,
        builder: (context) {
          return LoadingDialog(message: 'Signing in, please wait..');
        });
    await _auth
        .signInWithEmailAndPassword(
            email: _emailTextEditingController.text.trim(),
            password: _passwordTextEditingController.text.trim())
        .then((result) {
      firebaseUser = result.user;
    }).catchError((error) {
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (context) {
            return ErrorDialog(message: error.message.toString());
          });
    });
    if (firebaseUser != null) {
      readData(firebaseUser).then((value) {
        Navigator.pop(context);
        Route route = MaterialPageRoute(builder: (context) => HomePage());
        Navigator.pushReplacement(context, route);
      });
    }
  }

  Future readData(auth.User user) async {
    FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get()
        .then((dataSnapshot) async {
      print(dataSnapshot);
      print('============================');
      print(dataSnapshot['uid']);
      print(dataSnapshot['email']);
      print(dataSnapshot['name']);
      print(dataSnapshot['imageUrl']);

      await ECommerceApp.sharedPreferences
          .setString('uid', dataSnapshot['uid']);
      await ECommerceApp.sharedPreferences
          .setString(ECommerceApp.userEmail, dataSnapshot['email']);
      await ECommerceApp.sharedPreferences
          .setString(ECommerceApp.userName, dataSnapshot['name']);
      await ECommerceApp.sharedPreferences
          .setString(ECommerceApp.userAvatarUrl, dataSnapshot['imageUrl']);

      List<String> cartList =
          dataSnapshot['userCart'].cast<String>();
      await ECommerceApp.sharedPreferences
          .setStringList(ECommerceApp.userCartList, cartList);
    });
  }
}
