import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/components/constants.dart';
import 'package:e_commerce/config/config.dart';
import 'package:e_commerce/screens/home.dart';
import 'package:e_commerce/widgets/errorDialog.dart';
import 'package:e_commerce/widgets/loadingDialog.dart';
import 'package:e_commerce/widgets/myTextField.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Registration extends StatefulWidget {
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final TextEditingController _nameTextEditingController =
      TextEditingController();
  final TextEditingController _emailTextEditingController =
      TextEditingController();
  final TextEditingController _passwordTextEditingController =
      TextEditingController();
  final TextEditingController _cPasswordTextEditingController =
      TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String userImageUrl = '';
  File _imageFile;
  double width;
  double height;

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
            SizedBox(height: 10.0),
            GestureDetector(
              onTap: () {
                _selectImage();
              },
              child: CircleAvatar(
                radius: width / 5,
                backgroundColor: Colors.blueGrey,
                backgroundImage:
                    _imageFile == null ? null : FileImage(_imageFile),
                child: _imageFile == null
                    ? Icon(
                        Icons.add_photo_alternate,
                        size: width / 8,
                      )
                    : null,
              ),
            ),
            SizedBox(height: 8.0),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: 10.0,
                  ),
                  CustomTextField(
                    controller: _nameTextEditingController,
                    hint: 'Name',
                    icon: Icon(
                      Icons.person,
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
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
                  CustomTextField(
                    controller: _cPasswordTextEditingController,
                    hint: 'Confirm Password',
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
                  _signUp();
                },
                color: Colors.teal,
                textColor: white,
                child: Text(
                  'Sign up',
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

  Future<void> _selectImage() async {
    _imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
  }

  Future<void> _signUp() async {
    if (_imageFile == null) {
      displayDialog('Please select an image to proceed.');
    } else if (_nameTextEditingController.text.isNotEmpty &&
        _emailTextEditingController.text.isNotEmpty &&
        _passwordTextEditingController.text.isNotEmpty &&
        _cPasswordTextEditingController.text.isNotEmpty) {
      if (_passwordTextEditingController.text ==
          _cPasswordTextEditingController.text) {
        uploadImage();
      } else {
        displayDialog(
            'The passwords you entered do not match. Please check again!');
      }
    } else {
      displayDialog('Please fill in the blanks.');
    }
  }

  displayDialog(String msg) {
    showDialog(
        context: context,
        builder: (context) {
          return ErrorDialog(
            message: msg,
          );
        });
  }

  Future<void> uploadImage() async {
    showDialog(
        context: context,
        builder: (context) {
          return LoadingDialog(
            message: 'Signing up, please wait..',
          );
        });

    String imageFileName = DateTime.now().millisecondsSinceEpoch.toString();

    StorageReference storageReference =
        FirebaseStorage.instance.ref().child(imageFileName);

    StorageUploadTask storageUploadTask = storageReference.putFile(_imageFile);

    StorageTaskSnapshot storageTaskSnapshot =
        await storageUploadTask.onComplete;

    await storageTaskSnapshot.ref.getDownloadURL().then((url) {
      userImageUrl = url;
    });

    _registerNewUser();
  }

  void _registerNewUser() async {
    auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;
    auth.User firebaseUser;

    await _auth
        .createUserWithEmailAndPassword(
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
      saveUserIntoFirestore(firebaseUser).then((value) {
        Navigator.pop(context);
        Route route = MaterialPageRoute(builder: (context) => HomePage());
        Navigator.pushReplacement(context, route);
      });
    }
  }

  Future saveUserIntoFirestore(auth.User user) async {
    FirebaseFirestore.instance.collection('users').doc(user.uid).set({
      'uid': user.uid,
      'email': user.email,
      'name': _nameTextEditingController.text.trim(),
      'imageUrl': userImageUrl,
      ECommerceApp.userCartList: ['garbageValue']
    });

    await ECommerceApp.sharedPreferences.setString('uid', user.uid);
    await ECommerceApp.sharedPreferences
        .setString(ECommerceApp.userEmail, user.email);
    await ECommerceApp.sharedPreferences.setString(
        ECommerceApp.userName, _nameTextEditingController.text.trim());
    await ECommerceApp.sharedPreferences
        .setString(ECommerceApp.userAvatarUrl, userImageUrl);
    await ECommerceApp.sharedPreferences
        .setStringList(ECommerceApp.userCartList, ['garbageValue']);
  }
}
