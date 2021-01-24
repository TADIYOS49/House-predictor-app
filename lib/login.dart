import 'package:Signin/authserve.dart';
import 'package:Signin/forgotten_password.dart';
import 'package:Signin/home.dart';
import 'package:Signin/shared/loading.dart';
import 'package:Signin/sign_up.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final Authserve _authmain = Authserve();
  final _formkey = GlobalKey<FormState>();
  bool loading = false;
  String email = '';
  String password = '';
  String error = '';
  String name = '';
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
                      child: Text('Hello',
                          style: TextStyle(
                              fontSize: 80.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat')),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(15.0, 145.0, 0.0, 0.0),
                      child: Text('There',
                          style: TextStyle(
                              fontSize: 80.0, fontWeight: FontWeight.bold)),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(224.0, 145.0, 0.0, 0.0),
                      child: Text('.',
                          style: TextStyle(
                              fontSize: 80.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.green)),
                    ),
                  ],
                )),
                Container(
                    padding:
                        EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
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
                              decoration: InputDecoration(
                                  hintText: 'EMAIL',
                                  hintStyle: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.green),
                                  )),
                              onChanged: (val) {
                                setState(() {
                                  email = val;
                                  name = val;
                                });
                              },
                            ),
                            SizedBox(height: 20.0),
                            TextFormField(
                              validator: (val) => val.length < 6
                                  ? "password must be above 6"
                                  : null,
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
                              onChanged: (val) {
                                setState(() => password = val);
                              },
                            ),
                            SizedBox(height: 2.0),
                            Container(
                                alignment: Alignment(1.0, 0.0),
                                padding:
                                    EdgeInsets.only(top: 25.0, left: 180.0),
                                child: InkWell(
                                  child: Text('FORGOT PASSWORD',
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Montserrat',
                                        decoration: TextDecoration.underline,
                                        letterSpacing: 2,
                                      )),
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                Forgotten_password()));
                                  },
                                )),
                            SizedBox(height: 30.0),
                            InkWell(
                              child: Container(
                                  height: 50.0,
                                  width: 400,
                                  child: Material(
                                      borderRadius: BorderRadius.circular(45),
                                      shadowColor: Colors.greenAccent,
                                      color: Colors.green,
                                      elevation: 10.0,
                                      child: GestureDetector(
                                          onTap: () {},
                                          child: Center(
                                            child: Text('LOGIN',
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
                                  print('valid');
                                  dynamic result = await _authmain.login(
                                      name, email, password);
                                  if (result == null) {
                                    setState(() {
                                      error =
                                          'couldn\'t login.Make sure to insert the correct info!';
                                      loading = false;
                                    });
                                    print(error);
                                  } else {
                                    print('logged in.');
                                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>Home()));
                                    setState(() {
                                      loading = false;
                                    });
                                  }
                                }
                              },
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            //Log In Anonymous
                            InkWell(
                                onTap: () async {
                                  setState(() {
                                    loading = true;
                                  });
                                  dynamic result = await _authmain.anon();
                                  if (result == null) {
                                    setState(() {
                                      loading = false;
                                      error = 'error logging in.';
                                    });
                                    print('error signing in');
                                  } else {
                                    print('signed in');
                                    print(result.uid);
                                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>Home()));
                                  }
                                },
                                child: Container(
                                    height: 40.0,
                                    width: 300,
                                    color: Colors.transparent,
                                    child: Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Colors.black,
                                              style: BorderStyle.solid,
                                              width: 1.0,
                                            ),
                                            color: Colors.transparent,
                                            borderRadius:
                                                BorderRadius.circular(45)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            // Center(
                                            //   child: ImageIcon(
                                            //       AssetImage('assets/facebook.png')),
                                            // ),
                                            SizedBox(
                                              width: 10.0,
                                            ),
                                            Center(
                                                child: Text('Log In Anonymous',
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily: 'Montserrat',
                                                      fontSize: 15,
                                                    )))
                                          ],
                                        )))),
                            SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('New here? ',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Montserrat',
                                    )),
                                InkWell(
                                  child: Text('Register',
                                      style: TextStyle(
                                        color: Colors.green,
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.underline,
                                      )),
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                Sign_up()));
                                  },
                                )
                              ],
                            )
                          ],
                        ))),
              ],
            ));
  }
}
