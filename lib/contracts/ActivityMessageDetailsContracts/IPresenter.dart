import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

abstract class IPresenter {
  void getUsers();
  void initiateValidation({@required String comment});

  Stream<QuerySnapshot> getCommentsStream();
  void addComment();
}
