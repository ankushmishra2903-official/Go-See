import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import './category_items.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CatPage extends StatefulWidget {
  final String city;

  CatPage({Key key, @required this.city}) : super(key: key);

  @override
  _CatPageState createState() => _CatPageState(city);
}

class _CatPageState extends State<CatPage> {
  String city;

  _CatPageState(this.city);

  @override
  Widget build(BuildContext context) {
    final db = Firestore.instance;

    return Scaffold(
      body: StreamBuilder(
        stream: db.collection("city").document('$city').snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if(city == null) return Center(child: Text('SELECT CITY AND TAP AGAIN'),);
          if (snapshot.hasData){
            Map<String, dynamic> documentFields = snapshot.data.data;
            if(documentFields.length <= 0) return Center(child: Text('NO DATA'),);
            return Container(
              child: ListView(padding: EdgeInsets.zero, children: <Widget>[

                for(int i = 1; i<documentFields.length+1 ; i++) ...[

                  ListTile(
                    title: Text(documentFields['$i']),
                    onTap: () {

                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => new CategoryItems(
                          catName: documentFields['$i'], city: city,)
                      ));
                    },
                  ),
                ]

              ]),
            );
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SpinKitThreeBounce(
                size: 20,
                color: Colors.blue,
              ),
              Text('Loading....'),
            ],
          );
        },
      ),
    );
  }
}
