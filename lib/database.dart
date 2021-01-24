import 'package:Signin/models/usermodel.dart';
import 'package:Signin/updatenotifer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Signin/models/housemodel.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});
  //static var counter = 0;
  //collection reference.
  final CollectionReference usercolleciton =
      FirebaseFirestore.instance.collection('user_list');
  final CollectionReference housecollection =
      FirebaseFirestore.instance.collection('house_list');
  User user = FirebaseAuth.instance.currentUser;
  Future addhouseData(
      String name, String area, String bedrooms, String location) async {
    return housecollection.doc().set({
      'uid': user.uid,
      'name': name,
      'area': area,
      'bedrooms': bedrooms,
      'location': location
    });
  }

  Future updateHouseData(
      String name, String area, String bedroom, String location, String id,
      {bool isUpdating = true}) async {
    CollectionReference houseref =
        // ignore: await_only_futures
        await FirebaseFirestore.instance.collection('house_list');
    if (isUpdating) {
      print(uid);
      print('\n');
      print(id);
      await houseref.doc(id).update({
        'area': area,
        'bedrooms': bedroom,
        'location': location,
        'name': name
      });
  
    } else {}
  }

  Future updateUserData(String name, String email) async {
    return await usercolleciton.doc(uid).set({
      'uid': user.uid,
      'name': name,
      'email': email,
    });
  }

  Housemodel _house(QueryDocumentSnapshot doc) {
    return Housemodel(
      uid: doc.data()['uid'] ?? 'null',
      name: doc.data()['name'] ?? 'null',
      bedroom: doc.data()['bedrooms'] ?? 0,
      location: doc.data()['location'] ?? 'null',
      area: doc.data()['area'] ?? 0,
    );
  }

  //house list from snapshot
  List<Housemodel> _houselistfromsnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Housemodel(
        id: doc.id,
        uid: doc.data()['uid'] ?? 'null',
        name: doc.data()['name'] ?? 'null',
        bedroom: doc.data()['bedrooms'] ?? 0,
        location: doc.data()['location'] ?? 'null',
        area: doc.data()['area'] ?? 0,
      );
    }).toList();
  }

  //user data from snapshot
  UserData _userdatafromsnapshot(DocumentSnapshot snapshot) {
    return UserData(uid: uid, name: snapshot.data()['name']);
  }

  //get data strea

  Stream<List<Housemodel>> get housedata {
    //print(user.uid);
    return housecollection.snapshots().map(_houselistfromsnapshot);
  }

  getHouse(Notifier housenotifier) async {
    QuerySnapshot snapshot = await housecollection.get();
    List<Housemodel> _houselist = _houselistfromsnapshot(snapshot);

    housenotifier.houselist = _houselist;
  }

  // get user doc stream
  Stream<UserData> get userData {
    return usercolleciton.doc(uid).snapshots().map(_userdatafromsnapshot);
  }
}
