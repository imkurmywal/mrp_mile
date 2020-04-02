import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mrpmile/contracts/ActivityMessageDetailsContracts/IPresenter.dart';
import 'package:mrpmile/contracts/ActivityMessageDetailsContracts/IView.dart';
import 'package:mrpmile/presenters/ActivityMessageDetailsPresenter.dart';
import 'package:mrpmile/utils/Utils.dart';

class ActivityMessageDetails extends StatefulWidget {
  String _message;

  ActivityMessageDetails(this._message);

  @override
  _ActivityMessageDetailsState createState() =>
      _ActivityMessageDetailsState(_message);
}

class _ActivityMessageDetailsState extends State<ActivityMessageDetails>
    implements IView {
  var _commentController = TextEditingController();
  List<DocumentSnapshot> _commentsList = List();
  List<DocumentSnapshot> _usersList = List();
  StreamSubscription _subscription;
  IPresenter _presenter;
  String _message;
  bool _isLoading = true;

  _ActivityMessageDetailsState(this._message);

  @override
  void initState() {
    _presenter = ActivityMessageDetailsPresenter(this);
    _presenter.getUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Message by Admin'),
          leading: IconButton(
            icon: Icon(Icons.chevron_left),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                _showAddDialog();
              },
            ),
          ],
        ),
        body: _isLoading ? Utils.loadingContainer() : _getBody(),
      ),
      onWillPop: () {
        Navigator.pop(context);
      },
    );
  }

  _showAddDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Comment'),
          content: Container(
            height: 180.0,
            child: Column(
              children: <Widget>[
                TextField(
                  maxLines: 2,
                  controller: _commentController,
                  decoration: InputDecoration(labelText: 'enter comment here'),
                ),
                SizedBox(
                  height: 16.0,
                ),
                RaisedButton(
                  child: Text(
                    'Add Comment',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  color: Theme.of(context).accentColor,
                  onPressed: () {
                    var comment = _commentController.text.toString().trim();
                    _presenter.initiateValidation(comment: comment);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _getBody() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(12.0),
            padding: EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 1.0,
              ),
            ),
            alignment: Alignment.center,
            child: Column(
              children: <Widget>[
                Text(
                  'Admin Message!',
                  style: TextStyle(
                    fontSize: 21.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Text(
                  _message,
                  style: TextStyle(
                    fontSize: 17.0,
                  ),
                )
              ],
            ),
          ),
          Text(
            'Comments',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: ListView(
              children: _commentsList.map((documentSnapshot) {
                return _getRowDesign(documentSnapshot);
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getRowDesign(DocumentSnapshot snapshot) {
    DocumentSnapshot user;
    _usersList.forEach((documentSnapshot) {
      if (documentSnapshot.documentID == snapshot['user_uid']) {
        user = documentSnapshot;
      }
    });

    return Container(
      padding: EdgeInsets.all(8.0),
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 1.0,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '${user['first_name']} ${user['last_name']}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 19.0,
            ),
          ),
          Text(
            snapshot['comment'],
            style: TextStyle(
              fontSize: 17.0,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void onAddCommentResult({bool success, String exception}) {
    setState(() {
      _isLoading = false;
    });
    if (success) {
      Utils.showToast(message: 'Comment Added');
    } else {
      Utils.showToast(message: exception);
    }
  }

  @override
  void onGetUsersResult(
      {bool success, String exception, List<DocumentSnapshot> usersList}) {
    if (success) {
      _usersList = usersList;
      _subscription = _presenter.getCommentsStream().listen((querySnapshot) {
        if (querySnapshot.documents.isNotEmpty) {
          setState(() {
            _isLoading = false;
            _commentsList.clear();
            querySnapshot.documents.forEach((documentSnapshot) {
              _commentsList.add(documentSnapshot);
            });
          });
        } else {
          setState(() {
            Utils.showToast(message: 'No comment found');
            _isLoading = false;
          });
        }
      });
    } else {
      setState(() {
        _isLoading = false;
        Utils.showToast(message: exception);
      });
    }
  }

  @override
  void onValidationResult({bool isValid}) {
    if (isValid) {
      setState(() {
        Navigator.pop(context);
        _presenter.addComment();
        _isLoading = true;
      });
    } else {
      Utils.showToast(message: 'please add a comments first');
    }
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
