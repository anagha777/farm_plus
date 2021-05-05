import 'dart:async';
// import 'dart:js';
import 'dart:ui';
import 'package:farm_plus/Constants.dart';
import 'package:farm_plus/login.dart';
import 'package:farm_plus/src/model/place.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'DittoList.dart';
import 'chat_item_page.dart';
import 'chat_model.dart';
import 'map/map_block.dart';

Future<void> main() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String mobilenumber = prefs.getString('phonenumber');
  runApp(Home(mobilenumber));
}

class Home extends StatefulWidget {
  String mobilenumber = "0000000";
  Home(String phonenumber) {
    this.mobilenumber = phonenumber;
    // print(mobilenumber);
  }

  @override
  _MyHomePageState createState() => _MyHomePageState(mobilenumber);
}

class _MyHomePageState extends State<Home> {
  int _pageIndex = 0;
  PageController _pageController;
  static String mobilenumber;
  _MyHomePageState(String phonenumber) {
    mobilenumber = phonenumber;
    print(mobilenumber);
  }
  List<Widget> tabPages = [Screen1(), Map(), DittoList(), Screen4(), Screen5()];
  final GlobalKey scaffoldKey = GlobalKey();
  final SnackBar snackBar = const SnackBar(content: Text('Showing Snackbar'));
  bool _isVisible = true;
  ScrollController scrollcontroller;
  @override
  void initState() {
    super.initState();
    scrollcontroller = ScrollController();
    scrollcontroller.addListener(() {
      setState(() {
        _isVisible = scrollcontroller.position.userScrollDirection ==
            ScrollDirection.forward;
      });
    });
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
            Row(
              children: [
                Container(
                  width: 15,
                  height: 40,
                  child: IconButton(
                    icon: const Icon(Icons.search),
                    tooltip: 'Search',
                    color: Colors.grey[400],
                    onPressed: () {
                      Constants.choices;
                      // scaffoldKey.currentState.showSnackBar(snackBar);
                    },
                  ),
                ),
              ],
            ),
            PopupMenuButton<String>(
              onSelected: choiceAction,
              color: Colors.green[200].withOpacity(.2),
              itemBuilder: (BuildContext context) {
                return Constants.choices.map((String choice) {
                  return PopupMenuItem<String>(
                      value: choice,
                      child: Text(
                        choice,
                        style: TextStyle(color: Colors.white60),
                      ));
                }).toList();
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
              ),
              title: Text(""),
              // title: Text("Home", style: TextStyle(fontSize: 11))
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage("assets/images/location2.png"),
              ),
              title: Text(""),
              // title: Text('Sell', style: TextStyle(fontSize: 11)
              // ),
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage("assets/images/sell2.png"),
                size: 28.0,
              ),
              title: Text(""),
              // title: Text("Buy", style: TextStyle(fontSize: 11))
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage("assets/images/messag2.png"),
                size: 28.0,
              ),
              title: Text(""),

              // title: Text("Message", style: TextStyle(fontSize: 11))
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage("assets/images/account2.png"),
              ),
              title: Text(""),
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

  Future<void> choiceAction(String choice) async {
    if (choice == Constants.Settings) {}
    if (choice == Constants.Personal_details) {
      Screen5();
    }
    if (choice == Constants.Logout) {
      FirebaseAuth.instance.signOut();
      User user = FirebaseAuth.instance.currentUser;
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.clear();
      print('$user');
      // Loginpage(title: 'Farm+');
      Navigator.pushReplacement(
          context,
          CupertinoPageRoute(
              builder: (context) => Loginpage(
                  // phoneNumber: phoneNumber,
                  // verificationId: value,
                  // isSignup: isSignup
                  )));
    }
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
              fontSize: 24,
              fontWeight: FontWeight.w800,
              // fontFamily: 'Source Sans Pro',
              color: Colors.white70),
        ),
        Text(
          ' +',
          style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              fontFamily: 'Source Sans Pro',
              color: Colors.red),
        ),
        Container(
          color: Colors.white24,
          margin: EdgeInsets.only(left: 20, right: 0, top: 0, bottom: 0),
          width: 170,
          height: 30,
          child: TextField(
            style: TextStyle(
              color: Colors.white70,
            ),
            // decoration: InputDecoration(
            //   // suffixIcon: Icon(Icons.search),
            //   enabledBorder: new OutlineInputBorder(
            //       borderSide: new BorderSide(
            //     color: Colors.white10,
            //   )
            //   ),
            //   contentPadding:
            //       EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
            //   hintText: 'Search here',
            //   hintStyle: TextStyle(
            //     color: Colors.white10,
            //   ),
            // ),
          ),
        )
      ],
      key: key,
      // mainAxisAlignment: MainAxisAlignment.start,
    );
  }
}

class Screen1 extends StatefulWidget {
  @override
  _Screen1State createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {
  List<String> images = [
    'assets/images/tomato.jpeg',
    'assets/images/potato.jpg',
    'assets/images/banana.jpeg',
    'assets/images/tea.jpg'
  ];

  List<String> playerNames = ["Tomato", "Potato", "Banana", "Tea"];
  bool _isVisible = true;
  ScrollController scrollcontroller;
  @override
  void initState() {
    super.initState();
    scrollcontroller = ScrollController();
    scrollcontroller.addListener(() {
      setState(() {
        _isVisible = scrollcontroller.position.userScrollDirection ==
            ScrollDirection.forward;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900].withOpacity(.6),
      body: ListView.builder(
          controller: scrollcontroller,
          itemCount: images.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: Colors.transparent, width: 2)),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                          child: ListTile(
                        leading: Text(
                          playerNames[index],
                          style: TextStyle(
                              color: Colors.blueGrey,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                        trailing: IconButton(
                          icon: Icon(
                            Icons.sort,
                            color: Colors.white60,
                          ),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                      backgroundColor:
                                          Colors.green[200].withOpacity(.3),
                                      // title: Text('Settings'),
                                      content: Container(
                                        // color:Colors.grey[900].withOpacity(.6),
                                        width: 10, height: 100,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 8.0,
                                                  top: 10,
                                                  left: 10),
                                              child: Container(
                                                child: Text(
                                                  "Save",
                                                  style: TextStyle(
                                                      color: Colors.white60,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  textScaleFactor: 1.0,
                                                ),
                                              ),
                                            ),

                                            // Container(height: 1,color: Colors.white60,),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 8.0,
                                                  top: 10,
                                                  left: 10),
                                              child: Container(
                                                child: Text(
                                                  "Share",
                                                  style: TextStyle(
                                                      color: Colors.white60,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  textScaleFactor: 1.0,
                                                ),
                                                // height: 20,
                                              ),
                                            ),
                                            // Container(height: 1,color: Colors.grey,),
                                          ],
                                        ),
                                      ));
                                });
                          },
                        ),
                      )),
                      SizedBox(
                        height: 20,
                      ),

                      Image.asset(
                        images[index],
                        width: 300,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                      //   child: Image.network(
                      //     imgUrls[index],
                      //     width: 300,
                      //     height: 200,
                      //     fit: BoxFit.cover,
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}

class Map extends StatefulWidget {
  Map({Key key}) : super(key: key);

  @override
  Screen2 createState() => Screen2();
}

class Screen2 extends State<Map> {
  Completer<GoogleMapController> _mapController = Completer();
  StreamSubscription locationSubscription;
  StreamSubscription boundsSubscription;
  final _locationController = TextEditingController();

  @override
  void initState() {
    // final applicationBloc = Provider.of<ApplicationBloc>( context, listen: false);

    //Listen for selected Location
    // locationSubscription = applicationBloc.selectedLocation.stream.listen((place) {
    //   if (place != null) {
    //     _locationController.text = place.name;
    //     _goToPlace(place);
    //   } else
    //     _locationController.text = "";
    // });
    //
    // applicationBloc.bounds.stream.listen((bounds) async {
    //   final GoogleMapController controller = await _mapController.future;
    //   controller.animateCamera(CameraUpdate.newLatLngBounds(bounds, 50));
    // });
    super.initState();
  }

  @override
  void dispose() {
    final applicationBloc =
        Provider.of<ApplicationBloc>(context, listen: false);
    applicationBloc.dispose();
    _locationController.dispose();
    locationSubscription.cancel();
    boundsSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final applicationBloc = Provider.of<ApplicationBloc>(context);
    return Scaffold(
        body: (applicationBloc.currentLocation == null)
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _locationController,
                      textCapitalization: TextCapitalization.words,
                      decoration: InputDecoration(
                        hintText: 'Search by City',
                        suffixIcon: Icon(Icons.search),
                      ),
                      onChanged: (value) => applicationBloc.searchPlaces(value),
                      onTap: () => applicationBloc.clearSelectedLocation(),
                    ),
                  ),
                  Stack(
                    children: [
                      Container(
                        height: 500.0,
                        child: GoogleMap(
                          mapType: MapType.normal,
                          myLocationEnabled: true,
                          // initialCameraPosition: CameraPosition(
                          //   target: LatLng(
                          //       applicationBloc.currentLocation.latitude,
                          //       applicationBloc.currentLocation.longitude),
                          //   zoom: 14,
                          // ),
                          onMapCreated: (GoogleMapController controller) {
                            _mapController.complete(controller);
                          },
                          markers: Set<Marker>.of(applicationBloc.markers),
                        ),
                      ),
                      if (applicationBloc.searchResults != null &&
                          applicationBloc.searchResults.length != 0)
                        Container(
                            height: 300.0,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(.6),
                                backgroundBlendMode: BlendMode.darken)),
                      if (applicationBloc.searchResults != null)
                        Container(
                          height: 300.0,
                          child: ListView.builder(
                              itemCount: applicationBloc.searchResults.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Text(
                                    applicationBloc
                                        .searchResults[index].description,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onTap: () {
                                    applicationBloc.setSelectedLocation(
                                        applicationBloc
                                            .searchResults[index].placeId);
                                  },
                                );
                              }),
                        ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Find Nearest',
                        style: TextStyle(
                            fontSize: 25.0, fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Wrap(
                      spacing: 8.0,
                      children: [
                        FilterChip(
                          label: Text('25km'),
                          onSelected: (val) => applicationBloc.togglePlaceType(
                              'campground', val),
                          selected: applicationBloc.placeType == 'campground',
                          selectedColor: Colors.blue,
                        ),
                        FilterChip(
                            label: Text('30km'),
                            onSelected: (val) => applicationBloc
                                .togglePlaceType('locksmith', val),
                            selected: applicationBloc.placeType == 'locksmith',
                            selectedColor: Colors.blue),
                        FilterChip(
                            label: Text('35km'),
                            onSelected: (val) => applicationBloc
                                .togglePlaceType('pharmacy', val),
                            selected: applicationBloc.placeType == 'pharmacy',
                            selectedColor: Colors.blue),
                      ],
                    ),
                  )
                ],
              ));
  }

  Future<void> _goToPlace(Place place) async {
    final GoogleMapController controller = await _mapController.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(
                place.geometry.location.lat, place.geometry.location.lng),
            zoom: 14.0),
      ),
    );
  }
}

class Screen4 extends StatelessWidget {
  List<ChatModel> list = ChatModel.list;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[900].withOpacity(.6),
      child: Expanded(
          child: ListView.builder(
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
              height: 60,
              child: Icon(
                Icons.person,
                size: 45,
                color: Colors.white54,
              ),
            ),
            title: Text(
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

class Screen5 extends StatefulWidget {
  @override
  _Screen5State createState() => _Screen5State();
}

class _Screen5State extends State<Screen5> {
  static String mobilenumber = "";
  _Screen5State() {
    checkFirstScreen();
  }
  @override
  void initState() {
    checkFirstScreen();
    super.initState();
  }

  Future<void> checkFirstScreen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    mobilenumber = prefs.getString('phonenumber');
    print(mobilenumber);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.grey[900].withOpacity(.6),
        alignment: Alignment.center,
        child: Column(children: <Widget>[
          SizedBox(
            height: 80,
          ),
          Center(
            child: Container(
              margin: EdgeInsets.only(right: 5, left: 10, top: 5),
              child: Icon(
                Icons.person,
                size: 140,
                color: Colors.white54,
              ),
              width: 100,
              height: 100,
            ),
          ),
          SizedBox(
            height: 70,
          ),
          Container(
            // alignment: Alignment.center,
            color: Colors.transparent,
            margin: EdgeInsets.all(10.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.person,
                      size: 50,
                      color: Colors.white54,
                    ),
                    title: Column(
                      children: [
                        Text(
                          'Name',
                          textScaleFactor: 1.0,
                          style: TextStyle(color: Colors.white70),
                        ),
                        Text(
                          'Name',
                          textScaleFactor: 1.0,
                          style: TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                    trailing: Icon(
                      Icons.edit,
                      size: 30,
                      color: Colors.white54,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.phone,
                      size: 40,
                      color: Colors.white54,
                    ),
                    title: Column(
                      children: [
                        Text(
                          'Phone Number',
                          textScaleFactor: 1.0,
                          style: TextStyle(color: Colors.white70),
                        ),
                        Text(
                          mobilenumber,
                          textScaleFactor: 1.0,
                          style: TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                    trailing: Icon(
                      Icons.edit,
                      size: 30,
                      color: Colors.white54,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]));
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
