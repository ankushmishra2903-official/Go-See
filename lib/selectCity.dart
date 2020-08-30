import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SelectCity extends StatefulWidget {
  @override
  _SelectCityState createState() => _SelectCityState();
}

class _SelectCityState extends State<SelectCity> {
  var myCity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Text(
              'Welcome To GO SEE',
              style: Theme.of(context)
                  .textTheme
                  .headline4
                  .copyWith(color: Colors.black),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance.collection('city').snapshots(),
            builder: (context, snapshot) {
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

              List<DropdownMenuItem> city = [];
              for (int i = 0; i < snapshot.data.documents.length; i++) {
                DocumentSnapshot cityList = snapshot.data.documents[i];
                city.add(DropdownMenuItem(
                  child: Text(
                    cityList.documentID,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  value: cityList.documentID,
                ));
              }
              return DropdownButton(
                underline: Container(
                  height: 2,
                  color: Colors.black,
                ),
                icon: Icon(
                  Icons.location_on,
                ),
                items: city,
                value: myCity,
                hint: Text(
                  '  Select Your City  ',
                  style: Theme.of(context).textTheme.headline5,
                ),
                onChanged: (cityName) async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();

                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => MyHomePage(
                        city: cityName,
                      ),
                    ),
                  );

                  setState(() {
                    myCity = cityName;
                    prefs.setString('city', myCity);
                  });
                },
              );
            },
          )
        ],
      ),
    );
  }
}
