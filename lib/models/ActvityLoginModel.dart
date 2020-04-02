import 'package:mrpmile/contracts/login_contracts/IModel.dart';
import 'package:mrpmile/utils/Utils.dart';

class ActivityLoginModel implements IModel {
  String _email;
  String _password;

  ActivityLoginModel(this._email, this._password);

  @override
  bool validate() {
    return _email.isNotEmpty && _password.isNotEmpty;
  }
}
