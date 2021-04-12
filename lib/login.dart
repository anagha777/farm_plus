import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';

import 'home.dart';

class Loginpage extends StatefulWidget {
  Loginpage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _Loginpage createState() => _Loginpage();
}

class _Loginpage extends State<Loginpage> {
  String _code;
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
  final otpController = TextEditingController();
  final SmsAutoFill _autoFill = SmsAutoFill();
  String phoneNumber,verificationId;

  TextStyle style = TextStyle(fontSize: 20.0, color: Colors.white);
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
                    SizedBox(
                      height: 70,
                    ),
                    Container(
                      // alignment: Alignment.center,
                      color: Colors.transparent,
                      margin: EdgeInsets.all(10.0),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Row(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(right: 5,left: 10 ,top: 5),
                                    child: Image.asset('assets/images/key1.png'),
                                    width: 35,
                                    height: 150,
                                  ),
                                  Container(margin: EdgeInsets.only(right: 10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Image.asset('assets/images/key2.png'),
                                    width: 25,
                                    height: 130,
                                  ),
                                  Container(
                                    // height: 150,
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          width: 180.0,
                                          height: 40,
                                          child:Card(
                                            color: Colors.white12.withOpacity(.3),
                                            child: PhoneFieldHint(
                                              controller: myController,
                                              autofocus: true,
                                            ),
                                          ),
                                        ),

                                        Container(
                                          width: 180.0,
                                          height: 40,
                                          child: Card(
                                            color: Colors.white12.withOpacity(.3),
                                            child: PinFieldAutoFill(
                                              controller: otpController,
                                              decoration: UnderlineDecoration(
                                                textStyle: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.black),
                                                colorBuilder: FixedColorBuilder(
                                                    Colors.black.withOpacity(0.3)),
                                              ),
                                              currentCode: _code,
                                              onCodeSubmitted: (code) {
                                                setState(() {
                                                  this._code=code;
                                                  print(_code);
                                                  // _isLoadingButton = !_isLoadingButton;
                                                  verifyOTP(code);
                                                });
                                              },
                                              onCodeChanged: (code) {
                                                if (code.length == 6) {
                                                  FocusScope.of(context)
                                                      .requestFocus(FocusNode());
                                                }
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ]),
                            Row(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(right: 5,left: 10 ,top: 5),
                                    width: 35,
                                    height: 50,
                                  ),
                                  Container(margin: EdgeInsets.only(right: 10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    width: 25,
                                    height: 50,
                                  ),
                                  Container(margin: EdgeInsets.only(right: 10),
                                    width: 85.0,
                                    height: 30,

                                  ),
                                  Container(margin: EdgeInsets.only(right: 10),
                                    width: 85.0,
                                    height: 30,
                                    child: RaisedButton(
                                        onPressed: () async {
                                          String hint = await _autoFill.hint;
                                          myController.value = TextEditingValue(text: hint ?? '');
                                          print(hint);
                                          verifyPhoneNumber(hint, isSignup: false);
                                        },
                                        child: Text(
                                          'Send OTP',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.black,
                                          ),),
                                        color:Colors.white24
                                    ),
                                  ),
                                ]),
                          ],
                        ),

                      ),
                    ),
                  ])))),
    );
  }

  void verifyPhoneNumber(String phoneNumber, {bool isSignup}) {
    final PhoneCodeSent codeSent = (String verId, [int forceCodeResend]) {
      this.verificationId = verId;
    };
        FirebaseAuth.instance.verifyPhoneNumber(
            phoneNumber: phoneNumber,
            timeout: Duration(seconds: 0),
            verificationCompleted: (AuthCredential authCredential) {
              print(authCredential);
              FirebaseAuth.instance
                  .signInWithCredential(authCredential)
                  .then((value) async {
                print(value);
              });
            },
            verificationFailed: (FirebaseAuthException authException) {
              print(authException.toString());
            },
            codeSent: (value, [data]) {
              print(value);
            },
        //     codeAutoRetrievalTimeout: (value) {
        //       print("code auto retrieval timeout  :  " + value);
        //       Navigator.pushReplacement(
        //           context,
        //           CupertinoPageRoute(
        //               builder: (context) => OTPAuthScreen(
        //                   phoneNumber: phoneNumber,
        //                   verificationId: value,
        //                   isSignup: isSignup)));
        //     });
        // verificationCompleted: (AuthCredential authCredential) {
        //   print(authCredential);
        //   verifyOTP(_code);
        //   FirebaseAuth.instance
        //       .signInWithCredential(authCredential)
        //       .then((value) async {
        //   //       // Home();
        //   //   print("verified");
        //   });
        // },
        // verificationFailed: (FirebaseAuthException authException) {
        //   print(authException.toString());
        // },
        // codeSent:codeSent,
          //   (value, [data]) {
          // print(value);(String verificationId, [int forceResendingToken]){
          //   setState(() {
          //     verificationId = verificationId;
          //     // status = 'Code sent';
          //   });
          // };

        codeAutoRetrievalTimeout: (value) async {
          print("code auto retrieval timeout  :  ");
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('phonenumber', phoneNumber);
          // print("covcvbcbvnbvnbbnvnb timeout  :  " +
          //     prefs.getString('phoneNumber'));
          // verifyOTP(verificationId);
        //   Navigator.pushReplacement(
        //       context,
        //       CupertinoPageRoute(
        //           builder: (context) => Home(
        //               // phoneNumber: phoneNumber,
        //               // verificationId: value,
        //               // isSignup: isSignup
        //               )));
        });
  }

  Future<void> verifyOTP(String code) async {
    print(code);
    await FirebaseAuth.instance
        .signInWithCredential(PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: otpController.text))
        .then((value) async {
      if (value.user != null) {

    print( otpController.text);
    print( verificationId);

      Home(phoneNumber);
      // } else {
      //   Navigator.pushReplacement(
      //       context, CupertinoPageRoute(builder: (context) => Home()));
    }});
  }
}
