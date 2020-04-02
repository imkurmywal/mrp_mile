import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

abstract class IView {
  void onValidationResult({@required bool isValid});

  void onGetUsersResult(
      {@required bool success,
      @required String exception,
      @required List<DocumentSnapshot> usersList});

  void onAddCommentResult({@required bool success, @required String exception});
}
