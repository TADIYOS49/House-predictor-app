import 'package:Signin/newdataupdate.dart';
import 'package:Signin/settings_form.dart';
import 'package:Signin/updatenotifer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:Signin/models/housemodel.dart';
import 'package:provider/provider.dart';

class HouseTile extends StatelessWidget {
  final Housemodel house;
  HouseTile({this.house});
  User user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    Notifier housenotifier = Provider.of<Notifier>(context, listen: false);
    var name = house.name;
    var area = house.area;
    var bedroom = house.bedroom;
    var location = house.location;
    void _showsettingspanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child:NewData(),
            );
          });
    }

    return Padding(
      padding: EdgeInsets.only(top: 10.0),
      child: Card(
        elevation: 12.0,
        color: Colors.green[100],
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
              radius: 25.0,
              backgroundColor: Colors
                  .lightGreen[(int.parse(house.area) / 100).round() + 100]),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Contributor: ${house.name}'),
              // SizedBox(width: 12.0,),
            
              if (user.uid == house.uid)
                InkWell(
                    onTap: () =>{
                      _showsettingspanel()
                    } ,
                    child: Icon(Icons.border_color, color: Colors.black87))
            ],
          ),
          subtitle: Text(
              'Area of the house: ${house.area} meter square \nBedrooms:${house.bedroom}\nLocation:${house.location}'),
        ),
      ),
    );
  }
}
