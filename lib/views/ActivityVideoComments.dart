import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mrpmile/contracts/activity_video_comments_contracts/IPresenter.dart';
import 'package:mrpmile/contracts/activity_video_comments_contracts/IView.dart';
import 'package:mrpmile/presenters/ActivityVideoCommentsPresenter.dart';
import 'package:mrpmile/utils/Utils.dart';

class ActivityVideoComments extends StatefulWidget {
  @override
  _ActivityVideoCommentsState createState() => _ActivityVideoCommentsState();
}

class _ActivityVideoCommentsState extends State<ActivityVideoComments>
    implements IView {
  var _commentController = TextEditingController();
  List<DocumentSnapshot> _usersList = List();
  List<DocumentSnapshot> _commentsList = List();
  StreamSubscription _subscription;
  bool _isLoading = true;
  IPresenter _presenter;

  @override
  void initState() {
    _presenter = ActivityVideoCommentsPresenter(this);
    _presenter.getUsersData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Comments'),
        leading: IconButton(
          icon: Icon(Icons.chevron_left),
          onPressed: () {
            Navigator.of(context).pop();
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
                    _presenter.initValidation(comment: comment);
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
    return _commentsList.isEmpty
        ? Container()
        : ListView(
            children: _commentsList.map((documentSnapshot) {
              return _getRowDesign(documentSnapshot);
            }).toList(),
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
  void onGetUsersDataResult(
      {bool success,
      String exception,
      List<DocumentSnapshot> usersList,
      List<DocumentSnapshot> commentsList}) {
    if (success) {
      _usersList = usersList;
      _subscription = _presenter.getComments().listen((querySnapshot) {
        if (querySnapshot.documents.isNotEmpty) {
          _commentsList.clear();
          querySnapshot.documents.forEach((documentSnapshot) {
            _commentsList.add(documentSnapshot);
          });
          setState(() {
            _isLoading = false;
          });
        } else {
          Utils.showToast(message: 'No comments found');
          setState(() {
            _isLoading = false;
          });
        }
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      Utils.showToast(message: 'No user found');
    }
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  void onAddCommentResult({bool success, String exception}) {
    if (success) {
      Utils.showToast(message: 'Comment added');
    } else {
      Utils.showToast(message: exception);
    }
  }

  @override
  void onValidationResult({bool isValid}) {
    if (isValid) {
      Navigator.pop(context);
      _presenter.addComment();
    } else {
      Utils.showToast(message: 'Please enter a comment first');
    }
  }
}
