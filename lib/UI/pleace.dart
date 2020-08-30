import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'reviews.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

// ignore: must_be_immutable
class Please extends StatefulWidget {
  final String pid;
  final String pAbout;
  final String pAdd;
  final String pContactNo;
  final String pDisc;
  final String pName;
  final String pPic;
  final String pCity;
  var pGMap;

  Please(
      {Key key,
      @required this.pid,
      this.pAbout,
      this.pAdd,
      this.pContactNo,
      this.pDisc,
      this.pName,
      this.pPic,
      this.pCity,
      this.pGMap})
      : super(key: key);

  @override
  _PleaseState createState() => _PleaseState(
      pid, pAbout, pAdd, pContactNo, pDisc, pName, pPic, pCity, pGMap);
}

class _PleaseState extends State<Please> {
  String pid;
  String pAbout;
  String pAdd;
  String pContactNo;
  String pDisc;
  String pName;
  String pPic;
  String pCity;
  var pGMap;

  _PleaseState(this.pid, this.pAbout, this.pAdd, this.pContactNo, this.pDisc,
      this.pName, this.pPic, this.pCity, this.pGMap);

  _call() async {
    if (await canLaunch('tel:$pContactNo')) {
      await launch('tel:$pContactNo');
    } else {
    throw 'Could not Call Because number not available';
  }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(pName),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Image.network(
                pPic,
              ),
              SizedBox(
                height: 10.0,
              ),
              Column(
                children: <Widget>[
                  Text(
                    'Description',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Divider(
                    color: Colors.black,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      pDisc.replaceAll("\\n", "\n "),
                      textAlign: TextAlign.justify,
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Divider(
                    color: Colors.black,
                  ),

                  Text(
                    'Place in Google Map',
                    style: TextStyle(
                        fontSize: 20,
                        decoration: TextDecoration.underline,
                        decorationThickness: 2,
                        decorationStyle: TextDecorationStyle.double),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 15,
                  ),

                  Container(
                    height: 220,
                    color: Colors.amber[600],
                    child: WebView(
                      initialUrl: Uri.dataFromString(
                              '<html><body>$pGMap</body></html>',
                              mimeType: 'text/html')
                          .toString(),
                      javascriptMode: JavascriptMode.unrestricted,
                    ),
                  ),

                  SizedBox(
                    height: 15.0,
                  ),

                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      pAdd,
                      textAlign: TextAlign.justify,
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
//                  SizedBox(height: 12.0,),
                  Divider(
                    color: Colors.black,
                  ),
                  pContactNo != 'Not Available'
                      ? FlatButton.icon(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0),
                            side: BorderSide(color: Colors.blue),
                          ),
                          padding: EdgeInsets.only(
                              left: 20.0, top: 10, right: 20.0, bottom: 10),
                          onPressed: _call,
                          icon: Icon(
                            Icons.call,
                            color: Colors.blue,
                          ),
                          textColor: Colors.blue,
                          label: Text(
                            'Click To Call',
                            style: TextStyle(fontSize: 20),
                          ),
                        )
                      : Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Phone Number: Not Available',
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.w600),
                          ),
                        ),

                  SizedBox(
                    height: 10.0,
                  ),
                  Divider(
                    color: Colors.black,
                  ),

                  FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                      side: BorderSide(color: Colors.blue),
                    ),
                    textColor: Colors.white,
                    color: Colors.blue,
                    padding: EdgeInsets.only(
                        left: 50.0, top: 10, right: 50.0, bottom: 10),
                    child: Text(
                      'Reviews',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                    onPressed: () =>
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Reviews(
                                  pid: pid,
                                  pName: pName,
                                ))),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Divider(
                    height: 10,
                    color: Colors.black,
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
