import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:shared_preferences/shared_preferences.dart';

class ECommerceApp {
  static SharedPreferences sharedPreferences;
  static auth.User firebaseUser;
  static auth.FirebaseAuth firebaseAuth;
  static FirebaseFirestore firestore;

  static String userCartList = 'userCart';

  static final String userName = 'name';
  static final String userEmail = 'email';
  static final String userPhotoUrl = 'photoUrl';
  static final String userUid = 'uid';
  static final String userAvatarUrl = 'url';
}
