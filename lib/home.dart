
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';
import 'package:load/load.dart';

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

class MyHomePage extends StatefulWidget {
  // MyHomePage({Key key, this.title}) : super(key: key);
  // final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class Loginpage extends StatefulWidget {
  Loginpage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _Loginpage createState() => _Loginpage();
}

class _MyHomePageState extends State<MyHomePage> {
  int _pageIndex = 0;
  PageController _pageController;

  List<Widget> tabPages = [
    Screen1(),
    Screen2(),
    Screen3(),
    Screen4(),
    Screen5(),
  ];
  final GlobalKey scaffoldKey = GlobalKey();
  final SnackBar snackBar = const SnackBar(content: Text('Showing Snackbar'));
  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _pageIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Container(
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: SearchBox(),
          actions: [
            // IconButton(
            //   icon: const Icon(Icons.search),
            //   tooltip: 'Search',color: Colors.grey[400],
            //   onPressed: () {
            //     // scaffoldKey.currentState.showSnackBar(snackBar);
            //   },
            // ),
            IconButton(
              icon: const Icon(Icons.more_vert),
              tooltip: 'Next page',
              onPressed: () {
                // openPage(context);
              },
            ),
          ],
          backgroundColor: Colors.grey[900].withOpacity(.6),
          elevation: 0.0,
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _pageIndex,
          selectedItemColor: Colors.white70,
          onTap: onTabTapped,
          iconSize: 24.0,
          backgroundColor: Colors.grey[900].withOpacity(.6),
          type: BottomNavigationBarType.fixed,
          unselectedItemColor: Colors.grey.withOpacity(.4),
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home), title: Text("Home")),
            BottomNavigationBarItem(
                icon: Icon(Icons.location_on), title: Text("Sell")),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_basket), title: Text("Buy")),
            BottomNavigationBarItem(
                icon: Icon(Icons.message), title: Text("Message")),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_box), title: Text("Me")),
            // Image.asset('assets/images/messageblack.png'),
            // title: Text("Message")),
          ],
        ),
        body: PageView(
          children: tabPages,
          onPageChanged: onPageChanged,
          controller: _pageController,
        ),
        backgroundColor: Colors.green[900].withOpacity(.8),
      ));
  void onPageChanged(int page) {
    setState(() {
      this._pageIndex = page;
    });
  }

  void onTabTapped(int index) {
    this._pageController.animateToPage(index,
        duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
  }
}

class SearchBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Text(
          'Farm',
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              fontFamily: 'Source Sans Pro',
              color: Colors.white),
        ),
        Text(
          ' +',
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'Source Sans Pro',
              color: Colors.red),
        ),
        Container(
          color: Colors.transparent,
          margin: EdgeInsets.only(left: 20, right: 0, top: 0, bottom: 0),
          width: 208,
          height: 30,
          child: TextField(
            style: TextStyle(
              color: Colors.white,
            ),
            decoration: InputDecoration(
              suffixIcon: Icon(Icons.search),
              enabledBorder: new OutlineInputBorder(
                  borderSide: new BorderSide(
                    color: Colors.white54,
                  )),
              contentPadding:
              EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
              hintText: 'Search here',
              hintStyle: TextStyle(
                color: Colors.white10,
              ),
            ),
          ),
        )
      ],
      key: key,
      mainAxisAlignment: MainAxisAlignment.start,
    );
  }
}

class RegisterPage extends StatelessWidget {
  Future<bool> registerUser() async{

  }

  RegisterPage({Key key, this.title}) : super(key: key);
  TextStyle style =
  TextStyle(fontFamily: 'Montserrat', fontSize: 20.0, color: Colors.white);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withAlpha(150),
      child: Scaffold(
          backgroundColor: Colors.green[900].withOpacity(.15),
          appBar: AppBar(
            toolbarHeight: 100,
            automaticallyImplyLeading: false,
            title: Container(
                width: 80,
                height: 80,
                child: Image.asset('assets/images/app_icon.png')),
            backgroundColor: Colors.transparent,
            elevation: 0.0,
          ),
          body: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 100),
              child: Container(
                  child: Column(children: <Widget>[
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
                      color: Colors.transparent,
                      margin: EdgeInsets.all(30.0),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children:<Widget>[
                              Container(
                                decoration:BoxDecoration(
                                  borderRadius:BorderRadius.circular(10),
                                ),
                                child: Image.asset('assets/images/key1.png'),width: 40,height: 150,
                              ),
                              Container(
                                decoration:BoxDecoration(
                                  borderRadius:BorderRadius.circular(10),
                                ),
                                child: Image.asset('assets/images/key2.png'),width: 30,height: 100,
                              ),
                              Column(
                                mainAxisAlignment:MainAxisAlignment.center ,
                                children: <Widget>[
                                  Container(
                                    height: 50,
                                    width: 180,
                                    child:Card(color: Colors.white12.withOpacity(.3),
                                      child: TextField(
                                        obscureText: true,
                                        style: style,
                                        decoration: InputDecoration(
                                          contentPadding:
                                          EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 10.0),
                                          hintText: "username@mail.com",
                                          hintStyle: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 180.0,
                                    height: 50,
                                    child: Card(
                                      color: Colors.white12.withOpacity(.3),
                                      child: TextField(
                                        obscureText: true,
                                        style: style,
                                        decoration: InputDecoration(
                                          contentPadding:
                                          EdgeInsets.fromLTRB(10.0, 0, 0.0, 10.0),
                                          hintText: "********",
                                          hintStyle: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ]
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
                                              builder: (context) => Loginpage()),
                                        );
                                      },
                                      child: Image(
                                        image: AssetImage('assets/images/thump.png'),
                                        height: 90,
                                      ),
                                    )
                                  ],
                                )),
                            SizedBox(
                              height: 1.0,
                            ),
                            Center(
                              child: Text(
                                  'Register',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white70,)
                                // fontStyle: FontStyle.italic),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ])))),
    );
  }
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

class Screen1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[900].withOpacity(.6),
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Card(
            color: Colors.teal.withOpacity(.3),
            child: Center(child: Text("Screen 1"))),
      ),
    );
  }
}

class Screen2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[900].withOpacity(.6),
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Card(
            color: Colors.teal.withOpacity(.3),
            child: Center(child: Text("Screen 2"))),
      ),
    );
  }
}

class Screen3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[900].withOpacity(.6),
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Card(
            color: Colors.teal.withOpacity(.3),
            child: Center(child: Text("Screen 3"))),
      ),
    );
  }
}

class Screen4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[900].withOpacity(.6),
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Card(
            color: Colors.teal.withOpacity(.3),
            child: Center(child: Text("Screen 4"))),
      ),
    );
  }
}

class Screen5 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[900].withOpacity(.6),
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Card(
            color: Colors.teal.withOpacity(.3),
            child: Center(child: Text("Screen 5"))),
      ),
    );
  }
}
