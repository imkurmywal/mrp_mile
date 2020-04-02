import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mrpmile/contracts/activity_home_contracts/IPresenter.dart';
import 'package:mrpmile/contracts/activity_home_contracts/IView.dart';

class ActivityHomePresenter implements IPresenter {
  IView _view;
  List<DocumentSnapshot> _usersList = List();
  List<DocumentSnapshot> _adminData = List();

  ActivityHomePresenter(this._view);

  @override
  void getUsers() {
    Firestore.instance.collection('users').getDocuments().then((querySnapshot) {
      if (querySnapshot.documents.isNotEmpty) {
        querySnapshot.documents.forEach((documentSnapshot) {
          _usersList.add(documentSnapshot);
        });
        _view.onGetUsersResult(success: true, userList: _usersList);
      } else {
        _view.onGetUsersResult(success: false, userList: null);
      }
    }).catchError((error) {
      _view.onGetUsersResult(success: false, userList: null);
    });
  }

  getAdminData() {
    Firestore.instance
        .collection('admin_messages')
        .getDocuments()
        .then((querySnapshot) {
      if (querySnapshot.documents.isNotEmpty) {
        querySnapshot.documents.forEach((documentSnapshot) {
          _adminData.add(documentSnapshot);
        });
        _view.onGetAdminDataResult(success: true, adminDataList: _adminData);
      } else {
        _view.onGetAdminDataResult(success: true, adminDataList: null);
      }
    }).catchError((error) {
      _view.onGetAdminDataResult(success: true, adminDataList: null);
    });
  }
}
