import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gosee2/UI/help.dart';
import 'package:gosee2/selectCity.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './UI/category.dart';
import './UI/home.dart';
import './UI/profile.dart';
import './UI/setting.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String city = ' ';
  bool firstTime;

  @override
  void initState() {
    super.initState();
    startTime();
    _loadCity();
  }

  startTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      firstTime = (prefs.getBool('first_time') ?? true);
    });
  }

  _loadCity() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      city = (prefs.getString('city') ?? ' ');
    });
  }

  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),

        debugShowCheckedModeBanner: false,
        home: firstTime == false
            ? city == ' '
                ? SelectCity()
                : MyHomePage(
                    city: city,
                  )
            : Help1());
  }
}

class MyHomePage extends StatefulWidget {
  final String city;

  MyHomePage({Key key, @required this.city}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState(city);
}

class _MyHomePageState extends State<MyHomePage> {
  String city;

  _MyHomePageState(this.city);

  // This navigator state will be used to navigate different pages
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  int _currentTabIndex = 0;
  final databaseReference = Firestore.instance;
  Map data = new Map<String, dynamic>();

  myAlertBox(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Change City From $city',
              textAlign: TextAlign.center,
            ),
            content: Text('Are You Sure Want To Proceed ?'),
            actions: <Widget>[
              FlatButton(
                child: Text('YES'),
                onPressed: () async {
                  SharedPreferences pref =
                      await SharedPreferences.getInstance();

                  setState(() {
                    pref.setString('city', ' ');
                  });

                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => SelectCity(),
                    ),
                  );
                },
              ),
              FlatButton(
                child: Text('NO'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  DateTime backPressTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text(
            "GO SEE...!",
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.help_outline),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Help2(),
                  ),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.location_on),
              onPressed: () => myAlertBox(context),
            ),
          ]),
      body: WillPopScope(
        child: Navigator(key: _navigatorKey, onGenerateRoute: generateRoute),
        onWillPop: onWillPop,
      ),
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (backPressTime == null ||
        now.difference(backPressTime) > Duration(seconds: 2)) {
      backPressTime = now;
      Fluttertoast.showToast(
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.blue,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_LONG,
        msg: 'Tap again to exit',
      );
      return Future.value(false);
    }
    return Future.value(true);
  }

  Widget _bottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text("Home"),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.category),
          title: Text('Category'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          title: Text("Settings"),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle),
          title: Text("Profile"),
        ),
      ],
      onTap: _onTap,
      currentIndex: _currentTabIndex,
    );
  }

  _onTap(int tabIndex) {
    switch (tabIndex) {
      case 0:
        _navigatorKey.currentState.pushNamed("Home");
        break;
      case 1:
        _navigatorKey.currentState.pushNamed("Category");
        break;
      case 2:
        _navigatorKey.currentState.pushNamed("Settings");
        break;
      case 3:
        _navigatorKey.currentState.pushNamed("Profile");
        break;
    }
    setState(() {
      _currentTabIndex = tabIndex;
    });
  }

  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "Profile":
        return MaterialPageRoute(
          builder: (context) => ProfilePage(),
        );
      case "Category":
        return MaterialPageRoute(
          builder: (context) => CatPage(
            city: city,
          ),
        );
      case "Settings":
        return MaterialPageRoute(
          builder: (context) => SettPage(
            city: city,
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => HomePage(
            city: city,
          ),
        );
    }
  }
}
