import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReviewByUser extends StatefulWidget {
  final String pName;
  final String rate;
  final String review;
  final String uName;
  final String uPhoto;
  final String uEmail;

  ReviewByUser(
      {Key key,
      this.pName,
      this.rate,
      this.review,
      this.uName,
      this.uPhoto,
      this.uEmail});

  @override
  _ReviewByUserState createState() => _ReviewByUserState();
}

class _ReviewByUserState extends State<ReviewByUser> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10.0,
                    bottom: 10.0,
                    left: 10.0,
                    right: 5.0,
                  ),
                  child: CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(widget.uPhoto),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 2.0, bottom: 5.0),
                        child: Text(
                          widget.uName,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 2.0),
                        child: Text(
                          widget.uEmail,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Divider(
              color: Colors.black,
              height: 10,
              thickness: 3,
            ),
            Text(
              '  My Point of View  ',
              style: TextStyle(
                  fontSize: 20.0,
                  decoration: TextDecoration.underline,
                  decorationStyle: TextDecorationStyle.wavy,
                  decorationThickness: 2,
                  decorationColor: Colors.red),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.grey,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Text(
                        widget.review,
                        style: Theme.of(context).textTheme.subtitle1,
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20,),
            FlatButton.icon(
              onPressed: () => Navigator.of(context).pop(),
              icon: Icon(Icons.keyboard_backspace),
              label: Text(
                'Back to Review List',
                style: Theme.of(context).textTheme.subtitle1.copyWith(color: Colors.white),
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
