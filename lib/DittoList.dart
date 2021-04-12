import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

//void main() => runApp(DittoList());
//
//class MyApp extends StatefulWidget {
//  @override
//  _MyAppState createState() => _MyAppState();
//}
//
//class _MyAppState extends State<MyApp> {
//  Completer<GoogleMapController> _controller = Completer();
//
//  static const LatLng _center = const LatLng(45.521563, -122.677433);
//
//  void _onMapCreated(GoogleMapController controller) {
//    _controller.complete(controller);
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      home: Scaffold(
//        appBar: AppBar(
//          title: Text('Maps Sample '),
//          backgroundColor: Colors.green[700],
//        ),
//        body: GoogleMap(
//          onMapCreated: _onMapCreated,
//          initialCameraPosition: CameraPosition(
//            target: _center,
//            zoom: 22.0,
//          ),
//        ),
//      ),
//    );
//  }
//}

class DittoList extends StatefulWidget {
  @override
  _DittoListState createState() => _DittoListState();
}

class _DittoListState extends State<DittoList> {
  String nonMarkedIcon = "icons/blank-square.png";
  String markedIcon = "icons/checkBox.png";
  bool isSelected = false;
  int currentSelectedIndex;

  List<String> vegList = [
    "Onion Small",
    "Onion big",
    "Carrot",
    "Beets",
    "Potatoes",
    "Beans",
    "Tomatoes"
  ];
  List<String> rate = [
    "₹38/kg",
    "₹27/kg",
    "₹40/kg",
    "₹50/kg",
    "₹40/kg",
    "₹42/kg",
    "₹44/kg"
  ];
  List<String> quantity = [
    "500g",
    "1Kg",
    "2Kg",
    "2.5Kg",
    "3Kg",
    "1.5Kg",
    "3.5Kg"
  ];
  List<String> amount = [
    "₹19.00",
    "₹27.00",
    "₹40.00",
    "₹125.00",
    "₹120.00",
    "₹38.00",
    "₹17.00"
  ];
  List<String> fruitList = [
    "Apple",
    "Orange",
    "Grape",
    "Banana",
    "Kiwi",
    "Water melon",
    "Strawberry"
  ];
  List<String> fruitRate = [
    "₹58/kg",
    "₹30/kg",
    "₹40/kg",
    "₹30/kg",
    "₹40/kg",
    "₹22/kg",
    "₹54/kg"
  ];
  List<String> fruitQuantity = [
    "500g",
    "1Kg",
    "2Kg",
    "2.5Kg",
    "3Kg",
    "1.5Kg",
    "1Kg"
  ];
  List<String> fruitAmount = [
    "₹29.00",
    "₹30.00",
    "₹80.00",
    "₹75.00",
    "₹120.00",
    "₹33.00",
    "₹54.00"
  ];


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        // appBar: AppBar(),
        backgroundColor: Colors.grey[900].withOpacity(.6),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Container(
                width: 110,
                child: Row(
                  children: [
                    Text(
                      "Veggie List",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Text(
                      "Rate",
                      style: TextStyle(
                          color: Colors.grey[200],
                          fontWeight: FontWeight.w500,
                          fontSize: 18),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      "Quantity",
                      style: TextStyle(
                          color: Colors.grey[200],
                          fontWeight: FontWeight.w500,
                          fontSize: 18),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Amount",
                      style: TextStyle(
                          color: Colors.grey[200],
                          fontWeight: FontWeight.w500,
                          fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 150,
              child: ListView.builder(
                  itemCount: vegList.length,
                  itemBuilder: (BuildContext cntxt, int index) {
                    return Card(
//                      onSelect: (){
//                        setState(() {
//                          currentSelectedIndex = index;
//                        });
//                      },
                      amount: amount[index],
                      quantity: quantity[index],
                      rate: rate[index],
                      veg: vegList[index],
//                      isSelected: currentSelectedIndex == index,
                    );
                  }),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),

              child: Row(
                children: [
                  Text(
                    "Add Item",
                    style: TextStyle(
                        color: Colors.redAccent,
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 80,
                  ),
                  Text(
                    "Sub Total",
                    style: TextStyle(
                        color: Colors.blueAccent[200],
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 50,
                  ),
                  Text(
                    "₹331.00",
                    style: TextStyle(
                        color: Colors.blueAccent[200],
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            ListTile(
              title: Container(
                child: Row(
                  children: [
                    // SizedBox(
                    //   width: 30,
                    // ),
                    Text(
                      "Fruit List",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    SizedBox(
                      width: 59,
                    ),
                    Text(
                      "Rate",
                      style: TextStyle(
                          color: Colors.grey[200],
                          fontWeight: FontWeight.w500,
                          fontSize: 18),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Quantity",
                      style: TextStyle(
                          color: Colors.grey[200],
                          fontWeight: FontWeight.w500,
                          fontSize: 18),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Amount",
                      style: TextStyle(
                          color: Colors.grey[200],
                          fontWeight: FontWeight.w500,
                          fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 230,
              child: ListView.builder(
                  itemCount: vegList.length,
                  itemBuilder: (BuildContext cntxt, int index) {
                    return Card(
//                      onSelect: (){
//                        setState(() {
//                          currentSelectedIndex = index;
//                        });
//                      },
                      amount: fruitAmount[index],
                      quantity: fruitQuantity[index],
                      rate: fruitRate[index],
                      veg: fruitList[index],
//                      isSelected: currentSelectedIndex == index,
                    );

                  }),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Row(
                children: [
                  Text(
                    "Add Item",
                    style: TextStyle(
                        color: Colors.redAccent,
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 80,
                  ),
                  Text(
                    "Sub Total",
                    style: TextStyle(
                        color: Colors.blueAccent[200],
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 50,
                  ),
                  Text(
                    "₹421.00",
                    style: TextStyle(
                        color: Colors.blueAccent[200],
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),

    );
  }
}

class Card extends StatefulWidget {

//  final bool isSelected;
  final String veg;
  final String rate;
  final String quantity;
  final String amount;
  final VoidCallback onSelect;


  const Card({Key key, this.veg, this.rate, this.quantity, this.amount,this.onSelect}) : super(key: key);
  @override
  _CardState createState() => _CardState();
}

class _CardState extends State<Card> {
  String nonMarkedIcon = "icons/blank-square.png";
  String markedIcon = "icons/checkBox.png";
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
      children: [
        Container(
          height: 30,
          width: 145,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                  icon: Image.asset(
                      !isSelected ? nonMarkedIcon : markedIcon),
                  onPressed: () {


                    setState(() {
                      isSelected = !isSelected;
                    });
                  }),
              Text(
                widget.veg,
                style: TextStyle(
                    color: Colors.grey[200],
                    fontWeight: FontWeight.normal,
                    fontSize: 16),
              )
            ],
          ),
        ),
        SizedBox(
          width: 20,
        ),
        Container(
          height: 20,
          width: 110,
          color: Colors.white30,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.rate,
                style: TextStyle(
                    color: Colors.grey[200],
                    fontWeight: FontWeight.normal,
                    fontSize: 16),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                widget.quantity,
                style: TextStyle(
                    color: Colors.grey[200],
                    fontWeight: FontWeight.normal,
                    fontSize: 16),
              )
            ],
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Container(
          height: 20,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 20,
              ),
              Text(
                widget.amount,
                style: TextStyle(
                    color: Colors.grey[200],
                    fontWeight: FontWeight.normal,
                    fontSize: 16),
              )
            ],
          ),
        ),
      ],
    ));
  }
}
