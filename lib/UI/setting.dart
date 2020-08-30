import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gosee2/UI/SettingSubPage/reportBug.dart';
import 'package:gosee2/UI/SettingSubPage/version.dart';
import 'SettingSubPage/feedback.dart';
import 'SettingSubPage/aboutUs.dart';

class SettPage extends StatefulWidget {
  final String city;

  SettPage({Key key, @required this.city}) : super(key: key);

  @override
  _SettPageState createState() => _SettPageState(city);
}

class _SettPageState extends State<SettPage> {
  bool isSwitched = false;
  String city;

  _SettPageState(this.city);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Row(
              children: <Widget>[
                Expanded(child: Text('Current City')),
                Expanded(
                  child: Text(
                    '$city',
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
            onTap: () {},
          ),
          ListTile(
            title: Text('About Us'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => AboutUs(),
                ),
              );
            },
          ),
          ListTile(
              title: Row(
                children: <Widget>[
                  Expanded(child: Text('Version')),
                  Expanded(
                      child: Text(
                    '3.1.0',
                    textAlign: TextAlign.center,
                  )),
                ],
              ),
              onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Version(),
                    ),
                  )),
          ListTile(
            title: Text('App Feedback'),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => AddFeedback(),
              ),
            ),
          ),
          ListTile(
            title: Text('Report Bug'),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ReportBugs(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
