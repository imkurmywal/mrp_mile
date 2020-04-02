import 'package:mrpmile/contracts/register_contracts/IModel.dart';
import 'package:mrpmile/utils/Utils.dart';

class ActivityRegisterModel implements IModel {
  String _firstName,
      _lastName,
      _email,
      _phone,
      _password,
      _confirmPassword,
      _dotNumber,
      _mcNumber;

  ActivityRegisterModel(
      this._firstName,
      this._lastName,
      this._email,
      this._phone,
      this._password,
      this._confirmPassword,
      this._dotNumber,
      this._mcNumber);

  @override
  bool validate() {
    return _firstName.isNotEmpty &&
        _lastName.isNotEmpty &&
        _phone.isNotEmpty &&
        _password.isNotEmpty &&
        _confirmPassword.isNotEmpty &&
        _dotNumber.isNotEmpty &&
        _mcNumber.isNotEmpty &&
        _mcNumber.length >= 7 &&
        _dotNumber.length >= 7 &&
        _password == _confirmPassword;
  }
}
