import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/config/config.dart';
import 'package:e_commerce/counters/cart_item_counter.dart';
import 'package:e_commerce/splash.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  ECommerceApp.firebaseAuth = FirebaseAuth.instance;
  ECommerceApp.sharedPreferences = await SharedPreferences.getInstance();
  ECommerceApp.firestore = FirebaseFirestore.instance;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CartItemCounter(),
      child: Consumer<CartItemCounter>(
        builder: (context, CartItemCounter counter, child) {
          return MaterialApp(
            title: 'E-Commerce',
            debugShowCheckedModeBanner: false,
            home: SplashScreen(),
            theme: ThemeData(primarySwatch: Colors.teal),
          );
        },
      ),
    );
  }
}
