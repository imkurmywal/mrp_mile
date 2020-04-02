import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mrpmile/utils/Constants.dart';
import 'package:mrpmile/utils/Utils.dart';
import 'package:mrpmile/views/ActivityHome.dart';
import 'package:mrpmile/views/ActivityWeeklyMrpMile.dart';

class ActivityLiveVoteResults extends StatefulWidget {
  bool _isFromHome;

  ActivityLiveVoteResults(this._isFromHome);

  @override
  _ActivityLiveVoteResultsState createState() =>
      _ActivityLiveVoteResultsState(_isFromHome);
}

class _ActivityLiveVoteResultsState extends State<ActivityLiveVoteResults> {
  List<DocumentSnapshot> _voteList = List();
  StreamSubscription _subscription;
  bool _isFromHome;

  _ActivityLiveVoteResultsState(this._isFromHome);

  @override
  void initState() {
    _subscription = _getLiveVotes().listen((querySnapshot) {
      if (querySnapshot.documents.isNotEmpty) {
        setState(() {
          _voteList.clear();
          querySnapshot.documents.forEach((documentSnapshot) {
            _voteList.add(documentSnapshot);
          });
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          title: Text('MRPmilve live results so far'),
          leading: IconButton(
            icon: Icon(Icons.chevron_left),
            onPressed: () {
              Utils.changeScreen(context,
                  _isFromHome ? ActivityHome() : ActivityWeeklyMrpMile());
            },
          ),
        ),
        body: _getBody(),
      ),
      onWillPop: () {
        Utils.changeScreen(
            context, _isFromHome ? ActivityHome() : ActivityWeeklyMrpMile());
      },
    );
  }

  _getBody() {
    return ListView(
      children: <Widget>[
        SizedBox(
          height: 12.0,
        ),
        Text(
          'Thank you for your vote!\nYour voice will be heard.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 21.0,
          ),
        ),
        SizedBox(
          height: 24.0,
        ),
        Text(
          'LIVE VOTE RESULTS\nMRPmile\nFOR NEXT WEEK',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 25.0,
          ),
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
        _getBottomButton(),
        SizedBox(
          height: 16.0,
        ),
        Container(
          alignment: Alignment.center,
          height: 45.0,
          child: Text('BLOCK FOR AD'),
        ),
      ],
    );
  }

  _getBottomButton() {
    return GestureDetector(
      onTap: () {
        Utils.changeScreen(context, ActivityWeeklyMrpMile());
      },
      child: Container(
        height: 50.0,
        alignment: Alignment.center,
        margin: EdgeInsets.only(left: 12.0, right: 12.0, bottom: 32.0),
        color: Theme.of(context).accentColor,
        child: Text(
          'Weekly MRPmile',
          style: TextStyle(
            fontSize: 21.0,
            color: Colors.white,
          ),
        ),
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

  Stream<QuerySnapshot> _getLiveVotes() {
    return Firestore.instance
        .collection('votes')
        .where('vote_week', isEqualTo: Utils.calculateCurrentWeek())
        .snapshots();
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
