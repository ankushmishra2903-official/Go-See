import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gosee2/UI/category_items.dart';
import 'package:gosee2/UI/component.dart';
import 'package:gosee2/selectCity.dart';

class HomePage extends StatefulWidget {
  final String city;

  HomePage({Key key, @required this.city}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState(city);
}

class _HomePageState extends State<HomePage> {
  String city;
  var db = Firestore.instance;

  _HomePageState(this.city);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: db.collection('city').document('$city').snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            if (city == null) return SelectCity();
            Map<String, dynamic> documentFields = snapshot.data.data;
            if (documentFields.length <= 0)
              return Center(
                child: Text('Sorry We are Not have any data of $city'),
              );

            return SingleChildScrollView(
              child: Container(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 12.0,
                    ),
                    Center(
                      child: Text(
                        'You are Exploring $city',
                        style: Theme.of(context)
                            .textTheme
                            .headline5
                            .copyWith(color: Colors.blue),
                      ),
                    ),
                    for (int i = 1; i < documentFields.length + 1; i++) ...[
                      SizedBox(
                        height: 20.0,
                      ),
                      Container(
                        height: 50,
                        color: Colors.blue,
                        child: Center(
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 50.0),
                                  child: Text(
                                    documentFields['$i'],
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline5
                                        .copyWith(color: Colors.white),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              MaterialButton(
                                shape: StadiumBorder(
                                    side: BorderSide(color: Colors.white)),
                                textColor: Colors.white,
                                color: Colors.blue,
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => CategoryItems(
                                        catName: documentFields['$i'],
                                        city: city,
                                      ),
                                    ),
                                  );
                                },
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      'See All',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Icon(
                                        Icons.arrow_forward,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 230.0,
                        color: Colors.blueGrey,
                        child: ItemCard(
                          city: city,
                          catName: documentFields['$i'],
                        ),
                      ),
                    ],
                    SizedBox(
                      height: 13,
                    ),
                  ],
                ),
              ),
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
