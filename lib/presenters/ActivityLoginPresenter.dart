import 'package:firebase_auth/firebase_auth.dart';
import 'package:mrpmile/contracts/login_contracts/IModel.dart';
import 'package:mrpmile/contracts/login_contracts/IPresenter.dart';
import 'package:mrpmile/contracts/login_contracts/IVIew.dart';
import 'package:mrpmile/models/ActvityLoginModel.dart';

class ActivityLoginPresenter implements IPresenter {
  String _email, _password;
  IModel _model;
  IView _view;

  ActivityLoginPresenter(this._view);

  @override
  void initValidation({String email, String password}) {
    this._email = email;
    this._password = password;
    _model = ActivityLoginModel(_email, _password);
    _view.onValidationResult(isValid: _model.validate());
  }

  @override
  void loginUser() {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: _email, password: _password)
        .then((response) async {
      var user = await FirebaseAuth.instance.currentUser();
      bool emailVerified = user.isEmailVerified;
      if (emailVerified) {
        _view.onLoginResult(success: true, exception: null);
      } else {
        _view.onLoginResult(success: false, exception: 'Email not verified');
      }
    }).catchError((error) {
      _view.onLoginResult(success: false, exception: error.message);
    });
  }
}
