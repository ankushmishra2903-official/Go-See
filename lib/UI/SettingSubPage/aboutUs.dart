import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AboutUs extends StatelessWidget {

  String about = '     Hello Everybody, '
      'We are presenting you one of the best Travel and Tourism app. '
      'Whenever wherever you go then you will see the best thing  \n\n'
      '     Travel and Tourism have been important social activities of human '
      'beings form time immemorial. \n\n'
      '     We provide you best place to visit of that city and made your '
      'awesome memories to share with friends, families and all your well '
      'wishers.';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Column(
          children: <Widget>[
            Text(
              '  About Go See...!  ',
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
                child: Text(
                  about,
                  style: Theme.of(context).textTheme.subtitle1,
                  textAlign: TextAlign.justify,
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
