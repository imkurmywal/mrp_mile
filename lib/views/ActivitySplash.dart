import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mrpmile/utils/Utils.dart';
import 'package:mrpmile/views/ActivityHome.dart';
import 'package:mrpmile/views/ActivityWelcome.dart';

class ActivitySplash extends StatefulWidget {
  @override
  _ActivitySplashState createState() => _ActivitySplashState();
}

class _ActivitySplashState extends State<ActivitySplash> {
  StreamSubscription _subscription;

  @override
  void initState() {
    _subscription = _getCount().listen((count) async {
      print(count.toString());
      if (count == 3) {
        var user = await FirebaseAuth.instance.currentUser();
        if (user != null) {
          Utils.changeScreen(context, ActivityHome());
        } else {
          Utils.changeScreen(context, ActivityWelcome());
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(32.0),
        color: Colors.white,
        child: Center(
          child: Image(
            image: AssetImage('images/logo.png'),
            height: 80.0,
          ),
        ),
      ),
    );
  }

  Stream<int> _getCount() async* {
    var count = 0;
    while (count < 4) {
      await Future.delayed(Duration(seconds: 1));
      yield count;
      count++;
      if (count == 4) {
        _subscription.cancel();
      }
    }
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
