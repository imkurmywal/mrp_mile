import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:mrpmile/models/GraphModel.dart';
import 'package:mrpmile/utils/Constants.dart';

class ProfitChart extends StatelessWidget {
  final List<GraphModel> _data;

  ProfitChart(this._data);

  @override
  Widget build(BuildContext context) {
    List<charts.Series<GraphModel, String>> _series = [
    charts.Series(
      id: 'm_graph',
      data: _data,
      domainFn: (obj, _) => obj.week,
      measureFn: (obj, _) => obj.value,
      colorFn: (obj, _) =>
          charts.ColorUtil.fromDartColor(Constants.greenColor))
      ];
      return charts.BarChart(
      _series,
      animate: true,
    );
  }
}
