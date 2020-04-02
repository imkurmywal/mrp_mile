import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

abstract class IPresenter {
  void getUsersData();

  Stream<QuerySnapshot> getComments();

  void initValidation({@required String comment});

  void addComment();
}
