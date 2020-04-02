import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

abstract class IView {
  void onGetUsersResult(
      {@required bool success, @required List<DocumentSnapshot> userList});

  void onGetAdminDataResult(
      {@required bool success, @required List<DocumentSnapshot> adminDataList});
}
