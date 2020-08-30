import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'feedbackCards.dart';

class AddFeedback extends StatefulWidget {

  @override
  _AddFeedbackState createState() =>
      _AddFeedbackState();
}

class _AddFeedbackState extends State<AddFeedback> {

  /////////FireBase\\\\\\\\\\\\\
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser _user;
  bool isLoading = true;

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
              : FeedbackCards(uName: _user.displayName,uEmail: _user.email,uPhoto: _user.photoUrl,))
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
                      onPressed: () {
                        handleSignIn();
                        setState(() {
                          isLoading = true;
                        });
                      },
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
}
