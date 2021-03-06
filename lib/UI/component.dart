import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gosee2/UI/pleace.dart';

class ItemCard extends StatelessWidget {
  final String catName;
  final String city;

  ItemCard({Key key, @required this.catName, this.city}) : super(key: key);
  final db = Firestore.instance;

  Widget _buildListItem(BuildContext context, DocumentSnapshot document, ) {
    return ListTile(
      title: Card(
        child: InkWell(
          onTap: () {
            var pid = document['id'];
            var pAbout = document['about'];
            var pName = document['name'];
            var pCity = document['city'];
            var pDisc = document['disc'];
            var pAdd = document['address'];
            var pContactNo = document['contact_no'];
            var pPic = document['pic'];
            var pGMap = document['google_map'];

            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Please(
                        pid: pid,
                        pAbout: pAbout,
                        pAdd: pAdd,
                        pContactNo: pContactNo,
                        pDisc: pDisc,
                        pName: pName,
                        pPic: pPic,
                        pCity: pCity,
                        pGMap: pGMap,
                      )),
            );
          },
          child: Column(
            children: <Widget>[
              Center(
                child: Image.network(document['pic']),
              ),
              Center(
                child: Text(
                  document['name'],
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              Divider(
                color: Colors.black,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Center(
                  child: Text(document['about'],
                      textAlign: TextAlign.justify,
                      style: Theme.of(context).textTheme.subtitle2),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: StreamBuilder<QuerySnapshot>(
        stream: db
            .collection('$catName')
            .where('city', isEqualTo: city)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData)
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


          return Container(
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemExtent: 230.0,
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) => _buildListItem(
                      context,
                      snapshot.data.documents[index],
                    )),
          );
        },
      ),
    );
  }
}
