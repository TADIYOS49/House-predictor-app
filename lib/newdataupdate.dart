import 'package:Signin/database.dart';
import 'package:Signin/home.dart';
import 'package:Signin/models/usermodel.dart';
import 'package:Signin/shared/constants.dart';
import 'package:Signin/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewData extends StatefulWidget {
  @override
  _NewDataState createState() => _NewDataState();
}

class _NewDataState extends State<NewData> {
  final _formkey = GlobalKey<FormState>();
  final List<String> bedrooms = ['0', '1', '2', '3', '4'];
  String _currentName;
  String _currentBedroom;
  String _currentArea;
  String _currentLocation;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<InternalUser>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        // ignore: missing_return
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
            return Form(
              key: _formkey,
              child: ListView(
                children: [
                  Column(children: [
                    Text(
                      'Update your House Data.',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      initialValue: userData.name,
                      decoration:
                          textInputDecoration.copyWith(labelText: 'Name'),
                      validator: (val) =>
                          val.isEmpty ? 'Please enter a name' : null,
                      onChanged: (val) => setState(() => _currentName = val),
                    ),
                    SizedBox(height: 10.0),
                    DropdownButtonFormField(
                      value: _currentBedroom,
                      decoration:
                          textInputDecoration.copyWith(labelText: 'Bedrooms'),
                      items: bedrooms.map((bedroom) {
                        return DropdownMenuItem(
                          value: bedroom,
                          child: Text(bedroom),
                        );
                      }).toList(),
                      onChanged: (val) => setState(() => _currentBedroom = val),
                    ),
                    SizedBox(height: 10.0),
                    TextFormField(
                      initialValue: _currentArea,
                      keyboardType: TextInputType.number,
                      decoration:
                          textInputDecoration.copyWith(labelText: 'Area'),
                      validator: (val) =>
                          val.isEmpty ? 'Please enter the Area' : null,
                      onChanged: (val) => setState(() => _currentArea = val),
                    ),
                    SizedBox(height: 10.0),
                    TextFormField(
                      initialValue: _currentLocation,
                      decoration:
                          textInputDecoration.copyWith(labelText: 'Location'),
                      validator: (val) =>
                          val.isEmpty ? 'Please enter the Location' : null,
                      onChanged: (val) =>
                          setState(() => _currentLocation = val),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    RaisedButton(
                        color: Colors.green[500],
                        child: Text(
                          'Update',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          if (_formkey.currentState.validate()) {
                            await DatabaseService(uid: user.uid).addhouseData(
                                _currentName ?? userData.name,
                                _currentArea ?? 'null',
                                _currentBedroom ?? 'null',
                                _currentLocation ?? 'null');
                            Navigator.pop(context);
                           Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>Home()));
                          }
                        }),
                  ])
                ],
              ),
            );
          } else {
            return Text(
              'you can\'t update your data in anonymous mode.Please create an account and try again.',
            );
          }
        });
  }
}
