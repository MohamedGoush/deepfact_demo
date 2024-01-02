import 'dart:async';

import 'package:deepfact_demo/controllers/csv_controller.dart';
import 'package:deepfact_demo/models/ecg_data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CSVController(),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    ),
  );
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var data = ["bismillah"];

    return Scaffold(
      appBar: AppBar(
        title: Text(data[0]),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Consumer<CSVController>(
          builder: (context, csv, child) => Column(
            children: [
              Container(
                height: 250,
                width: double.infinity,
                // color: Colors.grey,
                child: SfCartesianChart(
                  legend: Legend(isVisible: true),
                  series: [
                    LineSeries<ECGDataModel, int>(
                      onRendererCreated: (controller) {
                        csv.chartSeriesController = controller;
                      },
                      name: csv.headers[0],
                      xValueMapper: (ecg, index) => index,
                      yValueMapper: (ecg, index) => ecg.i,
                      dataSource: csv.ecg_model_list,
                    ),
                  ],
                  primaryXAxis: NumericAxis(
                    edgeLabelPlacement: EdgeLabelPlacement.shift,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     var csvController =
      //         Provider.of<CSVController>(context, listen: false);
      //     print(data);
      //     data = csvController.headers;
      //     print(data);
      //   },
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}
