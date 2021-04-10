import 'dart:ui';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'home.dart';
import 'login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs=await SharedPreferences.getInstance();
  var phonenumber=prefs.getString('phonenumber') ;
  await Firebase.initializeApp();
  runApp(MaterialApp(home: phonenumber==null ? Loginpage(title: 'Farm+'):Home(phonenumber),theme:  new ThemeData(scaffoldBackgroundColor: const Color(0xFF33691E)),
    debugShowCheckedModeBanner: false,),);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Farm+',

    );
  }
}
