import 'package:Signin/authserve.dart';
import 'package:Signin/forgotten_password.dart';
import 'package:Signin/models/usermodel.dart';
import 'package:Signin/route_generator.dart';
import 'package:Signin/updatenotifer.dart';
import 'package:Signin/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lit_firebase_auth/lit_firebase_auth.dart';
import 'package:provider/provider.dart';
import 'sign_up.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers:[ ChangeNotifierProvider(
      create:(context) =>Notifier(),
      )],
    child:MyApp()
      ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:  MyHomePage(),
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<InternalUser>.value(
        // the value we take from the Authserve class is the getter method called user.
        value: Authserve().user,
        child: MaterialApp(home: Wrapper()));
  }
}
