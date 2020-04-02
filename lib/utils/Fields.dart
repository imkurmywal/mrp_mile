import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mrpmile/utils/Constants.dart';

class Fields {
  static getField(
      {@required TextEditingController controller,
      @required String hint,
      @required bool isPassword,
      @required bool isNumber,
      @required bool isEmail,
      @required bool isError,
      @required String errorMessage}) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      keyboardType: isNumber
          ? TextInputType.number
          : isEmail ? TextInputType.emailAddress : TextInputType.text,
      decoration: InputDecoration(
          labelText: hint, errorText: !isError ? null : errorMessage),
    );
  }

  static getVotingField({
    @required TextEditingController controller,
    @required String hint,
  }) {
    return TextField(
      controller: controller,
      textAlign: TextAlign.center,
      keyboardType: TextInputType.number,
      style: TextStyle(
        fontSize: 35.0,
        color: Constants.greenColor,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          color: Constants.greenColor,
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
      ),
    );
  }
}
