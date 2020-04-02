import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mrpmile/contracts/utils_contracts/IUtils.dart';
import 'package:mrpmile/utils/Utils.dart';
import 'package:mrpmile/views/ActivityLiveVoteResults.dart';
import 'package:mrpmile/views/ActivityLogin.dart';
import 'package:mrpmile/views/ActivityMrpFormulae.dart';
import 'package:mrpmile/views/ActivityPrviousResult.dart';
import 'package:mrpmile/views/ActivityWeeklyMrpMile.dart';

class SideDrawer extends StatefulWidget {
  @override
  _SideDrawerState createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> implements IUtils{
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 32.0, right: 32.0, top: 32.0),
            child: Image(
              image: AssetImage('images/logo.png'),
            ),
          ),
          SizedBox(
            height: 32.0,
          ),
          ListTile(
            dense: true,
            title: Text(
              'Weekly MRPmile',
              style: TextStyle(
                fontSize: 15.0,
              ),
            ),
            onTap: () {
              Utils.changeScreen(context, ActivityWeeklyMrpMile());
            },
          ),
          ListTile(
            dense: true,
            title: Text(
              'Live voting',
              style: TextStyle(
                fontSize: 15.0,
              ),
            ),
            onTap: () {
              Utils.changeScreen(context, ActivityLiveVoteResults(true));
            },
          ),
          ListTile(
            dense: true,
            title: Text(
              'MRPmile calculator',
              style: TextStyle(
                fontSize: 15.0,
              ),
            ),
            onTap: () {
              Utils.changeScreen(context, ActivityMrpFormulae());
            },
          ),
          ListTile(
            dense: true,
            title: Text(
              'Previous MRPmile',
              style: TextStyle(
                fontSize: 15.0,
              ),
            ),
            onTap: () {
              Utils.changeScreen(context, ActivityPreviousResult());
            },
          ),
          ListTile(
            dense: true,
            title: Text(
              'Subscribe',
              style: TextStyle(
                fontSize: 15.0,
              ),
            ),
            onTap: () {
              Navigator.of(context).pop();
              Utils.showSubscriptionDialog(36,context, this);
            },
          ),
          ListTile(
            dense: true,
            title: Text(
              'Log out',
              style: TextStyle(
                fontSize: 15.0,
              ),
            ),
            onTap: () {
              Navigator.of(context).pop();
              _showDialog();
            },
          ),
        ],
      ),
    );
  }

  _showDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Message!'),
            content: Text('Are you sure you want to log out?'),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Cancel'),
              ),
              FlatButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.of(context).pop();
                  Utils.changeScreen(context, ActivityLogin());
                },
                child: Text('Log out'),
              ),
            ],
          );
        });
  }

  @override
  void onPaymentResult(bool success) {
    print('response from DRAWER');
  }
}
