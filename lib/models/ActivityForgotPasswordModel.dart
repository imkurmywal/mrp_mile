import 'package:mrpmile/contracts/forgot_password_contracts/IModel.dart';
import 'package:mrpmile/utils/Utils.dart';

class ActivityForgotPasswordModel implements IModel {
  String _email;

  ActivityForgotPasswordModel(this._email);

  @override
  bool validate() {
    return _email.isNotEmpty;
  }
}
