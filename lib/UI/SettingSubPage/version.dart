import 'package:flutter/material.dart';

class Version extends StatelessWidget {
  String vers = 'Version 3.1.0';

  var updateHead = RichText(
    textAlign: TextAlign.center,
    text: TextSpan(
      text: 'UPDATES ON THIS VERSION',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
        color: Colors.black,
      ),
    ),
  );

  var versDetail = Column(
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 5),
        child: Row(
          children: <Widget>[
            Text(
              '*   ',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            Expanded(
              child: Text(
                'New Version Page.',
                style: TextStyle(
                  fontSize: 18,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 5),
        child: Row(
          children: <Widget>[
            Text(
              '*   ',

              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            Expanded(
              child: Text(
                'User Guide available on Top Bar.',
                style: TextStyle(
                  fontSize: 18,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 5),
        child: Row(
          children: <Widget>[
            Text(
              '*   ',

              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            Expanded(
              child: Text(
                'Exit by pressing the back button twice.',
                style: TextStyle(
                  fontSize: 18,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 5),
        child: Row(
          children: <Widget>[
            Text(
              '*   ',

              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            Expanded(
              child: Text(
                'Add "See All" button on Home Page to see all Stores of that category',
                style: TextStyle(
                  fontSize: 18,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 5),
        child: Row(
          children: <Widget>[
            Text(
              '*   ',

              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            Expanded(
              child: Text(
                'Able to see your reviews by clicking on "Profile > My Reviews"',
                style: TextStyle(
                  fontSize: 18,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 5),
        child: Row(
          children: <Widget>[
            Text(
              '*   ',

              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            Expanded(
              child: Text(
                'Report Bug(Need to Login first).',
                style: TextStyle(
                  fontSize: 18,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
          ],
        ),
      ),

    ],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Column(
          children: <Widget>[
            Text(
              vers,
              style: TextStyle(
                  fontSize: 35.0,
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                  decorationStyle: TextDecorationStyle.wavy,
                  decorationThickness: 1,
                  decorationColor: Colors.black),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.grey,
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  children: <Widget>[
                    updateHead,
                    SizedBox(
                      height: 7,
                    ),
                    versDetail,
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            FlatButton.icon(
              onPressed: () => Navigator.of(context).pop(),
              icon: Icon(Icons.keyboard_backspace),
              label: Text(
                'Back to Setting',
                style: Theme.of(context)
                    .textTheme
                    .subtitle1
                    .copyWith(color: Colors.white),
              ),
              padding: EdgeInsets.all(10),
              color: Colors.red,
              textColor: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
