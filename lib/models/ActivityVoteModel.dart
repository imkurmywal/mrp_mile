import 'package:mrpmile/contracts/activity_vote_contracts/IModel.dart';

class ActivityVoteModel implements IModel {
  String _powerOnly, _dryVan, _reefer, _flatBed, _tanker;

  ActivityVoteModel(
      this._powerOnly, this._dryVan, this._reefer, this._flatBed, this._tanker);

  @override
  bool validate() {
    return (_powerOnly.isNotEmpty &&
            double.parse(_powerOnly) >= 1.6 &&
            double.parse(_powerOnly) <= 3.6) &&
        (_dryVan.isNotEmpty &&
            double.parse(_dryVan) >= 1.6 &&
            double.parse(_dryVan) <= 3.6) &&
        (_reefer.isNotEmpty &&
            double.parse(_reefer) >= 1.6 &&
            double.parse(_reefer) <= 3.6) &&
        (_flatBed.isNotEmpty &&
            double.parse(_flatBed) >= 1.6 &&
            double.parse(_flatBed) <= 3.6) &&
        (_tanker.isNotEmpty &&
            double.parse(_tanker) >= 1.6 &&
            double.parse(_tanker) <= 3.6);
  }
}
