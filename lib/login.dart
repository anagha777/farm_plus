import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';
import 'Database/firebase.dart';
import 'home.dart';
import 'package:load/load.dart';

class Loginpage extends StatefulWidget {
  Loginpage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _Loginpage createState() => _Loginpage();
}

class _Loginpage extends State<Loginpage> {
  final SmsAutoFill autoFill = SmsAutoFill();
  final phoneController = TextEditingController();
  final otpController = TextEditingController();
  String phoneNumber, verificationId;
  String _code="";
  bool _loading = false;

  @override
  void initState() {
    super.initState();
  _getNumber();
  }

  _getNumber() async {
    var _autoNumber = await autoFill.hint;
    if (_autoNumber != null) {
      print("auto fetch number - $_autoNumber");
      phoneController.text = _autoNumber;
      if (phoneController.text.isNotEmpty)
       { await SmsAutoFill().listenForCode;
        verifyPhoneNumber(phoneController.text.trim(), isSignup: false);}
      setState(() {
        _loading = true;
        new Future.delayed(new Duration(seconds: 3), _login);
      });
    }
  }
  Future _login() {
    setState((){
      _loading = false;
    });
  }

  @override
  void dispose() {
    SmsAutoFill().unregisterListener();
    super.dispose();
  }


  TextStyle style = TextStyle(fontSize: 20.0, color: Colors.white);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withAlpha(150),
      child: Scaffold(
          backgroundColor: Colors.green.withAlpha(10).withOpacity(.1),
          body: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 100),
              child: _loading ? bodyProgress :new Container(
                  alignment: Alignment.center,
                  child: Column(children: <Widget>[
                    SizedBox(
                      height: 100,
                    ),
                    Center(
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(children: <TextSpan>[
                          TextSpan(
                              text: "Farm",
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
                    SizedBox(
                      height: 70,
                    ),
                    Container(
                      color: Colors.transparent,
                      margin: EdgeInsets.all(10.0),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Row(children: <Widget>[
                              Container(
                                margin:
                                EdgeInsets.only(right: 5, left: 10, top: 5),
                                width: 35,
                                height: 80,
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Image.asset('assets/images/key1.png',height: 80,),
                                width: 25,
                                height: 160,
                              ),
                              Container(
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      height: 45,
                                      width: 190,
                                      child: Card( color: Colors.green[100].withOpacity(.2),
                                        child: TextField(textAlign: TextAlign.center,
                                          style: TextStyle(color: Colors.white60,),
                                          obscureText: false,
                                          controller: phoneController,
                                          onSubmitted: (number)async {
                                            await SmsAutoFill().listenForCode;
                                            if(phoneController.text.isNotEmpty)
                                              verifyPhoneNumber(phoneController.text.trim(), isSignup: false);
                                            setState(()  {
                                              _loading = true;
                                              new Future.delayed(new Duration(seconds: 3), _login);
                                            });

                                          },
                                          onChanged: (value) {

                                          },
                                          keyboardType: TextInputType.phone,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "Mobile",
                                            labelStyle: TextStyle(
                                                color: Colors.white60,
                                                backgroundColor: Colors.white60),
                                          ),
                                        ),
                                      ),
                                    ),

                                    Container(
                                      width: 190.0,
                                      height: 45,
                                      child: Card(
                                        color:  Colors.green[100].withOpacity(.2),
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(10, 6, 10, 6),
                                          child: PinFieldAutoFill(
                                            controller: otpController,
                                            decoration: UnderlineDecoration(
                                              textStyle: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white60),
                                              colorBuilder: FixedColorBuilder(
                                                  Colors.black.withOpacity(0.3)),
                                            ),
                                            currentCode: _code,
                                            onCodeSubmitted: (code) {
                                              setState(() {
                                                this._code = code;
                                                verifyOTP(code);
                                              });
                                            },
                                            onCodeChanged: (code) {
                                              if (code.length == 6) {
                                                FocusScope.of(context)
                                                    .requestFocus(FocusNode());
                                                verifyOTP(code);
                                                print("otp 6 code");
                                              }
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ]),

                          ],
                        ),
                      ),
                    ),
                  ]))

      )),
    );
  }

  var bodyProgress = new Container(
    color: Colors.transparent,
    child: new Stack(
      children: <Widget>[
        new Container(
          alignment: AlignmentDirectional.center,
          decoration: new BoxDecoration(
          ),
          child: new Container(
            decoration: new BoxDecoration(
                borderRadius: new BorderRadius.circular(10.0)
            ),
            width: 200.0,
            height: 200.0,
            alignment: AlignmentDirectional.center,
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Center(
                  child: new SizedBox(
                    height: 100.0,
                    width: 100.0,
                    child: new CircularProgressIndicator(
                      backgroundColor: Colors.white24,
                      valueColor:AlwaysStoppedAnimation<Color>(Colors.white24),
                      value: null,
                      strokeWidth: 5.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );

  void verifyPhoneNumber(String phoneNumber, {bool isSignup}) {
    FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: Duration(seconds: 60),
        verificationCompleted: (AuthCredential authCredential) {
          print(authCredential);
          FirebaseAuth.instance
              .signInWithCredential(authCredential)
              .then((value) async {
                // _code="346258";
          });
        },
        verificationFailed: (FirebaseAuthException authException) {
          print("verificationFailed");
        },
        codeSent: (String verificationID, int resendToken) {
          setState(() {
            verificationId = verificationID;
            // _code="346258";
            print("code sent");
          });
        },
        codeAutoRetrievalTimeout: (String verificationID) async {
          print("code auto retrieval timeout  :  ");
          setState(() {
            verificationId = verificationID;
          });
        });
  }

  Future<void> verifyOTP(String code) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('phonenumber', phoneController.text);
    AuthCredential authCredential = PhoneAuthProvider.getCredential(
        verificationId: verificationId, smsCode: code);
    FirebaseAuth.instance
        .signInWithCredential(authCredential)
        .then((value) async {
      print(value);
      userSetup(phoneController.text);
      setState(() {
        _loading = true;
        new Future.delayed(new Duration(seconds: 3), _login);
      });
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Home(phoneController.text)),
              (route) => false);
    }).catchError((onError) {
      print(onError);
    });
  }
}
