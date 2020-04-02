import 'package:flutter/material.dart';

abstract class IPresenter {
  bool initValidation({
    @required String powerOnly,
    @required String dryVan,
    @required String reefer,
    @required String flatBed,
    @required String tanker,
  });

  void checkWeekVote();

  void addVote();
}
