import 'package:flutter/material.dart';

abstract class IView {
  void onValidationResult({@required bool isValid});

  void onSendResetLinkResult(
      {@required bool success, @required String exception});
}
