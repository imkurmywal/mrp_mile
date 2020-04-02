import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mrpmile/contracts/activity_video_comments_contracts/IModel.dart';
import 'package:mrpmile/contracts/activity_video_comments_contracts/IPresenter.dart';
import 'package:mrpmile/contracts/activity_video_comments_contracts/IView.dart';
import 'package:mrpmile/models/ActivityVideoCommentsModel.dart';
import 'package:mrpmile/utils/Constants.dart';

class ActivityVideoCommentsPresenter implements IPresenter {
  IView _view;
  IModel _model;
  List<DocumentSnapshot> _userList = List();
  String _comment;

  ActivityVideoCommentsPresenter(this._view);

  @override
  void getUsersData() {
    Firestore.instance.collection('users').getDocuments().then((querySnapshot) {
      if (querySnapshot.documents.isNotEmpty) {
        querySnapshot.documents.forEach((documentSnapshot) {
          _userList.add(documentSnapshot);
        });
        _view.onGetUsersDataResult(
          success: true,
          exception: null,
          usersList: _userList,
        );
      } else {
        _view.onGetUsersDataResult(
          success: false,
          exception: 'No users found',
          usersList: null,
        );
      }
    }).catchError((error) {
      _view.onGetUsersDataResult(
        success: false,
        exception: error.message,
        usersList: null,
      );
    });
  }

  @override
  Stream<QuerySnapshot> getComments() {
    return Firestore.instance
        .collection('comments')
        .where('comment_type', isEqualTo: Constants.TYPE_VIDEO)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  @override
  void addComment() async {
    var map = HashMap<String, Object>();
    map['comment'] = _comment;
    map['comment_type'] = Constants.TYPE_VIDEO;
    map['timestamp'] = Timestamp.now();
    map['user_uid'] = (await FirebaseAuth.instance.currentUser()).uid;
    Firestore.instance.collection('comments').add(map).then((_) {
      _view.onAddCommentResult(success: true, exception: null);
    }).catchError((error) {
      _view.onAddCommentResult(success: false, exception: error.message);
    });
  }

  @override
  void initValidation({String comment}) {
    this._comment = comment;
    _model = ActivityVideoCommentsModel(_comment);
    _view.onValidationResult(isValid: _model.validate());
  }
}
