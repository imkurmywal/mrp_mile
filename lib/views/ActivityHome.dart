import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mrpmile/contracts/activity_home_contracts/IPresenter.dart';
import 'package:mrpmile/contracts/utils_contracts/IUtils.dart';
import 'package:mrpmile/contracts/activity_home_contracts/IView.dart';
import 'package:mrpmile/presenters/ActivityHomePresenter.dart';
import 'package:mrpmile/utils/Constants.dart';
import 'package:mrpmile/utils/SideDrawer.dart';
import 'package:mrpmile/utils/Utils.dart';
import 'package:mrpmile/views/ActivityLiveVoteResults.dart';
import 'package:mrpmile/views/ActivityLogin.dart';
import 'package:mrpmile/views/ActivityMessageDetails.dart';
import 'package:mrpmile/views/ActivityMrpFormulae.dart';
import 'package:mrpmile/views/ActivityPrviousResult.dart';
import 'package:mrpmile/views/ActivityVideoDetails.dart';
import 'package:mrpmile/views/ActivityVote.dart';
import 'package:mrpmile/views/ActivityWeeklyMrpMile.dart';
import 'package:video_player/video_player.dart';

class ActivityHome extends StatefulWidget {
  @override
  _ActivityHomeState createState() => _ActivityHomeState();
}

class _ActivityHomeState extends State<ActivityHome> implements IView, IUtils {
  VideoPlayerController _controller;
  List<DocumentSnapshot> _usersList = List();
  List<DocumentSnapshot> _adminDataList = List();
  IPresenter _presenter;
  bool _isLoading = true;

  @override
  void initState() {
    _loadAd();
    _presenter = ActivityHomePresenter(this);
    _presenter.getUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _getAppBar(),
      body: Stack(
        children: <Widget>[
          _isLoading ? Utils.loadingContainer() : _getBody(),
        ],
      ),
      drawer: SideDrawer(),
    );
  }

  Widget _getAppBar() {
    return AppBar(
      title: Text('Home'),
    );
  }

  _getBody() {
    return Container(
      color: Colors.white,
      child: Center(
        child: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(32.0),
              child: Image(
                image: AssetImage('images/logo.png'),
                height: 80.0,
              ),
            ),
            _getUserCounter(),
            SizedBox(
              height: 8.0,
            ),
            Divider(
              thickness: 2.0,
              color: Colors.black,
            ),
            _getMessageBox(),
            SizedBox(
              height: 8.0,
            ),
            Divider(
              thickness: 2.0,
              color: Colors.black,
            ),
            SizedBox(
              height: 8.0,
            ),
            _getVideoSection(),
            SizedBox(
              height: 8.0,
            ),
            Divider(
              thickness: 2.0,
              color: Colors.black,
            ),
            SizedBox(
              height: 8.0,
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Please subscribe to MRPmile and help us to maintain and improve this app.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 17.0),
              ),
            ),
            _getButtons(),
            _getAdSection(),
          ],
        ),
      ),
    );
  }

  _getAdSection() {
    return Container(
      alignment: Alignment.center,
      height: 55.0,
      child: Text('AD BLOCK'),
    );
  }

  _getButtons() {
    return Container(
      height: 120,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: GestureDetector(
                  onTap: (){
                    Utils.showSubscriptionDialog(36,context, this);
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 8.0, right: 8.0),
                    height: 50.0,
                    alignment: Alignment.center,
                    color: Constants.maroonColor,
                    child: Text(
                      'Become a Subscriber',
                      style: TextStyle(
                        fontSize: 21.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Utils.changeScreen(context, ActivityWeeklyMrpMile());
                  },
                  child: Container(
                    margin: EdgeInsets.all(8.0),
                    height: 50.0,
                    alignment: Alignment.center,
                    color: Theme.of(context).accentColor,
                    child: Text(
                      'Weekly MRPmile',
                      style: TextStyle(
                        fontSize: 21.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _getVideoSection() {
    return _controller != null
        ? _controller.value.initialized
            ? Container(
                height: 170.0,
                child: Stack(
                  children: <Widget>[
                    VideoPlayer(
                      _controller,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ActivityVideoDetails(
                                  _adminDataList[0]['message'] == null
                                      ? _adminDataList[0]['video']
                                      : _adminDataList[1]['video'])));
                        },
                        child: Icon(
                          Icons.play_circle_filled,
                          color: Colors.grey,
                          size: 55.0,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : Container(
                height: 170.0,
                color: Colors.black,
              )
        : Container(
            height: 170.0,
            color: Colors.black,
          );
  }

  _getMessageBox() {
    if (_adminDataList == null) {
      _adminDataList = List();
    }
    return GestureDetector(
      onTap: () {
        if (_adminDataList != null && _adminDataList[0]['message'] != null) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ActivityMessageDetails(_adminDataList[0]['message'])));
        }
      },
      child: Container(
        height: 150.0,
        color: Colors.transparent,
        padding: EdgeInsets.all(8.0),
        alignment: Alignment.center,
        child: Text(
          _adminDataList.isEmpty
              ? 'No message'
              : _adminDataList[0]['message'] != null
                  ? _adminDataList[0]['message']
                  : 'No message',
          style: TextStyle(
            fontSize: 21.0,
          ),
        ),
      ),
    );
  }

  _getUserCounter() {
    return Container(
      height: 150.0,
      color: Colors.black,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            '${_usersList.length}',
            style: TextStyle(color: Colors.orange, fontSize: 75.0),
          ),
          Text(
            'JOINED SO FAR',
            style: TextStyle(color: Colors.white, fontSize: 22.0),
          ),
        ],
      ),
    );
  }

  @override
  void onGetUsersResult({bool success, List<DocumentSnapshot> userList}) {
    setState(() {
      _isLoading = false;
      if (success) {
        this._usersList = userList;
      } else {
        Utils.showToast(message: 'No users yet');
      }
      _presenter.getAdminData();
    });
  }

  @override
  void onGetAdminDataResult(
      {bool success, List<DocumentSnapshot> adminDataList}) {
    setState(() {
      if (success) {
        this._adminDataList = adminDataList;
        _getVideoController(_adminDataList[0]['message'] == null
            ? _adminDataList[0]['video']
            : _adminDataList[1]['video']);
      }
    });
  }

  _getVideoController(String url) {
    _controller = VideoPlayerController.network(url)
      ..initialize().then((_) {
        setState(() {
          _controller.seekTo(Duration(seconds: 1));
        });
      });
  }

  _loadAd() async {
    String uid = (await FirebaseAuth.instance.currentUser()).uid;
    DocumentSnapshot userSubscription = await Firestore.instance
        .collection('subscriptions')
        .document(uid)
        .get();
    if (userSubscription.exists) {
      int start = userSubscription['start_date_in_millis'];
      int end = userSubscription['end_date_in_millis'];
      if (start > end) {
        _displayAds();
      }
    } else {
      _displayAds();
    }
  }

  _displayAds() {
    FirebaseAdMob.instance.initialize(appId: Constants.ADMOB_APP_ID);
    BannerAd myBanner = BannerAd(
      adUnitId: BannerAd.testAdUnitId,
      size: AdSize.smartBanner,
      listener: (MobileAdEvent event) {
        print("BannerAd event is $event");
      },
    );
    myBanner
      ..load()
      ..show();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void onPaymentResult(bool success) {
    if(success) {
      Utils.showToast(message: 'Subscription successful, retart app to remove ads');
    }else {
      Utils.showToast(message: 'Payment unsuccessfull');
    }
  }
}
