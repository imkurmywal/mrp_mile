import 'dart:collection';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:mrpmile/contracts/utils_contracts/IUtils.dart';
import 'package:mrpmile/models/GraphModel.dart';
import 'package:http/http.dart' as http;
import 'package:square_in_app_payments/in_app_payments.dart';

import 'Constants.dart';

class Utils {
  static changeScreen(BuildContext context, Object targetClass) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
      return targetClass;
    }));
  }

  static Widget loadingContainer() {
    print('container called');
    return Container(
      color: Colors.black12,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  static showToast({@required String message}) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        timeInSecForIosWeb: 5,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.blueAccent,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static bool validateEmail(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  static String calculateLastWeek() {
    DateTime currentDate = DateTime.now();
    String day = DateFormat('EEEE').format(currentDate);
    switch (day) {
      case 'Sunday':
        {
          DateTime lastWeekEnd = Jiffy(currentDate).subtract(days: 1);
          DateTime lastWeekStart = Jiffy(currentDate).subtract(days: 7);
          return _getFormattedDate(
              startDate: lastWeekStart, endDate: lastWeekEnd);
        }
      case 'Monday':
        {
          DateTime lastWeekEnd = Jiffy(currentDate).subtract(days: 2);
          DateTime lastWeekStart = Jiffy(currentDate).subtract(days: 8);
          return _getFormattedDate(
              startDate: lastWeekStart, endDate: lastWeekEnd);
        }
      case 'Tuesday':
        {
          DateTime lastWeekEnd = Jiffy(currentDate).subtract(days: 3);
          DateTime lastWeekStart = Jiffy(currentDate).subtract(days: 9);
          return _getFormattedDate(
              startDate: lastWeekStart, endDate: lastWeekEnd);
        }
      case 'Wednesday':
        {
          DateTime lastWeekEnd = Jiffy(currentDate).subtract(days: 4);
          DateTime lastWeekStart = Jiffy(currentDate).subtract(days: 10);
          return _getFormattedDate(
              startDate: lastWeekStart, endDate: lastWeekEnd);
        }
      case 'Thursday':
        {
          DateTime lastWeekEnd = Jiffy(currentDate).subtract(days: 5);
          DateTime lastWeekStart = Jiffy(currentDate).subtract(days: 11);
          return _getFormattedDate(
              startDate: lastWeekStart, endDate: lastWeekEnd);
        }
      case 'Friday':
        {
          DateTime lastWeekEnd = Jiffy(currentDate).subtract(days: 6);
          DateTime lastWeekStart = Jiffy(currentDate).subtract(days: 12);
          return _getFormattedDate(
              startDate: lastWeekStart, endDate: lastWeekEnd);
        }
      case 'Saturday':
        {
          DateTime lastWeekEnd = Jiffy(currentDate).subtract(days: 7);
          DateTime lastWeekStart = Jiffy(currentDate).subtract(days: 13);
          return _getFormattedDate(
              startDate: lastWeekStart, endDate: lastWeekEnd);
        }
    }
  }

  static String calculateCurrentWeek() {
    DateTime currentDate = DateTime.now();
    String day = DateFormat('EEEE').format(currentDate);
    switch (day) {
      case 'Sunday':
        {
          DateTime startDate = currentDate;
          DateTime endDate = Jiffy(currentDate).add(days: 6);
          return _getFormattedDate(startDate: startDate, endDate: endDate);
        }
      case 'Monday':
        {
          DateTime startDate = Jiffy(currentDate).subtract(days: 1);
          DateTime endDate = Jiffy(currentDate).add(days: 5);
          return _getFormattedDate(startDate: startDate, endDate: endDate);
        }
      case 'Tuesday':
        {
          DateTime startDate = Jiffy(currentDate).subtract(days: 2);
          DateTime endDate = Jiffy(currentDate).add(days: 4);
          return _getFormattedDate(startDate: startDate, endDate: endDate);
        }
      case 'Wednesday':
        {
          DateTime startDate = Jiffy(currentDate).subtract(days: 3);
          DateTime endDate = Jiffy(currentDate).add(days: 3);
          return _getFormattedDate(startDate: startDate, endDate: endDate);
        }
      case 'Thursday':
        {
          DateTime startDate = Jiffy(currentDate).subtract(days: 4);
          DateTime endDate = Jiffy(currentDate).add(days: 2);
          return _getFormattedDate(startDate: startDate, endDate: endDate);
        }
      case 'Friday':
        {
          DateTime startDate = Jiffy(currentDate).subtract(days: 5);
          DateTime endDate = Jiffy(currentDate).add(days: 1);
          return _getFormattedDate(startDate: startDate, endDate: endDate);
        }
      case 'Saturday':
        {
          DateTime startDate = Jiffy(currentDate).subtract(days: 6);
          DateTime endDate = Jiffy(currentDate).add(days: 0);
          return _getFormattedDate(startDate: startDate, endDate: endDate);
        }
    }
  }

  static String calculateWeekDate({@required int weekNumber}) {
    // 0 means the last week
    DateTime currentDate = DateTime.now();
    String day = DateFormat('EEEE').format(currentDate);
    switch (day) {
      case 'Sunday':
        {
          DateTime lastWeekEnd =
              Jiffy(currentDate).subtract(days: 1 + (weekNumber * 7));
          DateTime lastWeekStart =
              Jiffy(currentDate).subtract(days: 7 + (weekNumber * 7));
          return _getFormattedDate(
              startDate: lastWeekStart, endDate: lastWeekEnd);
        }
      case 'Monday':
        {
          DateTime lastWeekEnd =
              Jiffy(currentDate).subtract(days: 2 + (weekNumber * 7));
          DateTime lastWeekStart =
              Jiffy(currentDate).subtract(days: 8 + (weekNumber * 7));
          return _getFormattedDate(
              startDate: lastWeekStart, endDate: lastWeekEnd);
        }
      case 'Tuesday':
        {
          DateTime lastWeekEnd =
              Jiffy(currentDate).subtract(days: 3 + (weekNumber * 7));
          DateTime lastWeekStart =
              Jiffy(currentDate).subtract(days: 9 + (weekNumber * 7));
          return _getFormattedDate(
              startDate: lastWeekStart, endDate: lastWeekEnd);
        }
      case 'Wednesday':
        {
          DateTime lastWeekEnd =
              Jiffy(currentDate).subtract(days: 4 + (weekNumber * 7));
          DateTime lastWeekStart =
              Jiffy(currentDate).subtract(days: 10 + (weekNumber * 7));
          return _getFormattedDate(
              startDate: lastWeekStart, endDate: lastWeekEnd);
        }
      case 'Thursday':
        {
          DateTime lastWeekEnd =
              Jiffy(currentDate).subtract(days: 5 + (weekNumber * 7));
          DateTime lastWeekStart =
              Jiffy(currentDate).subtract(days: 11 + (weekNumber * 7));
          return _getFormattedDate(
              startDate: lastWeekStart, endDate: lastWeekEnd);
        }
      case 'Friday':
        {
          DateTime lastWeekEnd =
              Jiffy(currentDate).subtract(days: 6 + (weekNumber * 7));
          DateTime lastWeekStart =
              Jiffy(currentDate).subtract(days: 12 + (weekNumber * 7));
          return _getFormattedDate(
              startDate: lastWeekStart, endDate: lastWeekEnd);
        }
      case 'Saturday':
        {
          DateTime lastWeekEnd =
              Jiffy(currentDate).subtract(days: 7 + (weekNumber * 7));
          DateTime lastWeekStart =
              Jiffy(currentDate).subtract(days: 13 + (weekNumber * 7));
          return _getFormattedDate(
              startDate: lastWeekStart, endDate: lastWeekEnd);
        }
    }
  }

  static String _getFormattedDate(
      {@required DateTime startDate, @required DateTime endDate}) {
    return 'week_${startDate.day}_${startDate.month}_${startDate.year}_to_${endDate.day}_${endDate.month}_${endDate.year}';
  }

  static List<GraphModel> getCategoryList(
      {@required String category, @required QuerySnapshot querySnapshot}) {
    List<GraphModel> list = List();
    querySnapshot.documents.forEach((documentSnapshot) {
      GraphModel model = GraphModel();
      if (documentSnapshot['vote_week'] ==
          Utils.calculateWeekDate(weekNumber: 0)) {
        model.week = 1.toString();
      } else if (documentSnapshot['vote_week'] ==
          Utils.calculateWeekDate(weekNumber: 1)) {
        model.week = 2.toString();
      } else if (documentSnapshot['vote_week'] ==
          Utils.calculateWeekDate(weekNumber: 2)) {
        model.week = 3.toString();
      } else if (documentSnapshot['vote_week'] ==
          Utils.calculateWeekDate(weekNumber: 3)) {
        model.week = 4.toString();
      } else if (documentSnapshot['vote_week'] ==
          Utils.calculateWeekDate(weekNumber: 4)) {
        model.week = 5.toString();
      } else if (documentSnapshot['vote_week'] ==
          Utils.calculateWeekDate(weekNumber: 5)) {
        model.week = 6.toString();
      } else if (documentSnapshot['vote_week'] ==
          Utils.calculateWeekDate(weekNumber: 6)) {
        model.week = 7.toString();
      } else if (documentSnapshot['vote_week'] ==
          Utils.calculateWeekDate(weekNumber: 7)) {
        model.week = 8.toString();
      } else if (documentSnapshot['vote_week'] ==
          Utils.calculateWeekDate(weekNumber: 8)) {
        model.week = 9.toString();
      } else if (documentSnapshot['vote_week'] ==
          Utils.calculateWeekDate(weekNumber: 9)) {
        model.week = 10.toString();
      } else if (documentSnapshot['vote_week'] ==
          Utils.calculateWeekDate(weekNumber: 10)) {
        model.week = 11.toString();
      } else if (documentSnapshot['vote_week'] ==
          Utils.calculateWeekDate(weekNumber: 11)) {
        model.week = 12.toString();
      }
      model.value = double.parse(documentSnapshot['vote']);
      if (documentSnapshot['vote_category'] == category) list.add(model);
    });
    return list;
  }

  static showSubscriptionDialog(
      int amount, BuildContext context, IUtils view) async {
    String uid = (await FirebaseAuth.instance.currentUser()).uid;
    DocumentSnapshot userSubscription = await Firestore.instance
        .collection('subscriptions')
        .document(uid)
        .get();
    if (userSubscription.exists) {
      int start = userSubscription['start_date_in_millis'];
      int end = userSubscription['end_date_in_millis'];
      if (start <= end) {
        showToast(message: 'User already subscribed');
      }
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Subscribe!'),
            content: Text('For just \$36, subscribe for a whole year'),
            actions: <Widget>[
              FlatButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text('Subscribe'),
                onPressed: () {
                  Navigator.of(context).pop();
                  _createNonce(amount, view);
                },
              ),
            ],
          );
        },
      );
    }
  }

  static _createNonce(int amount, IUtils view) async {
    InAppPayments.setSquareApplicationId(Constants.SQUARE_APP_ID);
    InAppPayments.startCardEntryFlow(
      onCardEntryCancel: () {},
      onCardNonceRequestSuccess: (result) {
        InAppPayments.completeCardEntry(onCardEntryComplete: () async {
          _chargeUser(amount: amount, nonce: result.nonce, view: view);
        });
      },
    );
  }

  static _chargeUser(
      {@required int amount,
      @required String nonce,
      @required IUtils view}) async {
    var response = await http.post(
      Constants().HOST_URL,
      headers: <String, String>{
        'Content-Type': Constants.CONTENT_TYPE,
        'Authorization': Constants.AUTHORIZATION,
        'Accept': Constants.ACCEPT
      },
      body: jsonEncode(<String, Object>{
        'idempotency_key': Constants().IDEMPOTENCY_KEY,
        'amount_money': {'amount': amount, 'currency': Constants.CURRENCY},
        'card_nonce': nonce
      }),
    );
    _handlePaymentResponse(response.body, view);
  }

  static _handlePaymentResponse(String response, IUtils view) async {
    if (response.contains('error')) {
      view.onPaymentResult(false);
    } else {
      var subscriptionStartDateLocal = DateTime.now();
      var subscriptionEndDateLocal =
          subscriptionStartDateLocal.add(Duration(days: 365));
      int start = subscriptionStartDateLocal.millisecondsSinceEpoch;
      int end = subscriptionEndDateLocal.millisecondsSinceEpoch;
      String uid = (await FirebaseAuth.instance.currentUser()).uid;
      Map map = HashMap<String, Object>();
      map['start_date_in_millis'] = start;
      map['end_date_in_millis'] = end;

      await Firestore.instance
          .collection('subscriptions')
          .document(uid)
          .setData(map);

      view.onPaymentResult(true);
    }
  }
}
