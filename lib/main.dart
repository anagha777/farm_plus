import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';

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
      home: RegisterPage(title: 'Farm+'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  // MyHomePage({Key key, this.title}) : super(key: key);
  // final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
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
        appBar: AppBar( automaticallyImplyLeading: false,
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
            toolbarHeight: 100, automaticallyImplyLeading: false,
            title: Container(
                width: 80,
                height: 80,
                child: Image.asset('assets/images/icon.png')),
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
                    Card(color: Colors.green[600].withOpacity(.3),margin: EdgeInsets.all(10.0),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: <Widget>[
                            SizedBox(height: 50.0),
                            TextField(
                              obscureText: true,
                              style: style,
                              decoration: InputDecoration(
                                  contentPadding:
                                  EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                  hintText: "USER NAME",hintStyle: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0))),
                            ),
                            SizedBox(height: 25.0),
                            TextField(
                              obscureText: true,
                              style: style,
                              decoration: InputDecoration(
                                  contentPadding:
                                  EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                  hintText: "PASSWORD",hintStyle: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0))),
                            ),
                            SizedBox(
                              height: 50.0,
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
                            Center(child:  Column(
                              children: [
                                GestureDetector(onTap:() {
                                  Navigator.push( context,MaterialPageRoute(builder: (context) => LoginPage()),);},
                                  child:Image(image:AssetImage('assets/images/thump.png'),height: 90,),
                                )],
                            )),
                            SizedBox(
                              height: 1.0,
                            ),
                            Center(child: Text('Register',style: TextStyle(fontSize: 18,color: Colors.white70,fontStyle: FontStyle.italic),),),//,fit: BoxFit.cover,
                          ],
                        ),
                      ),
                    ),
                  ])))),
    );
  }
}

class LoginPage extends StatelessWidget {
  LoginPage({Key key, this.title}) : super(key: key);
  TextStyle style =
  TextStyle(fontFamily: 'Montserrat', fontSize: 20.0, color: Colors.white);
  final String title;
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
                    SizedBox(height: 80,),
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
                    Container(color: Colors.transparent,margin: EdgeInsets.all(65.0),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: <Widget>[
                            SizedBox(height: 30.0),
                            Card(color: Colors.white12.withOpacity(.3),
                              child: TextField(
                                obscureText: true,
                                style: style,
                                decoration: InputDecoration(
                                  contentPadding:
                                  EdgeInsets.fromLTRB(10.0, 10.0, 20.0, 10.0),
                                  hintText: "username@mail.com",hintStyle: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            SizedBox(height: 5.0),
                            Card(color: Colors.white12.withOpacity(.3),
                              child: TextField(
                                obscureText: true,
                                style: style,
                                decoration: InputDecoration(
                                  contentPadding:
                                  EdgeInsets.fromLTRB(10.0, 10.0, 20.0, 10.0),
                                  hintText: "********",hintStyle: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 50.0,
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
                            Center(child:  Column(
                              children: [
                                GestureDetector(onTap:() {
                                  Navigator.push( context,MaterialPageRoute(builder: (context) => MyHomePage()),);},
                                  child:Text(''
                                      'Login',style: TextStyle(fontSize: 18,color: Colors.white70,fontStyle: FontStyle.italic),),),
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
