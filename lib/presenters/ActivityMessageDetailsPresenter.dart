import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mrpmile/contracts/ActivityMessageDetailsContracts/IModel.dart';
import 'package:mrpmile/contracts/ActivityMessageDetailsContracts/IPresenter.dart';
import 'package:mrpmile/contracts/ActivityMessageDetailsContracts/IView.dart';
import 'package:mrpmile/models/ActivityMessageDetailsModel.dart';
import 'package:mrpmile/utils/Constants.dart';
import 'package:mrpmile/utils/Utils.dart';

class ActivityMessageDetailsPresenter implements IPresenter {
  IView _view;
  IModel _model;
  String _comment;
  List<DocumentSnapshot> _usersList = List();

  ActivityMessageDetailsPresenter(this._view);

  @override
  void initiateValidation({String comment}) {
    this._comment = comment;
    _model = ActivityMessageDetailsModel(_comment);
    _view.onValidationResult(isValid: _model.validate());
  }

  @override
  Stream<QuerySnapshot> getCommentsStream() {
    return Firestore.instance
        .collection('comments')
        .where('comment_type', isEqualTo: Constants.TYPE_TEXT)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  @override
  void addComment() async {
    Map map = HashMap<String, Object>();
    map['comment'] = _comment;
    map['comment_type'] = Constants.TYPE_TEXT;
    map['timestamp'] = Timestamp.now();
    map['user_uid'] = (await FirebaseAuth.instance.currentUser()).uid;
    var result = await Firestore.instance.collection('comments').add(map);
    if (result.documentID != null) {
      _view.onAddCommentResult(success: true, exception: null);
    } else {
      _view.onAddCommentResult(
          success: false, exception: 'There was an error adding your comment');
    }
  }

  @override
  void getUsers() {
    Firestore.instance.collection('users').getDocuments().then((querySnapshot) {
      if (querySnapshot.documents.isNotEmpty) {
        querySnapshot.documents.forEach((documentSnapshot) {
          _usersList.add(documentSnapshot);
        });
        _view.onGetUsersResult(
            success: true, exception: null, usersList: _usersList);
      } else {
        _view.onGetUsersResult(
            success: false, exception: 'No users found', usersList: null);
      }
    }).catchError((error) {
      _view.onGetUsersResult(
          success: false, exception: error.message, usersList: null);
    });
  }
}
