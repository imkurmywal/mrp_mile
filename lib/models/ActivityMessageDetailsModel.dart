import 'package:mrpmile/contracts/ActivityMessageDetailsContracts/IModel.dart';

class ActivityMessageDetailsModel implements IModel {
  String _comment;

  ActivityMessageDetailsModel(this._comment);

  @override
  bool validate() {
    return _comment.isNotEmpty;
  }
}
