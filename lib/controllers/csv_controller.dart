import 'dart:async';

import 'package:deepfact_demo/models/ecg_data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CSVController extends ChangeNotifier {
  CSVController() {
    Timer.periodic(Duration(seconds: 1), updateData);
    loadCSV();
  }

  ChartSeriesController? chartSeriesController;

  double? i, v1, v2, v3, v4, v5, v6, ii, iii, avr, avl, avf;

  var ecg_index = 20;

  List<String> lines = [];
  List<String> headers = [
    "i",
    "v1",
    "v2",
    "v3",
    "v4",
    "v5",
    "v6",
    "ii",
    "iii",
    "avr",
    "avl",
    "avf"
  ];
  List<ECGDataModel> ecg_model_core_list = [];
  List<ECGDataModel> ecg_model_list = [];

  void loadCSV() async {
    String _rawData = await rootBundle.loadString("assets/csv/output.csv");
    var ex = RegExp(r'\n');

    lines = _rawData.split(ex);
    // print(lines.length);
    for (var index = 0; index < lines.length; index++) {
      if (index == 0) {
        readHeader(lines[index]);
      } else {
        convertToListString(lines[index], index);
      }
    }

    notifyListeners();
  }

  void convertToListString(String data, int index) {
    var datam = data.split(',');
    // print(datam);
    i = double.parse(datam[0]);
    v1 = double.parse(datam[1]);
    v2 = double.parse(datam[2]);
    v3 = double.parse(datam[3]);
    v4 = double.parse(datam[4]);
    v5 = double.parse(datam[5]);
    v6 = double.parse(datam[6]);
    ii = double.parse(datam[7]);
    iii = double.parse(datam[8]);
    avr = double.parse(datam[9]);
    avl = double.parse(datam[10]);
    avf = double.parse(datam[11]);

    ecg_model_core_list
        .add(ECGDataModel(i, v1, v2, v3, v4, v5, v6, ii, iii, avr, avl, avf));
    if (index < 21) {
      ecg_model_list
          .add(ECGDataModel(i, v1, v2, v3, v4, v5, v6, ii, iii, avr, avl, avf));
    }
    print(i);
    notifyListeners();
  }

  void readHeader(String data) {
    // print(data);
    var _headers = data.split(',');
    headers = _headers;
    notifyListeners();
  }

  void updateData(Timer timer) {
    ecg_model_list.add(ecg_model_core_list.elementAt(ecg_index));
    ecg_model_list.removeAt(0);
    chartSeriesController!.updateDataSource(
      addedDataIndex: ecg_model_list.length - 1,
      removedDataIndex: 0,
    );

    ecg_index++;
    notifyListeners();
  }
}
