import 'package:Signin/authserve.dart';
import 'package:Signin/home.dart';
import 'package:Signin/login.dart';
import 'package:Signin/models/usermodel.dart';
import 'package:Signin/shared/loading.dart';
import 'package:Signin/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: camel_case_types
class Sign_up extends StatefulWidget {
  @override
  _Sign_upState createState() => _Sign_upState();
}

class _Sign_upState extends State<Sign_up> {
  final Authserve _authsignin = Authserve();
  final _formkey = GlobalKey<FormState>();
  bool loading = false;
  String name = '';

  String email = '';

  String password = '';

  String confirmpassword = '';

  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            resizeToAvoidBottomPadding: false,
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    child: Stack(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(15.0, 70.0, 0.0, 0.0),
                      child: Text('SignUp',
                          style: TextStyle(
                              fontSize: 50.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat')),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(205.0, 70.0, 0.0, 0.0),
                      child: Text('.',
                          style: TextStyle(
                              color: Colors.green,
                              fontSize: 50.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat')),
                    ),
                  ],
                )),
                Container(
                    padding:
                        EdgeInsets.only(top: 25.0, left: 20.0, right: 20.0),
                    child: Form(
                        key: _formkey,
                        child: Column(
                          children: [
                            Text(
                              error,
                              style:
                                  TextStyle(color: Colors.red, fontSize: 14.0),
                            ),
                            TextFormField(
                              validator: (val) =>
                                  val.isEmpty ? 'Enter Name' : null,
                              onChanged: (val) {
                                setState(() => name = val);
                              },
                              decoration: InputDecoration(
                                  hintText: 'NAME',
                                  hintStyle: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.green),
                                  )),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            TextFormField(
                              validator: (val) {
                                if (val.isEmpty) {
                                  return "Enter an email";
                                } else {
                                  if (val.contains('@')) {
                                    email = val;
                                    return null;
                                  } else {
                                    return "Make sure to write an email!";
                                  }
                                }
                              }, 
                              onChanged: (val) {
                                setState(() => email = val);
                              },
                              decoration: InputDecoration(
                                  hintText: 'EMAIL',
                                  hintStyle: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.green),
                                  )),
                            ),
                            SizedBox(height: 20.0),
                            TextFormField(
                              validator: (val) =>
                                  val.length < 6 ? 'Password too short' : null,
                              onChanged: (val) {
                                setState(() => password = val);
                              },
                              decoration: InputDecoration(
                                  hintText: 'PASSWORD',
                                  hintStyle: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.green),
                                  )),
                              obscureText: true,
                            ),
                            SizedBox(height: 20.0),
                            TextFormField(
                              validator: (val) => val.toString() == password
                                  ? null
                                  : 'Password don\'t match',
                              onChanged: (val) {
                                setState(() => confirmpassword = val);
                              },
                              decoration: InputDecoration(
                                  hintText: 'CONFIRM PASSWORD',
                                  hintStyle: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.green),
                                  )),
                              obscureText: true,
                            ),
                            SizedBox(height: 30.0),
                            InkWell(
                              child: Container(
                                  height: 45.0,
                                  width: 400,
                                  child: Material(
                                      borderRadius: BorderRadius.circular(45),
                                      shadowColor: Colors.greenAccent,
                                      color: Colors.green,
                                      elevation: 10.0,
                                      child: GestureDetector(
                                          onTap: () {},
                                          child: Center(
                                            child: Text('SIGNUP',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'Montserrat',
                                                  fontSize: 20,
                                                )),
                                          )))),
                              onTap: () async {
                                if (_formkey.currentState.validate()) {
                                  setState(() {
                                    loading = true;
                                  });
                                  dynamic result = await _authsignin.register(
                                      name, email, password, confirmpassword);
                                  if (result == null) {
                                    setState(() {
                                      error = 'couldn\'t register.';
                                      loading = false;
                                    });
                                    print(error);
                                  } else {
                                    setState(() {
                                      loading = false;
                                    });
                                    print('registered');
                                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>Home()));
                                  }
                                }
                              },
                            ),
                            SizedBox(
                              height: 14.0,
                            ),
                            Container(
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                ),
                                height: 35.0,
                                width: 300,
                                child: Material(
                                    borderRadius: BorderRadius.circular(45),
                                    elevation: 10.0,
                                    child: GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder:
                                                      (BuildContext context) =>
                                                          Login()));
                                        },
                                        child: Center(
                                          child: Text('Go Back',
                                              style: TextStyle(
                                                //color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Montserrat',
                                                fontSize: 20,
                                              )),
                                        )))),
                          ],
                        ))),
              ],
            ));
  }
}
