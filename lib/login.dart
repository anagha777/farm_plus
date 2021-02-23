import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';

import 'home.dart';
import 'main.dart';
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



class Loginpage extends StatefulWidget {
  Loginpage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _Loginpage createState() => _Loginpage();
}
class _Loginpage extends  State<Loginpage> {
  String _code;
  String signature = "{{ app signature }}";

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    SmsAutoFill().unregisterListener();
    super.dispose();
  }
  // _Loginpage({Key key, this.title}) : super(key: key);
  final myController = TextEditingController();
  TextStyle style =
  TextStyle(fontFamily: 'Montserrat', fontSize: 20.0, color: Colors.white);
  // final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withAlpha(150),
      child: Scaffold(
          backgroundColor: Colors.green.withAlpha(10).withOpacity(.1),
          body: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 100),
              child: Container(
                  child: Column(children: <Widget>[
                    SizedBox(
                      height: 80,
                    ),
                    Center(
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(children: <TextSpan>[
                          TextSpan(
                              text: "Farm ",
                              style: TextStyle(
                                  fontSize: 50,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                          TextSpan(
                              text: "+",
                              style: TextStyle(
                                  fontSize: 40,
                                  color: Colors.red[900],
                                  fontWeight: FontWeight.bold)),
                        ]),
                      ),
                    ),
                    SizedBox(height: 50,),
                    Container(
                      // color: Colors.transparent,
                      margin: EdgeInsets.all(30.0),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          // mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(color:Colors.white12,height:45,
                                  child: PhoneFieldHint(controller: myController,)),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Container(color: Colors.white12,height: 45,
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: PinFieldAutoFill(
                                    decoration: UnderlineDecoration(
                                      textStyle: TextStyle(fontSize: 20, color: Colors.black),
                                      colorBuilder: FixedColorBuilder(Colors.black.withOpacity(0.3)),
                                    ),
                                    currentCode: _code,
                                    onCodeSubmitted: (code) {},
                                  ),
                                ),
                              ),
                            ),

                          ],
                        ),


                      ),
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: <Widget>[
                            Center(
                                child: Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => MyHomePage()),
                                        );
                                      },
                                      child: Text(
                                        ''
                                            'Login',
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.white70,
                                            fontStyle: FontStyle.italic),
                                      ),
                                    ),
                                  ],
                                )),
                          ],
                        ),
                      ),
                    ),
                  ])))),
    );
  }
}
