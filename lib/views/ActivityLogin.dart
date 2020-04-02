import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mrpmile/contracts/login_contracts/IPresenter.dart';
import 'package:mrpmile/contracts/login_contracts/IVIew.dart';
import 'package:mrpmile/presenters/ActivityLoginPresenter.dart';
import 'package:mrpmile/utils/Fields.dart';
import 'package:mrpmile/utils/Utils.dart';
import 'package:mrpmile/views/ActivityForgotPassword.dart';
import 'package:mrpmile/views/ActivityHome.dart';
import 'package:mrpmile/views/ActivityPrivacyPolicy.dart';
import 'package:mrpmile/views/ActivityRegister.dart';
import 'package:mrpmile/views/ActivityWelcome.dart';

class ActivityLogin extends StatefulWidget {
  @override
  _ActivityLoginState createState() => _ActivityLoginState();
}

class _ActivityLoginState extends State<ActivityLogin> implements IView {
  var _emailController = TextEditingController();
  var _passwordController = TextEditingController();
  bool _emailError = false;
  bool _passwordError = false;
  IPresenter _presenter;
  bool _isLoading = false;

  @override
  void initState() {
    _presenter = ActivityLoginPresenter(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Log in'),
          leading: IconButton(
            icon: Icon(
              Icons.chevron_left,
              color: Colors.white,
            ),
            onPressed: () {
              Utils.changeScreen(context, ActivityWelcome());
            },
          ),
        ),
        body: _getBody(),
      ),
      onWillPop: () {
        Utils.changeScreen(context, ActivityWelcome());
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
                height: 16.0,
              ),
              Fields.getField(
                  controller: _emailController,
                  hint: 'Email',
                  isPassword: false,
                  isNumber: false,
                  isEmail: true,
                  isError: _emailError,
                  errorMessage: 'Cannot be empty'),
              SizedBox(
                height: 16.0,
              ),
              Fields.getField(
                  controller: _passwordController,
                  hint: 'Password',
                  isPassword: true,
                  isNumber: false,
                  isEmail: false,
                  isError: _passwordError,
                  errorMessage: 'Cannot be empty'),
              SizedBox(
                height: 32.0,
              ),
              GestureDetector(
                onTap: () {
                  Utils.changeScreen(context, ActivityForgotPassword());
                },
                child: Text(
                  'Forgot password?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 17.0,
                  ),
                ),
              ),
              SizedBox(
                height: 32.0,
              ),
              GestureDetector(
                onTap: () {
                  String email = _emailController.text.toString().trim();
                  String password = _passwordController.text.toString().trim();
                  setState(() {
                    if (email.isEmpty) {
                      _emailError = true;
                    } else {
                      _emailError = false;
                    }
                    if (password.isEmpty) {
                      _passwordError = true;
                    } else {
                      _passwordError = false;
                    }
                  });
                  _presenter.initValidation(email: email, password: password);
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
              SizedBox(
                height: 32.0,
              ),
              GestureDetector(
                onTap: () {
                  Utils.changeScreen(context, ActivityRegister());
                },
                child: Text(
                  'Don\'t have an account?\n\nCreate an account Now!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 17.0,
                  ),
                ),
              ),
              SizedBox(
                height: 32.0,
              ),
              GestureDetector(
                onTap: () {
                  Utils.changeScreen(context, ActivityPrivacyPolicy());
                },
                child: Text(
                  'Privacy Policy',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 21.0,
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
      });
      _presenter.loginUser();
    }
  }

  @override
  void onLoginResult({bool success, String exception}) {
    setState(() {
      _isLoading = false;
    });
    if (success) {
      Utils.changeScreen(context, ActivityHome());
    } else {
      Utils.showToast(message: exception);
    }
  }
}
