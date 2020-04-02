import 'package:flutter/material.dart';

abstract class IView {
  void onValidationResult({@required bool isValid});

  void onCheckWeekVoteResult({
    @required bool alreadyVoted,
    @required String exception,
  });

  void onVoteAdded();
}
