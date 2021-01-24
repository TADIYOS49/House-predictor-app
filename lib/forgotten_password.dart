import 'package:Signin/authserve.dart';
import 'package:Signin/shared/loading.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class Forgotten_password extends StatefulWidget {
  @override
  _Forgotten_passwordState createState() => _Forgotten_passwordState();
}

// ignore: camel_case_types
class _Forgotten_passwordState extends State<Forgotten_password> {
  final Authserve _authforget = Authserve();
  bool loading = false;
  final _formkey = GlobalKey<FormState>();
  String error = '';
  String confirmation = '';
  String email = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              iconTheme: IconThemeData(color: Colors.black),
            ),
            resizeToAvoidBottomPadding: false,
            body: Form(
                key: _formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      error,
                      style: TextStyle(color: Colors.red, fontSize: 14.0),
                    ),
                    Stack(children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(15.0, 190.0, 0.0, 0.0),
                        child: Text('Forgot Password',
                            style: TextStyle(
                                fontSize: 30.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Montserrat')),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(280.0, 190.0, 0.0, 0.0),
                        child: Text('?',
                            style: TextStyle(
                                color: Colors.green,
                                fontSize: 30.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Montserrat')),
                      ),
                    ]),
                    Container(
                        padding:
                            EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                        child: TextFormField(
                          validator: (val) =>
                              val.isEmpty ? 'Enter Email' : null,
                          onChanged: (val) {
                            setState(() {
                              email = val;
                            });
                          },
                          decoration: InputDecoration(
                              labelText: 'EMAIL',
                              labelStyle: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.green),
                              )),
                        )),
                    InkWell(
                        onTap: () async {
                          if (_formkey.currentState.validate()) {
                            setState(() {
                              loading = true;
                            });

                            if (await _authforget.forgetpassword(email) !=
                                null) {
                              print('email has been sent.');
                              setState(() {
                                confirmation = 'Link has been sent!';
                                loading = false;
                              });
                            } else {
                              setState(() {
                                error =
                                    'couldn\'t sent email.make sure to write the corrrect email.';
                                loading = false;
                              });
                              print(error);
                            }
                          }
                        },
                        child: Container(
                            padding: EdgeInsets.only(
                                top: 50.0, left: 20.0, right: 20.0),
                            child: Container(
                                height: 50.0,
                                width: 200,
                                child: Material(
                                    borderRadius: BorderRadius.circular(45),
                                    shadowColor: Colors.greenAccent,
                                    color: Colors.green,
                                    elevation: 10.0,
                                    child: GestureDetector(
                                        onTap: () {},
                                        child: Center(
                                          child: Text('Verify',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Montserrat',
                                                fontSize: 20,
                                              )),
                                        )))))),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      confirmation,
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                          fontSize: 16.0),
                    ),
                  ],
                )));
  }
}
