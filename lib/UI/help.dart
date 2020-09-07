import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:gosee2/main.dart';

//Welcome
class Help1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Welcome To GO SEE',
            style: Theme.of(context)
                .textTheme
                .headline4
                .copyWith(color: Colors.black),
          ),
          SizedBox(
            height: 20,
          ),
          Image.asset(
            'images/logo.png',
            scale: 3,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Pressed on the Next Button to Continue',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 100, right: 100),
            child: RaisedButton(
              color: Colors.blue,
              textColor: Colors.white,
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => Help2(),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Next',
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Icon(
                      Icons.arrow_forward,
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

//Change Current City
class Help2 extends StatefulWidget {
  @override
  _Help2State createState() => _Help2State();
}

class _Help2State extends State<Help2> {
  ScrollController _scrollController;
  bool _isOnTop = true;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  _scrollToTop() {
    _scrollController.animateTo(_scrollController.position.minScrollExtent,
        duration: Duration(milliseconds: 1000), curve: Curves.easeIn);
    setState(() => _isOnTop = true);
  }

  _scrollToBottom() {
    _scrollController.animateTo(_scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 1000), curve: Curves.easeOut);
    setState(() => _isOnTop = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text('User Guide'),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Padding(
          padding: const EdgeInsets.only(top: 15.0, bottom: 35.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Divider(
                height: 20,
                thickness: 3,
                color: Colors.black,
              ),
              Text(
                'Change Current City',
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    .copyWith(color: Colors.black),
              ),
              Divider(
                height: 20,
                thickness: 3,
                color: Colors.black,
              ),
              SizedBox(
                height: 20,
              ),
              Image.asset(
                'images/help/1.jpg',
                scale: 3,
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding:
                    const EdgeInsets.only(right: 12, bottom: 8.0, left: 12),
                child: Text(
                  '   By clicking this Location icon on App Bar(as above image) you get this dialog ',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              Divider(
                height: 20,
                thickness: 3,
                color: Colors.black,
              ),
              SizedBox(
                height: 20,
              ),
              Image.asset(
                'images/help/2.jpg',
                scale: 3,
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding:
                    const EdgeInsets.only(right: 12, bottom: 8.0, left: 12),
                child: Text(
                  '   After click on "YES" you can able to change the city',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              Divider(
                height: 20,
                thickness: 3,
                color: Colors.black,
              ),
              Text(
                'Get Help',
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    .copyWith(color: Colors.black),
              ),
              Divider(
                height: 20,
                thickness: 3,
                color: Colors.black,
              ),
              SizedBox(
                height: 20,
              ),
              Image.asset(
                'images/help/3.jpg',
                scale: 3,
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding:
                    const EdgeInsets.only(right: 12, bottom: 8.0, left: 12),
                child: Text(
                  '   Click on Help icon(shown in above image) any time for help.',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              Divider(
                height: 20,
                thickness: 3,
                color: Colors.black,
              ),
              Text(
                'Your Selected City',
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    .copyWith(color: Colors.black),
              ),
              Divider(
                height: 20,
                thickness: 3,
                color: Colors.black,
              ),
              SizedBox(
                height: 20,
              ),
              Image.asset(
                'images/help/4.jpg',
                scale: 3,
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding:
                    const EdgeInsets.only(right: 12, bottom: 8.0, left: 12),
                child: Text(
                  '   Here you can able to see your selected city',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              Divider(
                height: 20,
                thickness: 3,
                color: Colors.black,
              ),
              Text(
                'Bottom Bar',
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    .copyWith(color: Colors.black),
              ),
              Divider(
                height: 20,
                thickness: 3,
                color: Colors.black,
              ),
              SizedBox(
                height: 20,
              ),
              Image.asset(
                'images/help/5.jpg',
                scale: 3,
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding:
                    const EdgeInsets.only(right: 12, bottom: 8.0, left: 12),
                child: Text(
                  '   You can able to navigate via This Bottom Bar.',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              Divider(
                height: 20,
                thickness: 3,
                color: Colors.black,
              ),
              Text(
                'Category and Place Sliding',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    .copyWith(color: Colors.black),
              ),
              Divider(
                height: 20,
                thickness: 3,
                color: Colors.black,
              ),
              SizedBox(
                height: 20,
              ),
              Image.asset(
                'images/help/6.jpg',
                scale: 3,
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding:
                    const EdgeInsets.only(right: 12, bottom: 8.0, left: 12),
                child: Text(
                  '   Word written in Blue layer are the categories'
                  'and Below the category name some Places of that categories '
                  'After click on "See All" button you can see all the '
                  'places of that category available. ',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              Divider(
                height: 20,
                thickness: 3,
                color: Colors.black,
              ),
              Text(
                'Detail Page',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    .copyWith(color: Colors.black),
              ),
              Divider(
                color: Colors.black,
                thickness: 3,
              ),
              Padding(
                padding:
                    const EdgeInsets.only(right: 12, bottom: 8.0, left: 12),
                child: Text(
                  '   After click on any of the any Place you will come here '
                  'and see the detail of the place like images, Description, '
                  'Map, Contract number and also reviews by other users.\n\n'
                  'Below are more Details: ',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Image.asset(
                'images/help/7.jpg',
                scale: 3,
              ),
              Divider(
                height: 20,
                thickness: 3,
                color: Colors.black,
              ),
              Padding(
                padding:
                    const EdgeInsets.only(right: 12, bottom: 8.0, left: 12),
                child: Text(
                  '   An Google Map and Address of that Place for you:',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              Image.asset(
                'images/help/8.jpg',
                scale: 3,
              ),
              Divider(
                height: 20,
                thickness: 3,
                color: Colors.black,
              ),
              Padding(
                padding:
                    const EdgeInsets.only(right: 12, bottom: 8.0, left: 12),
                child: Text(
                  '   If place does not have Contact number then you can see this',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              Image.asset(
                'images/help/9.jpg',
                scale: 3,
              ),
              Divider(
                height: 20,
                thickness: 3,
                color: Colors.black,
              ),
              Padding(
                padding:
                    const EdgeInsets.only(right: 12, bottom: 8.0, left: 12),
                child: Text(
                  '   Else You will able to call directly by clicking on this "Click To Call" Button.',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              Image.asset(
                'images/help/10.jpg',
                scale: 3,
              ),
              Divider(
                height: 20,
                thickness: 3,
                color: Colors.black,
              ),
              Padding(
                padding:
                    const EdgeInsets.only(right: 12, bottom: 8.0, left: 12),
                child: Text(
                  '  You can able to see all review of that place by clicking on "Reviews" Button.',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              Image.asset(
                'images/help/11.jpg',
                scale: 3,
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding:
                    const EdgeInsets.only(right: 12, bottom: 8.0, left: 12),
                child: Text(
                  "  (note: you need to login with google account to see the "
                  "review but don't worry we only get your name, photo and "
                  "email-id )",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              Divider(
                height: 20,
                thickness: 3,
                color: Colors.black,
              ),
              Text(
                'Review and Feedback',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    .copyWith(color: Colors.black),
              ),
              Divider(
                height: 20,
                thickness: 3,
                color: Colors.black,
              ),
              Padding(
                padding:
                    const EdgeInsets.only(right: 12, bottom: 8.0, left: 12),
                child: Text(
                  '  After clicking on "Reviews" and/or "App Feedback" '
                  '("App Feedback" in setting page) you need to login with '
                  'google account only (but not so worry because we only need '
                  'your name, your photo and your email-Id) for that you '
                  'select any one of the present Email-id like below:',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              Image.asset(
                'images/help/12.jpg',
                scale: 3,
              ),
              Divider(
                height: 20,
                thickness: 3,
                color: Colors.black,
              ),
              Padding(
                padding:
                    const EdgeInsets.only(right: 12, bottom: 8.0, left: 12),
                child: Text(
                  '   After Login you will see all the reviews and/or feedback '
                  'by other users, you can able to see there full reviews '
                  'and/or feedback by clicking any user.',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Image.asset(
                'images/help/13.jpg',
                scale: 3,
              ),
              SizedBox(
                height: 20,
              ),
              Divider(
                height: 20,
                thickness: 3,
                color: Colors.black,
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding:
                    const EdgeInsets.only(right: 12, bottom: 8.0, left: 12),
                child: Text(
                  '   By clicking this Add button you can also upload your own reviews and/or feedback. ',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Image.asset(
                'images/help/14.jpg',
                scale: 3,
              ),
              SizedBox(
                height: 20,
              ),
              Divider(
                height: 20,
                thickness: 3,
                color: Colors.black,
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding:
                    const EdgeInsets.only(right: 12, bottom: 8.0, left: 12),
                child: Text(
                  '   This form is the feedback and/or review form you can tell '
                  'your Experience by this reaction icons (only one will be'
                  ' selected) and then you fill your view of the place and/or '
                  'app (feedback). ',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Image.asset(
                'images/help/15.jpg',
                scale: 3,
              ),
              Padding(
                padding:
                    const EdgeInsets.only(right: 12, bottom: 8.0, left: 12),
                child: Text(
                  '   As you submit your review you will able to see your review also.',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Divider(
                height: 20,
                thickness: 3,
                color: Colors.black,
              ),
              Text(
                'Profile',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    .copyWith(color: Colors.black),
              ),
              Divider(
                height: 20,
                thickness: 3,
                color: Colors.black,
              ),
              SizedBox(
                height: 20,
              ),
              Image.asset(
                'images/help/16.jpg',
                scale: 3,
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding:
                    const EdgeInsets.only(right: 12, bottom: 8.0, left: 12),
                child: Text(
                  '  In Profile page (from bottom bar) (also need to login but if '
                  'you already login not need to login again) you can see the '
                  'number of review given by you, your name, your photo(photo '
                  'of your google account), and your Email id',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Divider(
                height: 20,
                thickness: 3,
                color: Colors.black,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 100, right: 100),
                child: RaisedButton(
                  shape: StadiumBorder(
                    side: BorderSide(color: Colors.white),
                  ),
                  color: Colors.blue,
                  textColor: Colors.white,
                  onPressed: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    setState(() {
                      prefs.setBool('first_time', false);
                    });
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => MyApp(),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      'Finish',
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _isOnTop ? _scrollToBottom : _scrollToTop,
        child: Icon(_isOnTop ? Icons.arrow_downward : Icons.arrow_upward),
      ),
    );
  }
}
