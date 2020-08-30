import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:intl/intl.dart';

class AddReview extends StatefulWidget {
  final String pid;
  final String pName;
  final String uName;
  final String uEmail;
  final String uPhoto;

  AddReview(
      {Key key, this.pid, this.pName, this.uName, this.uEmail, this.uPhoto})
      : super(key: key);

  @override
  _AddReviewState createState() =>
      _AddReviewState(pid, pName, uName, uEmail, uPhoto);
}

class _AddReviewState extends State<AddReview> {
  GlobalKey<FormState> _key = GlobalKey();
  bool _validate = false;
  String _review;
  String _rate = '';
  String time = DateFormat('jm').format(DateTime.now());
  String date = DateFormat('yMd').format(DateTime.now());


  Color _iconVDis = Colors.black;
  Color _iconDis = Colors.black;
  Color _iconNeu = Colors.black;
  Color _iconSat = Colors.black;
  Color _iconVSat = Colors.black;

  final String pid;
  final String pName;
  final String uName;
  final String uEmail;
  final String uPhoto;

  _AddReviewState(this.pid, this.pName, this.uName, this.uEmail, this.uPhoto);

  mail() async {
    String username = 'goseeteam@gmail.com';
    String password = 'GoSee6789';

    final smtpServer = gmail(username, password);

    final message = Message()
      ..from = Address(username)
      ..recipients.add(uEmail)
      ..subject = '$uName your review of $pName is successfully submitted on $date $time.'
      ..text = 'Dear $uName, \n \n      Your review of $pName is very valuable '
          'for our other users.\n \n                        '
          'Thank You $uName \n\nRegard: Go See..!';

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
    } on MailerException catch (e) {
      print('Message not sent. \n' + e.toString());
    }
  }

  helpAlert(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('RATING SYMBOLS',textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold),),
            content: Container(
              height: 330,
              child: Column(
                children: <Widget>[
                  Text(
                    '    Every type of symbols you seen here are different meaning. The meaning of all symbols are as Follow:-\n',
                    textAlign: TextAlign.justify,
                  ),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.sentiment_very_dissatisfied,
                        color: Colors.red,
                        size: 30,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(Icons.arrow_forward,color: Colors.blue,),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Text(
                          'Very Dissatisfied',
                          style: TextStyle(color: Colors.red,fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.sentiment_dissatisfied,
                        color: Colors.redAccent,
                        size: 30,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(Icons.arrow_forward,color: Colors.blue,),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Text(
                          'Dissatisfied',
                          style: TextStyle(color: Colors.redAccent,fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.sentiment_neutral,
                        color: Colors.deepOrange,
                        size: 30,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(Icons.arrow_forward,color: Colors.blue,),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Text(
                          'Ok Ok',
                          style: TextStyle(color: Colors.deepOrange,fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.sentiment_satisfied,
                        color: Colors.greenAccent,
                        size: 30,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(Icons.arrow_forward,color: Colors.blue,),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Text(
                          'Satisfied',
                          style: TextStyle(color: Colors.greenAccent,fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.sentiment_very_satisfied,
                        color: Colors.green,
                        size: 30,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(Icons.arrow_forward,color: Colors.blue,),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Text(
                          'Very Satisfied',
                          style: TextStyle(color: Colors.green,fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),

                ],
              ),
            ),
            actions: <Widget>[
              FlatButton.icon(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.thumb_up),
                label: Text(' OK  ',style: TextStyle(fontSize: 20),),
              )
            ],
          );
        });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(widget.pName),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () {
              helpAlert(context);
            },
          ),
        ],
      ),
      body: new SingleChildScrollView(
        child: new Container(
          margin: new EdgeInsets.all(15.0),
          child: new Form(
            key: _key,
            autovalidate: _validate,
            child: formUI(),
          ),
        ),
      ),
    );
  }

  Widget formUI() {
    return new Column(
      children: <Widget>[
        Center(
          child: Text(
            'Express your Experience',
            style: TextStyle(fontSize: 20),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.sentiment_very_dissatisfied,
                color: _iconVDis,
              ),
              onPressed: () {
                setState(() {
                  _iconVDis = Colors.red;
                  _iconDis = Colors.black;
                  _iconNeu = Colors.black;
                  _iconSat = Colors.black;
                  _iconVSat = Colors.black;
                  _rate = "v_dis";
                });
              },
            ),
            IconButton(
              icon: Icon(
                Icons.sentiment_dissatisfied,
                color: _iconDis,
              ),
              onPressed: () {
                setState(() {
                  _iconVDis = Colors.black;
                  _iconDis = Colors.redAccent;
                  _iconNeu = Colors.black;
                  _iconSat = Colors.black;
                  _iconVSat = Colors.black;
                  _rate = "dis";
                });
              },
            ),
            IconButton(
              icon: Icon(
                Icons.sentiment_neutral,
                color: _iconNeu,
              ),
              onPressed: () {
                setState(() {
                  _iconVDis = Colors.black;
                  _iconDis = Colors.black;
                  _iconNeu = Colors.deepOrange;
                  _iconSat = Colors.black;
                  _iconVSat = Colors.black;
                  _rate = "neu";
                });
              },
            ),
            IconButton(
              icon: Icon(
                Icons.sentiment_satisfied,
                color: _iconSat,
              ),
              onPressed: () {
                setState(() {
                  _iconVDis = Colors.black;
                  _iconDis = Colors.black;
                  _iconNeu = Colors.black;
                  _iconSat = Colors.greenAccent;
                  _iconVSat = Colors.black;
                  _rate = "sat";
                });
              },
            ),
            IconButton(
              icon: Icon(
                Icons.sentiment_very_satisfied,
                color: _iconVSat,
              ),
              onPressed: () {
                setState(() {
                  _iconVDis = Colors.black;
                  _iconDis = Colors.black;
                  _iconNeu = Colors.black;
                  _iconSat = Colors.black;
                  _iconVSat = Colors.green;
                  _rate = "v_sat";
                });
              },
            ),
          ],
        ),
        new TextFormField(
          maxLines: 3,
          keyboardType: TextInputType.multiline,
          decoration: new InputDecoration(hintText: 'Your Review of $pName'),
          onSaved: (String val) {
            _review = val;
          },
        ),
        new SizedBox(height: 15.0),
        new RaisedButton(
          onPressed: () async {
            mail();
            _sendToServer();
          },
          child: new Text('Submit'),
        )
      ],
    );
  }

  _sendToServer() {
    if (_key.currentState.validate()) {
      //No error in validator
      _key.currentState.save();
      Firestore.instance.runTransaction((Transaction transaction) async {
        CollectionReference reference =
            Firestore.instance.collection('Reviews');

        await reference.document('$pid' + '_' + '$uEmail').setData({
          "review": "$_review",
          "user_email": "$uEmail",
          "pid": "$pid",
          "pName": "$pName",
          "user_name": "$uName",
          "user_photo": "$uPhoto",
          "rate": "$_rate",
          "time": "$time",
          "date": "$date",
        });
      });
    } else {
      // validation error
      setState(() {
        _validate = true;
      });
    }
    Navigator.pop(context);
  }
}
