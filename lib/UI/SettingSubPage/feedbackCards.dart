import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'feedbackByUser.dart';
import 'addFeedback.dart';

class FeedbackCards extends StatefulWidget {
  final String uName;
  final String uEmail;
  final String uPhoto;

  FeedbackCards({Key key, this.uName, this.uEmail, this.uPhoto})
      : super(key: key);

  @override
  _FeedbackCardsState createState() => _FeedbackCardsState();
}

class _FeedbackCardsState extends State<FeedbackCards> {
  @override
  Widget build(BuildContext context) {
    Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
      Icon rateIcon;

      if (document['rate'] == 'v_sat') {
        rateIcon = Icon(
          Icons.sentiment_very_satisfied,
          color: Colors.green,
          size: 35,
        );
      } else if (document['rate'] == 'sat') {
        rateIcon = Icon(
          Icons.sentiment_satisfied,
          color: Colors.greenAccent,
          size: 35,
        );
      } else if (document['rate'] == 'neu') {
        rateIcon = Icon(
          Icons.sentiment_neutral,
          color: Colors.deepOrange,
          size: 35,
        );
      } else if (document['rate'] == 'dis') {
        rateIcon = Icon(
          Icons.sentiment_dissatisfied,
          color: Colors.redAccent,
          size: 35,
        );
      } else if (document['rate'] == 'v_dis') {
        rateIcon = Icon(
          Icons.sentiment_very_dissatisfied,
          color: Colors.red,
          size: 35,
        );
      }

      return ListTile(
        title: Card(
          child: InkWell(
            onTap: () {
              var rate = document['rate'];
              var review = document['review'];
              var uName = document['user_name'];
              var uEmail = document['user_email'];
              var uPhoto = document['user_photo'];

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FeedbackByUser(
                    uName: uName,
                    uPhoto: uPhoto,
                    rate: rate,
                    review: review,
                    uEmail: uEmail,
                  ),
                ),
              );
            },
            child: Container(
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.transparent,
                      backgroundImage: NetworkImage(document['user_photo']),
                    ),
                  ),
                  Text(
                    document['user_name'],
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                  Expanded(
                      child: Text(
                    '',
                  )),
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: rateIcon,
                  )
                ],
              ),
            ),
          ),
        ),
      );
    }

    helpAlert(BuildContext context) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('RATING SYMBOLS',textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold),),
              content: Container(
                height: 295,
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

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(
            child: Text(
          'App Feedback',
        )),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () {
              helpAlert(context);
            },
          ),
          IconButton(
            icon: Icon(Icons.add_circle_outline),
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => AddFeedback(
                      uName: widget.uName,
                      uEmail: widget.uEmail,
                      uPhoto: widget.uPhoto,
                    ))),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: Firestore.instance.collection('Feedback').snapshots(),
        builder: (context, snapshot) {
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

          if (snapshot.data.documents.length <= 0)
            return Center(child: Text('No Feedback yet......'));

          return ListView.builder(
            itemExtent: 90.0,
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index) =>
                _buildListItem(context, snapshot.data.documents[index]),
          );
        },
      ),
    );
  }
}
