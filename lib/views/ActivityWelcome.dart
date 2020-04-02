import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mrpmile/utils/Constants.dart';
import 'package:mrpmile/utils/Utils.dart';
import 'package:mrpmile/views/ActivityLogin.dart';
import 'package:mrpmile/views/ActivityRegister.dart';

class ActivityWelcome extends StatefulWidget {
  @override
  _ActivityWelcomeState createState() => _ActivityWelcomeState();
}

class _ActivityWelcomeState extends State<ActivityWelcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.all(32.0),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 32.0,
              ),
              Text(
                'WELCOME TO',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 35.0,
                ),
              ),
              SizedBox(
                height: 16.0,
              ),
              Image(
                image: AssetImage('images/logo.png'),
                height: 80.0,
              ),
              SizedBox(
                height: 16.0,
              ),
              Text(
                'for',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24.0,
                ),
              ),
              Text(
                'OWNER OPERATOR',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24.0,
                ),
              ),
              SizedBox(
                height: 150.0,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Utils.changeScreen(context, ActivityLogin());
                      },
                      child: Container(
                        height: 50.0,
                        alignment: Alignment.center,
                        color: Theme.of(context).accentColor,
                        child: Text(
                          'Log in',
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
              SizedBox(
                height: 16.0,
              ),
              GestureDetector(
                onTap: () {
                  Utils.changeScreen(context, ActivityRegister());
                },
                child: Text(
                  'Create an account',
                  style: TextStyle(
                    fontSize: 17.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
