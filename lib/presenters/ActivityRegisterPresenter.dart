import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mrpmile/contracts/register_contracts/IModel.dart';
import 'package:mrpmile/contracts/register_contracts/IPresenter.dart';
import 'package:mrpmile/contracts/register_contracts/IView.dart';
import 'package:mrpmile/models/ActivityRegisteredModel.dart';

class ActivityRegisterPresenter implements IPresenter {
  IView _view;
  IModel _model;
  String _firstName,
      _lastName,
      _email,
      _phone,
      _password,
      _dotNumber,
      _mcNumber;

  ActivityRegisterPresenter(this._view);

  @override
  void initValidation(
      {String firstName,
      String lastName,
      String email,
      String phone,
      String password,
      String confirmPassword,
      String dotNumber,
      String mcNumber}) {
    this._firstName = firstName;
    this._lastName = lastName;
    this._email = email;
    this._phone = phone;
    this._password = password;
    this._dotNumber = dotNumber;
    this._mcNumber = mcNumber;
    _model = ActivityRegisterModel(firstName, lastName, email, phone, password,
        confirmPassword, dotNumber, mcNumber);
    _view.onValidationResult(isValid: _model.validate());
  }

  @override
  void registerUser() {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: _email, password: _password)
        .then((response) {
      _view.onRegistrationResult(success: true, exception: null);
    }).catchError((error) {
      _view.onRegistrationResult(success: false, exception: error.message);
    });
  }

  @override
  void saveUserData() async {
    String uid = await (await FirebaseAuth.instance.currentUser()).uid;
    Map map = HashMap<String, Object>();
    map['first_name'] = _firstName;
    map['last_name'] = _lastName;
    map['user_email'] = _email;
    map['user_phone'] = _phone;
    map['user_dot_number'] = _dotNumber;
    map['user_mc_number'] = _mcNumber;
    Firestore.instance
        .collection('users')
        .document(uid)
        .setData(map)
        .then((response) {
      _view.onSaveDataResult(success: true, exception: null);
    }).catchError((error) {
      _view.onSaveDataResult(success: false, exception: error.message);
    });
  }

  @override
  void sendEmailVerification() async {
    var user = await FirebaseAuth.instance.currentUser();
    user.sendEmailVerification().then((response) {
      _view.onSendEmailVerificationResult(success: true, exception: null);
    }).catchError((error) {
      _view.onSendEmailVerificationResult(
          success: false, exception: error.message);
    });
  }
}
