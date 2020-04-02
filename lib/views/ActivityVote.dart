import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:mrpmile/contracts/activity_vote_contracts/IPresenter.dart';
import 'package:mrpmile/contracts/activity_vote_contracts/IView.dart';
import 'package:mrpmile/presenters/ActivityVotePresenter.dart';
import 'package:mrpmile/utils/Fields.dart';
import 'package:mrpmile/utils/Utils.dart';
import 'package:mrpmile/views/ActivityWeeklyMrpMile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ActivityVote extends StatefulWidget {
  @override
  _ActivityVoteState createState() => _ActivityVoteState();
}

class _ActivityVoteState extends State<ActivityVote> implements IView {
  String _powerOnly, _dryVan, _reefer, _flatBed, _tanker;
  TextEditingController _powerOnlyController = TextEditingController();
  TextEditingController _dryVanController = TextEditingController();
  TextEditingController _reeferController = TextEditingController();
  TextEditingController _flatBedController = TextEditingController();
  TextEditingController _tankerController = TextEditingController();
  IPresenter _presenter;
  bool _isLoading = false;

  @override
  void initState() {
    _presenter = ActivityVotePresenter(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MRPmile voting page'),
        leading: IconButton(
          icon: Icon(Icons.chevron_left),
          onPressed: () {
            Utils.changeScreen(context, ActivityWeeklyMrpMile());
          },
        ),
      ),
      body: Stack(
        children: <Widget>[
          _getBody(),
          _isLoading ? Utils.loadingContainer() : Container(),
        ],
      ),
    );
  }

  _getBody() {
    return ListView(
      children: <Widget>[
        SizedBox(
          height: 24.0,
        ),
        Text(
          'OWNER OPERATOR',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 25.0,
          ),
        ),
        SizedBox(
          height: 12.0,
        ),
        Text(
          'Please vote here once a week for next week\'s MRPmile',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 21.0,
          ),
        ),
        SizedBox(
          height: 12.0,
        ),
        Text(
          'We limited MRPmile to e between \$1.60 - \$3.60.\nRemember our fight is to have a fair MRPmile.\nVote from Sunadys 00.01 to Saturdays 23.59.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 15.0,
          ),
        ),
        SizedBox(
          height: 16.0,
        ),
        _getVehicleBox(_powerOnlyController, 'POWER\nONLY'),
        _getVehicleBox(_dryVanController, 'DRY\nVAN'),
        _getVehicleBox(_reeferController, 'REEFER'),
        _getVehicleBox(_flatBedController, 'FLATBED'),
        _getVehicleBox(_tankerController, 'TANKER'),
        SizedBox(
          height: 16.0,
        ),
        _getVoteButton(),
        SizedBox(
          height: 16.0,
        ),
        Container(
          alignment: Alignment.center,
          height: 45.0,
          child: Text('BLOCK FOR AD'),
        ),
      ],
    );
  }

  _getVoteButton() {
    return GestureDetector(
      onTap: () {
        _powerOnly = _powerOnlyController.text.toString().trim();
        _dryVan = _dryVanController.text.toString().trim();
        _reefer = _reeferController.text.toString().trim();
        _flatBed = _flatBedController.text.toString().trim();
        _tanker = _tankerController.text.toString().trim();
        _presenter.initValidation(
          powerOnly: _powerOnly,
          dryVan: _dryVan,
          reefer: _reefer,
          flatBed: _flatBed,
          tanker: _tanker,
        );
      },
      child: Container(
        height: 50.0,
        alignment: Alignment.center,
        margin: EdgeInsets.only(left: 12.0, right: 12.0, bottom: 32.0),
        color: Theme.of(context).accentColor,
        child: Text(
          'Submit your vote',
          style: TextStyle(
            fontSize: 21.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  _getVehicleBox(TextEditingController controller, String label) {
    return Container(
      color: Colors.black,
      margin: EdgeInsets.only(top: 8.0),
      padding: EdgeInsets.all(32.0),
      height: 130.0,
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25.0,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            width: 64.0,
          ),
          Expanded(
            flex: 1,
            child: Fields.getVotingField(
              controller: controller,
              hint: '\$ 0,00',
            ),
          ),
        ],
      ),
    );
  }

  @override
  void onValidationResult({bool isValid}) {
    if (isValid) {
      setState(() {
        _isLoading = true;
        _presenter.checkWeekVote();
      });
    } else {
      Utils.showToast(message: 'Invalid values detected');
    }
  }

  @override
  void onCheckWeekVoteResult({bool alreadyVoted, String exception}) {
    if (alreadyVoted == null) {
      setState(() {
        _isLoading = false;
        Utils.showToast(message: exception);
      });
    } else if (alreadyVoted) {
      setState(() {
        _isLoading = false;
        Utils.showToast(message: exception);
      });
    } else {
      _presenter.addVote();
    }
  }

  @override
  void onVoteAdded() async {
    var pref = await SharedPreferences.getInstance();
    pref.setString(Utils.calculateCurrentWeek(),
        (await FirebaseAuth.instance.currentUser()).uid);
    await pref.commit();
    Utils.changeScreen(context, ActivityWeeklyMrpMile());
    setState(() {
      _isLoading = false;
      Utils.showToast(message: 'Your vote has been added');
    });
  }
}
