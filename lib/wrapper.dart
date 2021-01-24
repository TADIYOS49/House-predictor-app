import 'package:Signin/home.dart';
import 'package:Signin/login.dart';
import 'package:Signin/models/usermodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<InternalUser>(context);
    if (user == null) {
      return Login();
    } else {
      return Home();
    }
    // return either home or auth widget
    
  }
}
