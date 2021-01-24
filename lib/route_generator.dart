import 'package:Signin/forgotten_password.dart';
import 'package:Signin/home.dart';
import 'package:Signin/sign_up.dart';
import 'package:flutter/material.dart';
import './main.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => MyHomePage());
      case '/signin':
        return MaterialPageRoute(builder: (_) => Sign_up());
      case '/forgotten_password':
        return MaterialPageRoute(builder: (_) => Forgotten_password());
      case '/home':
        return MaterialPageRoute(builder: (_) => Home());
      default:
        return _errorRoute();
    }
  }

  static  Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
