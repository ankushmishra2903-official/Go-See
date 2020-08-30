import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'myReviews.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser _user;
  bool isLoading = true;

  String preRev = '';

  initState() {
    super.initState();
    handleSignIn();
  }

  GoogleSignIn _googleSignIn = new GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isSignIn
          ? (isLoading
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
          : SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 5.0),
                child: CircleAvatar(
                  radius: 100,
                  backgroundColor: Colors.transparent,
                  backgroundImage: NetworkImage(_user.photoUrl),
                ),
              ),
            ),
            ListTile(
              title: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      'Name : ',
                      style: Theme
                          .of(context)
                          .textTheme
                          .headline5,
                    ),
                  ),
                  Text(
                    _user.displayName,
                    style: Theme
                        .of(context)
                        .textTheme
                        .headline5,
                  )
                ],
              ),
            ),
            ListTile(
              title: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      'E-Mail : ',
                      style: Theme
                          .of(context)
                          .textTheme
                          .headline5,
                    ),
                  ),
                  Text(
                    _user.email,
                    style: Theme
                        .of(context)
                        .textTheme
                        .caption,
                  )
                ],
              ),
            ),
            StreamBuilder(
              stream: Firestore.instance
                  .collection('Reviews')
                  .where('user_email', isEqualTo: _user.email)
                  .snapshots(),
              builder: (context, snapshot) {
                int reviewLength = snapshot.data.documents.length;

                if (reviewLength < 10) {
                  preRev = "0";
                }

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

                return ListTile(
                  title: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          'My Reviews : ',
                          style:
                          Theme
                              .of(context)
                              .textTheme
                              .headline5,
                        ),
                      ),
                      Text(
                        preRev + reviewLength.toString(),
                        style: Theme
                            .of(context)
                            .textTheme
                            .headline5,
                      )
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyReviews(uName: _user.displayName, uEmail: _user.email,uPhoto: _user.photoUrl,),
                      ),
                    );
                  },
                );
              },
            ),
            RaisedButton(
              padding: EdgeInsets.only(
                  left: 20.0, right: 20.0, top: 10.0, bottom: 10.0),
              child: Text(
                'Sign Out',
                style: Theme
                    .of(context)
                    .textTheme
                    .headline6
                    .copyWith(color: Colors.white),
              ),
              color: Colors.red,
              onPressed: () {
                googleSignOut();
                setState(() {
                  isLoading = true;
                });
              },
            )
          ],
        ),
      ))
          : (isLoading
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
            onPressed: () => handleSignIn(),
          ),
        ),
      )),
    );
  }

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

  Future<void> googleSignOut() async {
    await _auth.signOut().then((onValue) {
      _googleSignIn.signOut();
      setState(() {
        isSignIn = false;
        isLoading = false;
      });
    });
  }
}
