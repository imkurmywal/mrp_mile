import 'package:flutter/material.dart';

abstract class IPresenter {
  void initValidation({
    @required String firstName,
    @required String lastName,
    @required String email,
    @required String phone,
    @required String password,
    @required String confirmPassword,
    @required String dotNumber,
    @required String mcNumber,
  });

  void registerUser();

  void saveUserData();

  void sendEmailVerification();
}
