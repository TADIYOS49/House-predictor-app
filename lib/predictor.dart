import 'package:Signin/Profile.dart';
import 'package:Signin/about.dart';
import 'package:Signin/authserve.dart';
import 'package:Signin/home.dart';
import 'package:Signin/house_list.dart';
import 'package:Signin/house_tile.dart';
import 'package:Signin/login.dart';
import 'package:Signin/models/housemodel.dart';
import 'package:Signin/models/usermodel.dart';
import 'package:Signin/newdataupdate.dart';
import 'package:Signin/settings_form.dart';
import 'package:Signin/updatenotifer.dart';
import 'package:flutter/material.dart';
import 'package:Signin/database.dart';
import 'package:provider/provider.dart';

class Predictor extends StatefulWidget {
  @override
  _PredictorState createState() => _PredictorState();
}

class _PredictorState extends State<Predictor> {
  final Authserve _authserve = Authserve();

  @override
  Widget build(BuildContext context) {
    Notifier houseNotifier = Provider.of<Notifier>(context);
    void _showsettingspanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.green)),
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: NewData(),
            );
          });
    }

    _navBar(context) {
      return Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.green),
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0), topRight: Radius.circular(25.0)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              child: Icon(
                Icons.home_rounded,
                size: 35.0,
                color: Colors.green[500],
              ),
              onTap: () {
                Navigator.of(context)
                    .pushReplacement(MaterialPageRoute(builder: (_) => Home()));
              },
            ),
            InkWell(
              child: Icon(
                Icons.lightbulb,
                size: 35.0,
                color: Colors.green[500],
              ),
              onTap: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => Predictor()));
              },
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
              child: FloatingActionButton(
                elevation: 15.0,
                backgroundColor: Colors.green[500],
                onPressed: () => _showsettingspanel(),
                tooltip: 'Increment',
                child: Icon(
                  Icons.add,
                  size: 35.0,
                ),
              ),
            ),
            InkWell(
              child: Icon(
                Icons.person_rounded,
                size: 35.0,
                color: Colors.green[500],
              ),
              onTap: ()  {
                Navigator.of(context)
                    .pushReplacement(MaterialPageRoute(builder: (_) => Profile()));
                // await _authserve.signOut();
                // Navigator.of(context).pushReplacement(
                //     MaterialPageRoute(builder: (_) => Login()));
              },
            ),
            InkWell(
              child: Icon(
                Icons.live_help_rounded,
                size: 35.0,
                color: Colors.green[500],
              ),
              onTap: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => About()));
              },
            ),
          ],
        ),
      );
    }

    final user = Provider.of<InternalUser>(context);
    return StreamProvider<List<Housemodel>>.value(
      value: DatabaseService().housedata,
      child: Scaffold(
        bottomNavigationBar: _navBar(context),
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(children: [
            Text('House Price Predictor', style: TextStyle(color: Colors.black,fontSize: 16.0)),
            Text(
              '!',
              style: TextStyle(color: Colors.green[500],fontSize: 16.0),
            )
          ]),
          backgroundColor: Colors.white,
          elevation: 0.0,
          actions: [
            Padding(
                padding: const EdgeInsets.only(top: 17.0, right: 15.0),
                child: Text('Demo V1.0.0',
                    style: TextStyle(
                      color: Colors.green[900],
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat',
                      fontSize: 20,
                    ))),
          ],
        ),
        body: Stack(children: <Widget>[
          Center(
            child: Text(
              '  This feature will be released on V1.0.1 on Feb 1 2021!!\n                   Thank you for checking the demo;)',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ]),
      ),
    );
  }
}
