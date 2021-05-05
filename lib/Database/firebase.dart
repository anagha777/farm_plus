import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> userSetup(String phonenumber) async {

  CollectionReference users = FirebaseFirestore.instance.collection('Users');
  FirebaseAuth auth = FirebaseAuth.instance;
  String uid = auth.currentUser.uid.toString();
    var a = await users.document(phonenumber).get();
    if(a.exists){
      print('Exists');
      return a;
    }
    if(!a.exists){
      users.add({'phone number': phonenumber, 'uid': uid});
      print('added');
      return;
    }

}
