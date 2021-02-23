import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';
import 'package:load/load.dart';

import 'login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Farm+',
      theme: new ThemeData(scaffoldBackgroundColor: const Color(0xFF33691E)),
      debugShowCheckedModeBanner: false,
      home: Loginpage(title: 'Farm+'),
    );
  }
}
