import 'package:flutter/material.dart';

abstract class IPresenter {
  void initValidation({@required String email, @required String password});

  void loginUser();
}
