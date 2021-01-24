import 'package:Signin/house_list.dart';
import 'package:Signin/house_tile.dart';
import 'package:Signin/newdataupdate.dart';
import 'package:Signin/settings_form.dart';
import 'package:Signin/updatenotifer.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:Signin/models/housemodel.dart';
import 'package:Signin/database.dart';

class HouseList extends StatefulWidget {
  Notifier get houseNotifier => null;

  @override
  _HouseListState createState() => _HouseListState();
}

class _HouseListState extends State<HouseList> {
  void initState() {
    Notifier houseNotifier = Provider.of<Notifier>(context, listen: false);
    DatabaseService().getHouse(houseNotifier);
    super.initState();
  }

  void _showsettingspanel() {
    showModalBottomSheet(
        //shape: BorderRadius.only(topLeft: 25.0,topRight: 25.0),
        context: context,
        builder: (context) {
          return Container(
            decoration: BoxDecoration(border:Border.all(color: Colors.green,width:2.0)),
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),            child: UpdateData(),
          );
        });
  }

  User user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    Notifier housenotifier = Provider.of<Notifier>(context);
    List<Housemodel> houselist = Provider.of<List<Housemodel>>(context) ?? [];
    List<Housemodel> houseList = housenotifier.houselist;

    return Stack(
      children: [
        ListView.builder(
          itemCount: housenotifier.houselist.length,
          itemBuilder: (context, index) {
            //return HouseTile(house: houseNotifier.houselist[index]);
            return Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Card(
                elevation: 12.0,
                color: Colors.green[100],
                margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
                child: ListTile(
                  leading: CircleAvatar(
                      radius: 25.0,
                      backgroundColor: Colors.lightGreen[
                          (int.parse(housenotifier.houselist[index].area) / 100)
                                  .round() +
                              100]),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          'Contributor: ${housenotifier.houselist[index].name}'),
                      // SizedBox(width: 12.0,),

                      if (user.uid == housenotifier.houselist[index].uid)
                        InkWell(
                            onTap: () => {
                                  housenotifier.currenthouse =
                                      housenotifier.houselist[index],
                                  _showsettingspanel()
                                },
                            child:
                                Icon(Icons.border_color, color: Colors.black87))
                    ],
                  ),
                  subtitle: Text(
                      'Area of the house: ${housenotifier.houselist[index].area} meter square \nBedrooms:${housenotifier.houselist[index].bedroom}\nLocation:${housenotifier.houselist[index].location}'),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
