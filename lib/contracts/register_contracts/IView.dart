import 'package:flutter/material.dart';

abstract class IView {
  void onValidationResult({@required bool isValid});

  void onRegistrationResult(
      {@required bool success, @required String exception});

  void onSaveDataResult({@required bool success, @required String exception});

  void onSendEmailVerificationResult(
      {@required bool success, @required String exception});
}
