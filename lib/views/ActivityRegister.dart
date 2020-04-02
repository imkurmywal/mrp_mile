import 'package:flutter/material.dart';
import 'package:mrpmile/contracts/register_contracts/IPresenter.dart';
import 'package:mrpmile/contracts/register_contracts/IView.dart';
import 'package:mrpmile/presenters/ActivityRegisterPresenter.dart';
import 'package:mrpmile/utils/Fields.dart';
import 'package:mrpmile/utils/Utils.dart';
import 'package:mrpmile/views/ActivityRegistrationCompleted.dart';
import 'package:mrpmile/views/ActivityWelcome.dart';

class ActivityRegister extends StatefulWidget {
  @override
  _ActivityRegisterState createState() => _ActivityRegisterState();
}

class _ActivityRegisterState extends State<ActivityRegister> implements IView {
  var _firstNameController = TextEditingController();
  var _lastNameController = TextEditingController();
  var _phoneController = TextEditingController();
  var _emailController = TextEditingController();
  var _passwordController = TextEditingController();
  var _confirmPasswordController = TextEditingController();
  var _dotController = TextEditingController();
  var _mcController = TextEditingController();
  IPresenter _presenter;
  bool _isLoading = false;
  bool _firstNameError = false;
  bool _lasttNameError = false;
  bool _emailError = false;
  bool _phoneError = false;
  bool _passwordError = false;
  bool _confirmPasswordError = false;
  bool _dotError = false;
  bool _mcError = false;
  String _errorMessage = 'Cannot be empty';
  String _passwordDonotMatchErrorText = 'Password do not match';
  String _dotErrorMessage = 'Cannot be empty or less than 7';
  String _mcErrorMessage = 'Cannot be empty or less than 7';
  bool _passwordDifference = false;

  @override
  void initState() {
    _presenter = ActivityRegisterPresenter(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Create an account'),
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
              Fields.getField(
                controller: _firstNameController,
                hint: 'First Name',
                isPassword: false,
                isNumber: false,
                isEmail: false,
                isError: _firstNameError,
                errorMessage: _errorMessage,
              ),
              SizedBox(
                height: 16.0,
              ),
              Fields.getField(
                controller: _lastNameController,
                hint: 'Last Name',
                isPassword: false,
                isNumber: false,
                isEmail: false,
                isError: _lasttNameError,
                errorMessage: _errorMessage,
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
                errorMessage: _errorMessage,
              ),
              SizedBox(
                height: 16.0,
              ),
              Fields.getField(
                controller: _phoneController,
                hint: 'Phone',
                isPassword: false,
                isNumber: true,
                isEmail: true,
                isError: _phoneError,
                errorMessage: _errorMessage,
              ),
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
                errorMessage: _errorMessage,
              ),
              SizedBox(
                height: 16.0,
              ),
              Fields.getField(
                controller: _confirmPasswordController,
                hint: 'Confirm Password',
                isPassword: true,
                isNumber: false,
                isEmail: false,
                isError: _confirmPasswordError,
                errorMessage: _passwordDifference
                    ? _passwordDonotMatchErrorText
                    : _errorMessage,
              ),
              SizedBox(
                height: 16.0,
              ),
              Fields.getField(
                controller: _dotController,
                hint: 'US DOT #',
                isPassword: false,
                isNumber: true,
                isEmail: false,
                isError: _dotError,
                errorMessage: _dotErrorMessage,
              ),
              SizedBox(
                height: 16.0,
              ),
              Fields.getField(
                controller: _mcController,
                hint: 'MC #',
                isPassword: false,
                isNumber: true,
                isEmail: false,
                isError: _mcError,
                errorMessage: _mcErrorMessage,
              ),
              SizedBox(
                height: 32.0,
              ),
              GestureDetector(
                onTap: () {
                  String firstName =
                      _firstNameController.text.toString().trim();
                  String lastName = _lastNameController.text.toString().trim();
                  String email = _emailController.text.toString().trim();
                  String phone = _phoneController.text.toString().trim();
                  String password = _passwordController.text.toString().trim();
                  String confirmPassword =
                      _confirmPasswordController.text.toString().trim();
                  String dotNumber = _dotController.text.toString().trim();
                  String mcNumber = _mcController.text.toString().trim();
                  setState(() {
                    if (firstName.isEmpty) {
                      _firstNameError = true;
                    } else {
                      _firstNameError = false;
                    }
                    if (lastName.isEmpty) {
                      _lasttNameError = true;
                    } else {
                      _lasttNameError = false;
                    }
                    if (email.isEmpty) {
                      _emailError = true;
                    } else {
                      _emailError = false;
                    }
                    if (phone.isEmpty) {
                      _phoneError = true;
                    } else {
                      _phoneError = false;
                    }
                    if (password.isEmpty) {
                      _passwordError = true;
                    } else {
                      _passwordError = false;
                    }
                    if (confirmPassword.isEmpty) {
                      _confirmPasswordError = true;
                    } else {
                      _confirmPasswordError = false;
                    }
                    if (dotNumber.isEmpty || dotNumber.length < 7) {
                      _dotError = true;
                    } else {
                      _dotError = false;
                    }
                    if (mcNumber.isEmpty || mcNumber.length < 7) {
                      _mcError = true;
                    } else {
                      _mcError = false;
                    }
                    if (password != confirmPassword) {
                      _confirmPasswordError = true;
                      _passwordDifference = true;
                    } else {
                      _confirmPasswordError = false;
                      _passwordDifference = false;
                    }
                  });
                  _presenter.initValidation(
                    firstName: firstName,
                    lastName: lastName,
                    email: email,
                    phone: phone,
                    password: password,
                    confirmPassword: confirmPassword,
                    dotNumber: dotNumber,
                    mcNumber: mcNumber,
                  );
                },
                child: Container(
                  height: 50.0,
                  alignment: Alignment.center,
                  color: Theme.of(context).accentColor,
                  child: Text(
                    'Submit',
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
        _presenter.registerUser();
      });
    }
  }

  @override
  void onRegistrationResult({bool success, String exception}) {
    if (success) {
      _presenter.saveUserData();
    } else {
      setState(() {
        _isLoading = false;
        Utils.showToast(message: exception);
      });
    }
  }

  @override
  void onSaveDataResult({bool success, String exception}) {
    if (success) {
      _presenter.sendEmailVerification();
    } else {
      setState(() {
        _isLoading = false;
        Utils.showToast(message: exception);
      });
    }
  }

  @override
  void onSendEmailVerificationResult({bool success, String exception}) {
    if (success) {
      Utils.changeScreen(context, ActivityRegistrationCompleted());
    } else {
      setState(() {
        _isLoading = false;
        Utils.showToast(message: exception);
      });
    }
  }
}
