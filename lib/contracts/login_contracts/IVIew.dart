import 'package:flutter/material.dart';

abstract class IView {
  void onValidationResult({@required bool isValid});
  void onLoginResult({@required bool success, @required String exception});
}
