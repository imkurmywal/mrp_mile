import 'package:flutter/material.dart';
import 'package:mrpmile/utils/Utils.dart';
import 'package:mrpmile/views/ActivityLogin.dart';
import 'package:mrpmile/views/ActivityRegister.dart';

class ActivityRegistrationCompleted extends StatefulWidget {
  @override
  _ActivityRegistrationCompletedState createState() =>
      _ActivityRegistrationCompletedState();
}

class _ActivityRegistrationCompletedState
    extends State<ActivityRegistrationCompleted> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Registration completed'),
          leading: IconButton(
            icon: Icon(Icons.keyboard_arrow_left),
            onPressed: () {
              Utils.changeScreen(context, ActivityRegister());
            },
          ),
        ),
        body: _getBody(),
      ),
      onWillPop: () {
        Utils.changeScreen(context, ActivityRegister());
      },
    );
  }

  _getBody() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(32.0),
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
            SizedBox(
              height: 55.0,
            ),
            Text(
              'Thank you for your \nRegistration!\n\n\nAn email was sent to you\nPlease confirm your email\nbefore you log in.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 17.0),
            ),
            SizedBox(
              height: 40.0,
            ),
            GestureDetector(
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
          ],
        ),
      ),
    );
  }
}
