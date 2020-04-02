import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mrpmile/contracts/activity_vote_contracts/IModel.dart';
import 'package:mrpmile/contracts/activity_vote_contracts/IPresenter.dart';
import 'package:mrpmile/contracts/activity_vote_contracts/IView.dart';
import 'package:mrpmile/models/ActivityVoteModel.dart';
import 'package:mrpmile/utils/Utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ActivityVotePresenter implements IPresenter {
  String _powerOnly, _dryVan, _reefer, _flatBed, _tanker, _uid, _vote_week;
  IView _view;
  IModel _model;

  ActivityVotePresenter(this._view);

  @override
  bool initValidation(
      {String powerOnly,
      String dryVan,
      String reefer,
      String flatBed,
      String tanker}) {
    this._powerOnly = powerOnly;
    this._dryVan = dryVan;
    this._reefer = reefer;
    this._flatBed = flatBed;
    this._tanker = tanker;
    _model = ActivityVoteModel(_powerOnly, _dryVan, _reefer, _flatBed, _tanker);
    _view.onValidationResult(isValid: _model.validate());
  }

  @override
  void checkWeekVote() async {
    _uid = await (await FirebaseAuth.instance.currentUser()).uid;
    _vote_week = Utils.calculateCurrentWeek();
    Firestore.instance
        .collection('votes')
        .where('vote_by', isEqualTo: _uid)
        .where('vote_week', isEqualTo: _vote_week)
        .getDocuments()
        .then((querySnapshot) {
      if (querySnapshot.documents.isNotEmpty) {
        _view.onCheckWeekVoteResult(
            alreadyVoted: true,
            exception: 'You have already voted for this week');
      } else {
        _view.onCheckWeekVoteResult(alreadyVoted: false, exception: null);
      }
    }).catchError((error) {
      _view.onCheckWeekVoteResult(alreadyVoted: null, exception: error.message);
    });
  }

  @override
  void addVote() async {
    for (var i = 0; i < 5; i++) {
      var map = HashMap<String, String>();
      map['vote_by'] = _uid;
      map['vote_week'] = _vote_week;
      switch (i) {
        case 0:
          {
            map['vote_category'] = 'Power Only';
            map['vote'] = _powerOnly;
            break;
          }
        case 1:
          {
            map['vote_category'] = 'Dry Van';
            map['vote'] = _dryVan;
            break;
          }
        case 2:
          {
            map['vote_category'] = 'Reefer';
            map['vote'] = _reefer;
            break;
          }
        case 3:
          {
            map['vote_category'] = 'Flatbed';
            map['vote'] = _flatBed;
            break;
          }
        case 4:
          {
            map['vote_category'] = 'Tanker';
            map['vote'] = _tanker;
            break;
          }
      }
      await Firestore.instance.collection('votes').add(map);
    }
    SharedPreferences _pref = await SharedPreferences.getInstance();
    await _pref.setBool('${Utils.calculateCurrentWeek()}', true);
    _view.onVoteAdded();
  }
}
