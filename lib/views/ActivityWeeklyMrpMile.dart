import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mrpmile/contracts/utils_contracts/IUtils.dart';
import 'package:mrpmile/utils/Constants.dart';
import 'package:mrpmile/utils/Utils.dart';
import 'package:mrpmile/views/ActivityHome.dart';
import 'package:mrpmile/views/ActivityLiveVoteResults.dart';
import 'package:mrpmile/views/ActivityVote.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ActivityWeeklyMrpMile extends StatefulWidget {
  @override
  _ActivityWeeklyMrpMileState createState() => _ActivityWeeklyMrpMileState();
}

class _ActivityWeeklyMrpMileState extends State<ActivityWeeklyMrpMile>
    implements IUtils {
  List<DocumentSnapshot> _voteList = List();
  bool _isLoading = true;

  @override
  void initState() {
    print(Utils.calculateLastWeek());
    Firestore.instance
        .collection('votes')
        .where('vote_week', isEqualTo: Utils.calculateLastWeek())
        .getDocuments()
        .then((querySnapshot) {
      setState(() {
        _isLoading = false;
      });
      if (querySnapshot.documents.isNotEmpty) {
        setState(() {
          querySnapshot.documents.forEach((documentSnapshot) {
            _voteList.add(documentSnapshot);
          });
        });
      } else {
        Utils.showToast(message: 'No votes found');
      }
    }).catchError((error) {
      setState(() {
        _isLoading = false;
        Utils.showToast(message: error.message);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Weekly MRPmile'),
          leading: IconButton(
            icon: Icon(Icons.chevron_left),
            onPressed: () {
              Utils.changeScreen(context, ActivityHome());
            },
          ),
        ),
        body: _isLoading
            ? Utils.loadingContainer()
            : _voteList.isNotEmpty
                ? _getBody()
                : Container(
                    child: Center(
                      child: _getButtons(),
                    ),
                  ),
      ),
      onWillPop: () {
        Utils.changeScreen(context, ActivityHome());
      },
    );
  }

  _getBody() {
    return ListView(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(32.0),
          child: Image(
            image: AssetImage('images/logo.png'),
          ),
        ),
        SizedBox(
          height: 24.0,
        ),
        SizedBox(
          height: 16.0,
        ),
        _getVehicleBox('POWER\nONLY', 0),
        _getVehicleBox('DRY\nVAN', 1),
        _getVehicleBox('REEFER', 2),
        _getVehicleBox('FLATBED', 3),
        _getVehicleBox('TANKER', 4),
        SizedBox(
          height: 16.0,
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Please subscribe to MRPmile and help us to maintain and improve this app.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 17.0),
          ),
        ),
        _getButtons(),
        _getAdSection(),
      ],
    );
  }

  _getAdSection() {
    return Container(
      alignment: Alignment.center,
      height: 55.0,
      child: Text('AD BLOCK'),
    );
  }

  _getButtons() {
    return Container(
      height: 120,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Utils.showSubscriptionDialog(36, context, this);
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 8.0, right: 8.0),
                    height: 50.0,
                    alignment: Alignment.center,
                    color: Constants.maroonColor,
                    child: Text(
                      'Become a Subscriber',
                      style: TextStyle(
                        fontSize: 21.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: GestureDetector(
                  onTap: () async {
                    var pref = await SharedPreferences.getInstance();
                    if (pref.getString(Utils.calculateCurrentWeek()) ==
                        (await FirebaseAuth.instance.currentUser()).uid) {
                      Utils.showToast(
                          message: 'You have already voted for this week');
                      Utils.changeScreen(
                          context, ActivityLiveVoteResults(false));
                    } else {
                      Utils.changeScreen(context, ActivityVote());
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.all(8.0),
                    height: 50.0,
                    alignment: Alignment.center,
                    color: Theme.of(context).accentColor,
                    child: Text(
                      'Vote Here for Next Week',
                      style: TextStyle(
                        fontSize: 21.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _getVehicleBox(String label, int position) {
    String category;
    switch (position) {
      case 0:
        {
          category = 'Power Only';
          break;
        }
      case 1:
        {
          category = 'Dry Van';
          break;
        }
      case 2:
        {
          category = 'Reefer';
          break;
        }
      case 3:
        {
          category = 'Flatbed';
          break;
        }
      case 4:
        {
          category = 'Tanker';
          break;
        }
    }
    return Container(
      color: Colors.black,
      margin: EdgeInsets.only(top: 8.0),
      padding: EdgeInsets.all(32.0),
      height: 130.0,
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25.0,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            width: 64.0,
          ),
          Expanded(
            flex: 1,
            child: Text(
              '\$ ${_getAverageVote(category).toStringAsFixed(2)}',
              style: TextStyle(
                color: Constants.greenColor,
                fontSize: 35.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  double _getAverageVote(String category) {
    double sum = 0.0;
    int count = 0;
    _voteList.forEach((documentSnapshot) {
      if (documentSnapshot['vote_category'] == category) {
        count++;
        sum = (sum + (double.parse(documentSnapshot['vote'])));
      }
    });
    return (sum / count);
  }

  @override
  void onPaymentResult(bool success) {
    // TODO: implement onPaymentResult
  }
}
