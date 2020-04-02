import 'package:mrpmile/contracts/activity_video_comments_contracts/IModel.dart';

class ActivityVideoCommentsModel implements IModel {
  String _comment;

  ActivityVideoCommentsModel(this._comment);

  @override
  bool validate() {
    return _comment.isNotEmpty;
  }
}
