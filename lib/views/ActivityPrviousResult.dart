import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mrpmile/models/GraphModel.dart';
import 'package:mrpmile/utils/Constants.dart';
import 'package:mrpmile/utils/ProfitChart.dart';
import 'package:mrpmile/utils/Utils.dart';
import 'package:mrpmile/views/ActivityHome.dart';

class ActivityPreviousResult extends StatefulWidget {
  @override
  _ActivityPreviousResultState createState() => _ActivityPreviousResultState();
}

class _ActivityPreviousResultState extends State<ActivityPreviousResult> {
  QuerySnapshot _querySnapshot;
  bool _isLoading = true;

  @override
  void initState() {
    Firestore.instance.collection('votes').getDocuments().then((querySnapshot) {
      setState(() {
        _isLoading = false;
        if (querySnapshot.documents.isNotEmpty) {
          this._querySnapshot = querySnapshot;
        }
      });
    }).catchError((error) {
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          title: Text('MRPmile 12 Weeks'),
          leading: IconButton(
            icon: Icon(Icons.chevron_left),
            onPressed: () {
              Utils.changeScreen(context, ActivityHome());
            },
          ),
        ),
        body: _isLoading ? Utils.loadingContainer() : _getBody(),
      ),
      onWillPop: () {
        Utils.changeScreen(context, ActivityHome());
      },
    );
  }

  _getBody() {
    return Container(
      child: ListView(
        padding: EdgeInsets.only(bottom: 60),
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Image(
              image: AssetImage('images/logo.png'),
              height: 80.0,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
            child: Text(
              'LAST 12 WEEKS RESULTS',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 21.0,
              ),
            ),
          ),
          _getRow(category: 'Power Only'),
          _getRow(category: 'Dry Van'),
          _getRow(category: 'Reefer'),
          _getRow(category: 'Flatbed'),
          _getRow(category: 'Tanker'),
        ],
      ),
    );
  }

  _getRow({@required String category}) {
    return _querySnapshot != null
        ? Container(
            color: Colors.black,
            padding: EdgeInsets.all(16.0),
            margin: EdgeInsets.only(bottom: 4, top: 4),
            child: Row(
              children: <Widget>[
                Text(
                  category,
                  style: TextStyle(
                    fontSize: 21.0,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 16.0,
                ),
                Expanded(
                  child: Container(
                    height: 100,
                    child: ProfitChart(
                      Utils.getCategoryList(
                          category: category, querySnapshot: _querySnapshot),
                    ),
                  ),
                  flex: 1,
                ),
              ],
            ),
          )
        : Center(
            child: Text(
              'No previoud data found',
              style: TextStyle(
                fontSize: 21.0,
              ),
            ),
          );
  }
}
