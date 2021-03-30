import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';
import 'package:load/load.dart';

import 'chat_item_page.dart';
import 'chat_model.dart';

void main() {
  runApp(Home());
}

class Home extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

// class Loginpage extends StatefulWidget {
//   Loginpage({Key key, this.title}) : super(key: key);
//   final String title;
//   @override
//   _Loginpage createState() => _Loginpage();
// }

class _MyHomePageState extends State<Home> {
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
            //   iconSize: 20,
            //   icon: const Icon(Icons.search),
            //   tooltip: 'Search',color: Colors.grey[400],
            //   onPressed: () {
            //     // scaffoldKey.currentState.showSnackBar(snackBar);
            //   },
            // ),
            IconButton(
              icon: const Icon(Icons.more_vert),
              tooltip: 'Settings',color: Colors.grey[400],
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
                icon: ImageIcon(
                  AssetImage("assets/images/home2.png"),
                ),title: Text(""),
                // title: Text("Home", style: TextStyle(fontSize: 11))
  ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage("assets/images/location2.png"),
              ),title: Text(""),
              // title: Text('Sell', style: TextStyle(fontSize: 11)
              // ),
            ),
            BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage("assets/images/sell2.png"),
                  size: 28.0,
                ),title: Text(""),
                // title: Text("Buy", style: TextStyle(fontSize: 11))
            ),
            BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage("assets/images/messag2.png"),
                  size: 28.0,
                ),title: Text(""),

                // title: Text("Message", style: TextStyle(fontSize: 11))
            ),
            BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage("assets/images/account2.png"),
                ),title: Text(""),
                // title: Text("Me",style: TextStyle(fontSize: 11),)
             ),
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

// class RegisterPage extends StatelessWidget {
//   Future<bool> registerUser() async {}
//
//   RegisterPage({Key key, this.title}) : super(key: key);
//   TextStyle style =
//       TextStyle(fontFamily: 'Montserrat', fontSize: 20.0, color: Colors.white);
//   final String title;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.black.withAlpha(150),
//       child: Scaffold(
//           backgroundColor: Colors.green[900].withOpacity(.15),
//           appBar: AppBar(
//             toolbarHeight: 100,
//             automaticallyImplyLeading: false,
//             title: Container(
//                 width: 80,
//                 height: 80,
//                 child: Image.asset('assets/images/app_icon.png')),
//             backgroundColor: Colors.transparent,
//             elevation: 0.0,
//           ),
//           body: BackdropFilter(
//               filter: ImageFilter.blur(sigmaX: 10, sigmaY: 100),
//               child: Container(
//                   child: Column(children: <Widget>[
//                 Center(
//                   child: RichText(
//                     textAlign: TextAlign.center,
//                     text: TextSpan(children: <TextSpan>[
//                       TextSpan(
//                           text: "Farm ",
//                           style: TextStyle(
//                               fontSize: 50,
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold)),
//                       TextSpan(
//                           text: "+",
//                           style: TextStyle(
//                               fontSize: 40,
//                               color: Colors.red[900],
//                               fontWeight: FontWeight.bold)),
//                     ]),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 50,
//                 ),
//                 Container(
//                   color: Colors.transparent,
//                   margin: EdgeInsets.all(30.0),
//                   child: Padding(
//                     padding: const EdgeInsets.all(10.0),
//                     child:
//                         Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
//                       Container(
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: Image.asset('assets/images/key1.png'),
//                         width: 40,
//                         height: 150,
//                       ),
//                       Container(
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: Image.asset('assets/images/key2.png'),
//                         width: 30,
//                         height: 100,
//                       ),
//                       Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: <Widget>[
//                           Container(
//                             height: 50,
//                             width: 180,
//                             child: Card(
//                               color: Colors.white12.withOpacity(.3),
//                               child: TextField(
//                                 obscureText: true,
//                                 style: style,
//                                 decoration: InputDecoration(
//                                   contentPadding:
//                                       EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 10.0),
//                                   hintText: "username@mail.com",
//                                   hintStyle: TextStyle(
//                                       color: Colors.white,
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Container(
//                             width: 180.0,
//                             height: 50,
//                             child: Card(
//                               color: Colors.white12.withOpacity(.3),
//                               child: TextField(
//                                 obscureText: true,
//                                 style: style,
//                                 decoration: InputDecoration(
//                                   contentPadding:
//                                       EdgeInsets.fromLTRB(10.0, 0, 0.0, 10.0),
//                                   hintText: "********",
//                                   hintStyle: TextStyle(
//                                       color: Colors.white,
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ]),
//                   ),
//                 ),
//                 Container(
//                   child: Padding(
//                     padding: const EdgeInsets.all(20.0),
//                     child: Column(
//                       children: <Widget>[
//                         Center(
//                             child: Column(
//                           children: [
//                             GestureDetector(
//                               onTap: () {
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) => Loginpage()),
//                                 );
//                               },
//                               child: Image(
//                                 image: AssetImage('assets/images/thump.png'),
//                                 height: 90,
//                               ),
//                             )
//                           ],
//                         )),
//                         SizedBox(
//                           height: 1.0,
//                         ),
//                         Center(
//                           child: Text('Register',
//                               style: TextStyle(
//                                 fontSize: 18,
//                                 color: Colors.white70,
//                               )
//                               // fontStyle: FontStyle.italic),
//                               ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ])))),
//     );
//   }
// }

// class _Loginpage extends State<Loginpage> {
//   String _code;
//   String signature = "{{ app signature }}";
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     SmsAutoFill().unregisterListener();
//     super.dispose();
//   }
//
//   // _Loginpage({Key key, this.title}) : super(key: key);
//   final myController = TextEditingController();
//   TextStyle style =
//       TextStyle(fontFamily: 'Montserrat', fontSize: 20.0, color: Colors.white);
//   // final String title;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.black.withAlpha(150),
//       child: Scaffold(
//           backgroundColor: Colors.green.withAlpha(10).withOpacity(.1),
//           body: BackdropFilter(
//               filter: ImageFilter.blur(sigmaX: 10, sigmaY: 100),
//               child: Container(
//                   child: Column(children: <Widget>[
//                 SizedBox(
//                   height: 80,
//                 ),
//                 Center(
//                   child: RichText(
//                     textAlign: TextAlign.center,
//                     text: TextSpan(children: <TextSpan>[
//                       TextSpan(
//                           text: "Farm ",
//                           style: TextStyle(
//                               fontSize: 50,
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold)),
//                       TextSpan(
//                           text: "+",
//                           style: TextStyle(
//                               fontSize: 40,
//                               color: Colors.red[900],
//                               fontWeight: FontWeight.bold)),
//                     ]),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 50,
//                 ),
//                 Container(
//                   // color: Colors.transparent,
//                   margin: EdgeInsets.all(30.0),
//                   child: Padding(
//                     padding: const EdgeInsets.all(10.0),
//                     child: Column(
//                       // mainAxisSize: MainAxisSize.max,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.stretch,
//                       children: <Widget>[
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Container(
//                               color: Colors.white12,
//                               height: 45,
//                               child: PhoneFieldHint(
//                                 controller: myController,
//                               )),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(8),
//                           child: Container(
//                             color: Colors.white12,
//                             height: 45,
//                             child: Padding(
//                               padding: const EdgeInsets.all(4.0),
//                               child: PinFieldAutoFill(
//                                 decoration: UnderlineDecoration(
//                                   textStyle: TextStyle(
//                                       fontSize: 20, color: Colors.black),
//                                   colorBuilder: FixedColorBuilder(
//                                       Colors.black.withOpacity(0.3)),
//                                 ),
//                                 currentCode: _code,
//                                 onCodeSubmitted: (code) {},
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Container(
//                   child: Padding(
//                     padding: const EdgeInsets.all(20.0),
//                     child: Column(
//                       children: <Widget>[
//                         Center(
//                             child: Column(
//                           children: [
//                             GestureDetector(
//                               onTap: () {
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) => Home()),
//                                 );
//                               },
//                               child: Text(
//                                 ''
//                                 'Login',
//                                 style: TextStyle(
//                                     fontSize: 18,
//                                     color: Colors.white70,
//                                     fontStyle: FontStyle.italic),
//                               ),
//                             ),
//                           ],
//                         )),
//                       ],
//                     ),
//                   ),
//                 ),
//               ])))),
//     );
//   }
// }

class Screen1 extends StatelessWidget {
  List<String> imgUrls = [
"https://www.google.com/imgres?imgurl=https://cdn.britannica.com/s:900x675,c:crop/16/187216-131-FB186228/tomatoes-tomato-plant-Fruit-vegetable.jpg&imgrefurl=https://www.britannica.com/story/is-a-tomato-a-fruit-or-a-vegetable&tbnid=p-1mjSANqdFJvM&vet=1&docid=BEpXCF4LRKZI7M&w=897&h=674&hl=en-GB&source=sh/x/im",    "https://thumbor.forbes.com/thumbor/fit-in/416x416/filters%3Aformat%28jpg%29/https%3A%2F%2Fspecials-images.forbesimg.com%2Fimageserve%2F5ec595d45f39760007b05c07%2F0x0.jpg%3Fbackground%3D000000%26cropX1%3D989%26cropX2%3D2480%26cropY1%3D74%26cropY2%3D1564",
    "https://static.highsnobiety.com/thumbor/UNG6CQmGikuFcinm20w22aO-nBM=/1600x1067/static.highsnobiety.com/wp-content/uploads/2020/06/09101827/cristiano-ronaldo-1-billion-earnings-01.jpg",
    "https://i2-prod.football.london/incoming/article18887838.ece/ALTERNATES/s1200c/1_Mesut-Ozil.jpg",
"https://www.google.com/imgres?imgurl=https%3A%2F%2Fimages.moneycontrol.com%2Fstatic-mcnews%2F2020%2F04%2Ftea-garden-30042020-770x433.jpg%3Fimpolicy%3Dwebsite%26width%3D770%26height%3D431&imgrefurl=https%3A%2F%2Fwww.moneycontrol.com%2Fnews%2Fbusiness%2Fcommodities%2Fcoronavirus-lockdown-buoys-indian-tea-prices-as-domestic-demand-increases-6055191.html&tbnid=HzNEeG_-pA6RuM&vet=12ahUKEwjc9cm5rNfvAhVS0XMBHfPqCCQQMygjegUIARC0Ag..i&docid=GhUrEvs-bKSnnM&w=770&h=431&q=tea&safe=active&ved=2ahUKEwjc9cm5rNfvAhVS0XMBHfPqCCQQMygjegUIARC0Ag"  ];
  List<String> playerNames = ["Tomato", "Potato", "Banana", "Tea"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Colors.grey[900].withOpacity(.6),
      // appBar: AppBar(
      //   backgroundColor: Colors.teal,
      //   // title: Text("Sample listView"),
      // ),
      body: ListView.builder(
          itemCount: imgUrls.length,

          itemBuilder: (context, index) {

            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: Colors.grey, width: 2)),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
//
                          child: ListTile(
                            leading: Text(
                              playerNames[index],
                              style: TextStyle(
                                  color: Colors.blueGrey,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            trailing: IconButton(icon: Icon(Icons.sort),onPressed: (){
                              showDialog(context: context,
                                  builder: (BuildContext context){
                                    return AlertDialog(
                                      backgroundColor:  Colors.white38,
                                        title: Text('Settings'),
                                        content: Container(
                                          // color:Colors.grey[900].withOpacity(.6),
                                          width: 10,height: 100,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(bottom:8.0),
                                                child: Container(
                                                  child: Text("Update"),
                                                  height: 20,
                                                ),
                                              ),
                                              Container(height: 1,color: Colors.grey,),
                                              SizedBox(height: 5,),
                                              Padding(
                                                padding: const EdgeInsets.only(bottom:8.0),
                                                child: Container(
                                                  child: Text("Delete"),
                                                  height: 20,
                                                ),
                                              ),
                                              // Container(height: 1,color: Colors.grey,),
                                              // SizedBox(height: 5,),
                                              // Padding(
                                              //   padding: const EdgeInsets.only(bottom:8.0),
                                              //   child: Container(
                                              //     child: Text("C........."),
                                              //     height: 20,
                                              //   ),
                                              // ),
                                              // Container(height: 1,color: Colors.grey,),
                                              // SizedBox(height: 5,),
                                              // Padding(
                                              //   padding: const EdgeInsets.only(bottom:8.0),
                                              //   child: Container(
                                              //     child: Text("D.........."),
                                              //     height: 20,
                                              //   ),
                                              // ),
                                              Container(height: 1,color: Colors.grey,),

                                            ],
                                          ),
                                        )
                                    );
                                  }
                              );
                            },),
                          )),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.grey, width: 1)),
                        height: 200,
                        width: 400,
                        child: Image.network(
                          imgUrls[index],
                          width: 300,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
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
            color: Colors.transparent, child: Center(child: Text("Screen 2"))),
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
            color: Colors.transparent, child: Center(child: Text("Screen 3"))),
      ),
    );
  }
}

class Screen4 extends StatelessWidget {
  List<ChatModel> list = ChatModel.list;
  @override
  Widget build(BuildContext context) {
   return Container( color: Colors.grey[900].withOpacity(.6),
     child: Expanded(
         child:
      ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => ChatItemPage(index),
                ),
              );
            },
            leading: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(100),
                ),
                image: DecorationImage(
                  image: AssetImage('assets/images/account1.png'),
                ),
              ),
            ),
            title:  Text(
              list[index].contact.name,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            subtitle: list[index].isTyping
                ? Row(
              children: <Widget>[
                SpinKitThreeBounce(
                  color: Colors.white38,
                  size: 20.0,
                ),
              ],
            )
                : Row(
              children: <Widget>[
                SizedBox(width: 25),
              ],
            ),
          );
        },
      )),
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
            color: Colors.transparent, child: Center(child: Text("Screen 5"))),
      ),
    );
  }
}
