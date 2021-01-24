import 'package:Signin/home.dart';
import 'package:Signin/house_list.dart';
import 'package:Signin/models/housemodel.dart';
import 'package:Signin/shared/constants.dart';
import 'package:Signin/updatenotifer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Signin/database.dart';

class UpdateData extends StatefulWidget {
  @override
  _UpdateDataState createState() => _UpdateDataState();
}

class _UpdateDataState extends State<UpdateData> {
  final _formkey = GlobalKey<FormState>();
  final List<String> bedrooms = ['0', '1', '2', '3', '4'];
  String _currentName;
  String _currentBedroom;
  String _currentArea;
  String _currentLocation;
  @override
  Widget build(BuildContext context) {
    Notifier housenotifier = Provider.of<Notifier>(context, listen: false);
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
              initialValue: housenotifier.currenthouse.name,
              decoration: textInputDecoration.copyWith(labelText: 'Name'),
              validator: (val) => val.isEmpty ? 'Please enter a name' : null,
              onChanged: (val) => setState(() => _currentName = val),
            ),
            SizedBox(height: 10.0),
            DropdownButtonFormField(
              value: housenotifier.currenthouse.bedroom,
              decoration: textInputDecoration.copyWith(labelText: 'Bedrooms'),
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
              initialValue: housenotifier.currenthouse.area,
              keyboardType: TextInputType.number,
              decoration: textInputDecoration.copyWith(labelText: 'Area'),
              validator: (val) => val.isEmpty ? 'Please enter the Area' : null,
              onChanged: (val) => setState(() => _currentArea = val),
            ),
            SizedBox(height: 10.0),
            TextFormField(
              initialValue: housenotifier.currenthouse.location,
              decoration: textInputDecoration.copyWith(labelText: 'Location'),
              validator: (val) =>
                  val.isEmpty ? 'Please enter the Location' : null,
              onChanged: (val) => setState(() => _currentLocation = val),
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
                    await DatabaseService().updateHouseData(
                        _currentName ?? housenotifier.currenthouse.name,
                        _currentArea ?? housenotifier.currenthouse.area,
                        _currentBedroom ?? housenotifier.currenthouse.bedroom,
                        _currentLocation ?? housenotifier.currenthouse.location,
                        housenotifier.currenthouse.id);
                      Navigator.pop(context);
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>Home()));
                  }
                }),
          ])
        ],
      ),
    );
  }
}
