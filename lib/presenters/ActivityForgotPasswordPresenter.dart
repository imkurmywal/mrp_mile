import 'package:firebase_auth/firebase_auth.dart';
import 'package:mrpmile/contracts/forgot_password_contracts/IModel.dart';
import 'package:mrpmile/contracts/forgot_password_contracts/IPresenter.dart';
import 'package:mrpmile/contracts/forgot_password_contracts/IView.dart';
import 'package:mrpmile/models/ActivityForgotPasswordModel.dart';

class ActivityForgotPasswordPresenter implements IPresenter {
  IView _view;
  IModel _model;
  String _email;

  ActivityForgotPasswordPresenter(this._view);

  @override
  void initValidation({String email}) {
    this._email = email;
    _model = ActivityForgotPasswordModel(_email);
    _view.onValidationResult(isValid: _model.validate());
  }

  @override
  void sendPasswordResetLink() {
    FirebaseAuth.instance
        .sendPasswordResetEmail(email: _email)
        .then((response) {
      _view.onSendResetLinkResult(success: true, exception: null);
    }).catchError((error) {
      _view.onSendResetLinkResult(success: false, exception: error.message);
    });
  }
}
