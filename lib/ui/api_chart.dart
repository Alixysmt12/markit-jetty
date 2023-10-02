import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import '../controller/qa_achievement_controller.dart';
import '../controller/qa_fail_controller.dart';
import '../controller/qa_pass_controller.dart';
import '../controller/qa_status_controller.dart';
import '../models/qa_parse_model.dart';
import '../models/qa_pase_model_pass.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MyApiChart extends StatefulWidget {
  const MyApiChart({Key? key}) : super(key: key);

  @override
  State<MyApiChart> createState() => _MyApiChartState();
}

class _MyApiChartState extends State<MyApiChart> {
  late List<QaAchievementParseModel> _qaAchievement;
  late List<MyData> _qaStatus;
  late List<QaPassParseModel> _qaPass;
  late List<QaPassParseModel> _qaFail;
  late TooltipBehavior _tooltipBehavior;

  List<MyData> chartQaData = [];

  bool _isLoading = false;

  @override
  void initState() {
    //_loadResources();
    //_myData;
    // _qaStatus = getQaStatus();
    loadSalesData();
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

/*  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                buildSfCircularChart(),
                //buildSfCartesianChart(),
                //BarChartHorizontal(),
                //buildHorizontalChart(),
                //MyHorizontalChart(),
                //MyHorizontalFail(),
                //BarChartHorizontalFail(),
              ],
            ),
          )),
    );
  }*/

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 5), () {
      print("api call");
      getAllFutureData();
    });

/*    Future.delayed(Duration(seconds: 8), () {
      print("list data");
      loadSalesData();
    });*/
    return  SafeArea(
      child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: ()=>setState(() {
              loadSalesData();
            }),
            child: const Icon(Icons.refresh, color: Colors.white),
          ),
          body: /*StreamBuilder(
            //  stream: _myData(),
              builder: (context, snapshot) {
                return (SfCircularChart(
                  title: ChartTitle(text: "QA Status"),
                  legend: Legend(
                      isVisible: true,
                      overflowMode: LegendItemOverflowMode.wrap),
                  tooltipBehavior: _tooltipBehavior,
                  series: <CircularSeries>[
                    RadialBarSeries<MyData, String>(
                      dataSource: chartQaData,
                      xValueMapper: (MyData data, _) => data.legend,
                      yValueMapper: (MyData data, _) => data.value,
                      dataLabelSettings: DataLabelSettings(isVisible: true),
                      enableTooltip: true,
                      maximumValue: 10,
                    )
                  ],
                ));
              }))*/

      FutureBuilder(
            future:getAllFutureData(),
            builder: (context, snapshot) {
            //  if (snapshot.hasData) {
                return (SfCircularChart(
                  title: ChartTitle(text: "QA Status"),
                  legend:
                  Legend(isVisible: true,
                      overflowMode: LegendItemOverflowMode.wrap),
                  tooltipBehavior: _tooltipBehavior,
                  series: <CircularSeries>[
                    RadialBarSeries<MyData, String>(
                      dataSource: chartQaData,
                      xValueMapper: (MyData data, _) => data.legend,
                      yValueMapper: (MyData data, _) => data.value,
                      dataLabelSettings: DataLabelSettings(isVisible: true),
                      enableTooltip: true,
                      maximumValue: 2500,
                    )
                  ],

                ));
              //}
              // else {
              //   Center(child: CircularProgressIndicator(),);
              // }
            },
          )));
      //)
      /*,
    );*/
  }

  SfCircularChart buildSfCircularChart() {
    return SfCircularChart(
      title: ChartTitle(text: "QA Status"),
      legend:
          Legend(isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
      tooltipBehavior: _tooltipBehavior,
      series: <CircularSeries>[
        RadialBarSeries<MyData, String>(
          dataSource: _qaStatus,
          xValueMapper: (MyData data, _) => data.legend,
          yValueMapper: (MyData data, _) => data.value,
          dataLabelSettings: DataLabelSettings(isVisible: true),
          enableTooltip: true,
          maximumValue: 5,
        )
      ],
    );
  }

/*  List<MyData> getQaStatus() {
    //List<QaStatusParseModel> qaData = [];
    var field = Get.find<StatusQAController>();
    //field.mQaStatus();
    field.qaStatusAchievement;

    final List<MyData> chartData = [
      //MyData('LastDayQA', field.qaStatusAchievement[0].lastDayQa),
      MyData('Fail', field.qaStatusAchievement[0].fail),
      MyData('Pass', field.qaStatusAchievement[0].pass),
      MyData('Total', field.qaStatusAchievement[0].total)
    ];

    return chartData;
  }*/

  Future loadSalesData() async {
    var field = Get.find<StatusQAController>();
    field.qaStatusAchievement;
    final List<MyData> chartData = [
      //MyData('LastDayQA', field.qaStatusAchievement[0].lastDayQa),
      MyData('Fail', field.qaStatusAchievement[0].fail ?? 0),
      MyData('Pass', field.qaStatusAchievement[0].pass ?? 0),
      MyData('Total', field.qaStatusAchievement[0].total ?? 0)
    ];


    chartQaData.clear();
    chartQaData.addAll(chartData);
  }

  Stream<void> _myData() async*{
    while(true){
      var field = Get.find<StatusQAController>();
      field.qaStatusAchievement;
      final List<MyData> chartData = [
        //MyData('LastDayQA', field.qaStatusAchievement[0].lastDayQa),
        MyData('Fail', field.qaStatusAchievement[0].fail ?? 0),
        MyData('Pass', field.qaStatusAchievement[0].pass ?? 0),
        MyData('Total', field.qaStatusAchievement[0].total ?? 0)
      ];
      //chartQaData.addAll(chartData);
      yield chartData;
    }
  }
}

class MyData {
  final String legend;
  final int value;

  MyData(this.legend, this.value);
}

Future<void> getAllFutureData() async {
  await Get.find<StatusQAController>()
      .mQaStatus("7", "Wave - 8 June", "pass", "pending");
}
