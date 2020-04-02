import 'package:flutter/material.dart';
import 'package:mrpmile/contracts/forgot_password_contracts/IPresenter.dart';
import 'package:mrpmile/contracts/forgot_password_contracts/IView.dart';
import 'package:mrpmile/presenters/ActivityForgotPasswordPresenter.dart';
import 'package:mrpmile/utils/Fields.dart';
import 'package:mrpmile/utils/Utils.dart';
import 'package:mrpmile/views/ActivityLogin.dart';
import 'package:mrpmile/views/ActivityWelcome.dart';

class ActivityForgotPassword extends StatefulWidget {
  @override
  _ActivityForgotPasswordState createState() => _ActivityForgotPasswordState();
}

class _ActivityForgotPasswordState extends State<ActivityForgotPassword>
    implements IView {
  var _emailController = TextEditingController();
  IPresenter _presenter;
  bool _emailError = false;

  var _isLoading = false;

  @override
  void initState() {
    _presenter = ActivityForgotPasswordPresenter(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Forgot password'),
          leading: IconButton(
            icon: Icon(Icons.chevron_left),
            onPressed: () {
              Utils.changeScreen(context, ActivityLogin());
            },
          ),
        ),
        body: _getBody(),
      ),
      onWillPop: () {
        Utils.changeScreen(context, ActivityLogin());
      },
    );
  }

  _getBody() {
    return Stack(
      children: <Widget>[
        Container(
          color: Colors.white,
          padding:
              EdgeInsets.only(left: 32.0, right: 32.0, bottom: 32.0, top: 16.0),
          child: ListView(
            children: <Widget>[
              Image(
                image: AssetImage('images/logo.png'),
                height: 80.0,
              ),
              SizedBox(
                height: 32.0,
              ),
              Fields.getField(
                controller: _emailController,
                hint: 'Email',
                isPassword: false,
                isNumber: false,
                isEmail: true,
                isError: _emailError,
                errorMessage: 'Cannot be empty'
              ),
              SizedBox(
                height: 32.0,
              ),
              GestureDetector(
                onTap: () {
                  String email = _emailController.text.toString().trim();
                  setState(() {
                    if (email.isEmpty) {
                      _emailError = true;
                    } else {
                      _emailError = false;
                    }
                  });
                  _presenter.initValidation(email: email);
                },
                child: Container(
                  height: 50.0,
                  alignment: Alignment.center,
                  color: Theme.of(context).accentColor,
                  child: Text(
                    'Send password reset link',
                    style: TextStyle(
                      fontSize: 19.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 32.0,
              ),
              GestureDetector(
                onTap: () {
                  Utils.changeScreen(context, ActivityLogin());
                },
                child: Text(
                  'Back to Login!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 17.0,
                  ),
                ),
              ),
            ],
          ),
        ),
        _isLoading ? Utils.loadingContainer() : Container(),
      ],
    );
  }

  @override
  void onValidationResult({bool isValid}) {
    if (isValid) {
      setState(() {
        _isLoading = true;
        _presenter.sendPasswordResetLink();
      });
    }
  }

  @override
  void onSendResetLinkResult({bool success, String exception}) {
    setState(() {
      _isLoading = false;
      if (success) {
        Utils.showToast(message: 'A reset link was sent to your email address');
        Utils.changeScreen(context, ActivityWelcome());
      } else {
        Utils.showToast(message: exception);
      }
    });
  }
}
