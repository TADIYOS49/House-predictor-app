import 'package:Signin/authserve.dart';
import 'package:Signin/login.dart';
import 'package:Signin/models/usermodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileData extends StatefulWidget {
  @override
  _ProfileDataState createState() => _ProfileDataState();
}

class _ProfileDataState extends State<ProfileData> {
  User user = FirebaseAuth.instance.currentUser;
  final CollectionReference usercolleciton =
      FirebaseFirestore.instance.collection('user_list');
  
  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      ClipPath(
        child: Container(
          color: Colors.green[800].withOpacity(0.8),
        ),
        clipper: getClipper(),
      ),
      Positioned(
        width: 350.0,
        top: MediaQuery.of(context).size.height / 5,
        child: Column(
          children: [
            Container(
              width: 150.0,
              height: 150.0,
              decoration: BoxDecoration(
                  color: Colors.greenAccent,
                  image: DecorationImage(
                      image: NetworkImage('https://i.pravatar.cc/400'),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.all(Radius.circular(75.0)),
                  boxShadow: [BoxShadow(blurRadius: 7.0, color: Colors.black)]),
            ),
            SizedBox(
              height: 35.0,
            ),
            Text('Name here.',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat',
                  fontSize: 30,
                )),
            SizedBox(
              height: 15.0,
            ),
            Text('email here.',
                style: TextStyle(
                  color: Colors.black,
                  fontStyle: FontStyle.italic,
                  fontFamily: 'Montserrat',
                  fontSize: 17,
                )),
            SizedBox(
              height: 25.0,
            ),
            FlatButton.icon(
                onPressed: () async {
                  await Authserve().signOut();
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => Login()));
                },
                icon: Icon(Icons.logout, size: 35.0, color: Colors.green[500]),
                label: Text(
                  'Logout',
                  style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                ))
          ],
        ),
      )
    ]);
  }
}

// ignore: camel_case_types
class getClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(0.0, size.height / 1.90);
    path.lineTo(size.width + 670, 0.0);
    path.close();
    return path;
  }

  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
