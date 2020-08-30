import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class ReportBugs extends StatefulWidget {
  @override
  _ReportBugsState createState() => _ReportBugsState();
}

class _ReportBugsState extends State<ReportBugs> {
  /////////FireBase\\\\\\\\\\\\\
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser _user;
  bool isLoading = true;

  initState() {
    super.initState();
    handleSignIn();
  }

  GoogleSignIn _googleSignIn = new GoogleSignIn();

  //For Bug Reporting
  GlobalKey<FormState> _key = GlobalKey();
  bool _validate = false;
  String _bug;
  String time = DateFormat('jm').format(DateTime.now());
  String date = DateFormat('yMd').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isSignIn
          ? isLoading
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SpinKitThreeBounce(
                      size: 20,
                      color: Colors.blue,
                    ),
                    Text('Loading....'),
                  ],
                )
              : Scaffold(
                  appBar: AppBar(
                    centerTitle: true,
                    title: Text('Bug Reporting'),
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
                )
          : isLoading
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SpinKitThreeBounce(
                      size: 20,
                      color: Colors.blue,
                    ),
                    Text('Loading....'),
                  ],
                )
              : Center(
                  child: Container(
                    height: 40,
                    child: SignInButton(
                      Buttons.GoogleDark,
                      onPressed: () {
                        handleSignIn();
                        setState(() {
                          isLoading = true;
                        });
                      },
                    ),
                  ),
                ),
    );
  }

  Widget formUI() {
    return new Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        new TextFormField(
          maxLines: 3,
          keyboardType: TextInputType.multiline,
          decoration: new InputDecoration(
            hintText: 'What Bug you got in our app',
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
              borderSide: BorderSide(color: Colors.black),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
              borderSide: BorderSide(
                color: Colors.blue,
                width: 3,
              ),
            ),
          ),
          onSaved: (String val) {
            _bug = val;
          },
        ),
        new SizedBox(height: 15.0),
        new RaisedButton(
          onPressed: () {
            _sendToServer();
            mail();
          },
          child: new Text('Submit'),
        )
      ],
    );
  }

  mail() async {
    String username = 'goseeteam@gmail.com';
    String password = 'GoSee6789';

    final smtpServer = gmail(username, password);

    final message = Message()
      ..from = Address(username)
      ..recipients.add(_user.email)
      ..subject = 'You are Reporting a bug on $date $time'
      ..text = 'Dear ' +
          _user.displayName +
          ', \n \n      You Report of some bug you get is very helpful '
              'and our team will start work to fix that bug.\n \n                                  '
              'Thank You ' +
          _user.displayName +
          ' for giving your valuable time with us \n\nRegard: Go See..!';

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
    } on MailerException catch (e) {
      print('Message not sent. \n' + e.toString());
    }
  }

  _sendToServer() {
    if (_key.currentState.validate()) {
      //No error in validator
      _key.currentState.save();
      Firestore.instance.runTransaction((Transaction transaction) async {
        CollectionReference reference = Firestore.instance.collection('Bugs');

        await reference.document(_user.email).setData({
          "bugs": "$_bug",
          "user_email": _user.email,
          "user_name": _user.displayName,
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

//for login
  bool isSignIn = false;

  Future<void> handleSignIn() async {
    GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    AuthCredential credential = GoogleAuthProvider.getCredential(
      idToken: googleSignInAuthentication.idToken,
      accessToken: googleSignInAuthentication.accessToken,
    );

    AuthResult result = (await _auth.signInWithCredential(credential));

    _user = result.user;

    setState(() {
      isSignIn = true;
      isLoading = false;
    });
  }
}
