// import 'package:deepfact_demo/controllers/csv_controller.dart';
// import 'package:deepfact_demo/models/ecg_data_model.dart';
// import 'package:flutter/material.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';

// class CustomLineChart extends StatelessWidget {
//   final CSVController csv;
//   final int? index;
//   const CustomLineChart({
//     super.key,
//     required this.csv,
//     this.index,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 250,
//       width: double.infinity,
//       // color: Colors.grey,
//       child: SfCartesianChart(
//         legend: Legend(isVisible: true),
//         series: [
//           LineSeries<ECGDataModel, int>(
//             name: csv.headers[index!],
//             xValueMapper: (ecg, index) => index,
//             yValueMapper: (ecg, index) => ecg.ii,
//             dataSource: csv.ecg_model_list,
//           )
//         ],
//       ),
//     );
//   }
// }
