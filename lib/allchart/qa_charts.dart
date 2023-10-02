import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:markit_jetty/controller/batch_controller.dart';
import 'package:markit_jetty/controller/overall_achievement.dart';
import 'package:markit_jetty/controller/qa_achievement_controller.dart';
import 'package:markit_jetty/controller/qa_fail_controller.dart';
import 'package:markit_jetty/controller/qa_pass_controller.dart';
import 'package:markit_jetty/controller/qa_status_controller.dart';
import 'package:markit_jetty/controller/sync_wise_controller.dart';
import 'package:markit_jetty/home_page.dart';
import 'package:markit_jetty/models/batch_passing_model.dart';
import 'package:markit_jetty/models/qa_fail_model.dart';
import 'package:markit_jetty/models/qa_parse_model.dart';
import 'package:markit_jetty/models/qa_pase_model_pass.dart';
import 'package:markit_jetty/models/qa_pass_model.dart';
import 'package:markit_jetty/models/status_qa_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../controller/wave_controller_one_off.dart';
import '../controller/wave_project_controller.dart';
import '../models/qa_overall.dart';
import '../models/sync_wise_model.dart';
import '../utils/app_constants.dart';
import '../widget/input_field.dart';

class CircularChart extends StatefulWidget {
  final sampleQuotaAllocation;
  final projectClassificationTypeId;
  final quotaStatus;

  const CircularChart({Key? key, required this.sampleQuotaAllocation,required this.projectClassificationTypeId,required this.quotaStatus})
      : super(key: key);

  @override
  State<CircularChart> createState() => _CircularChartState();
}

class _CircularChartState extends State<CircularChart> {
  List<MyData2> _myDataQAAchievement = [];
  List<SyncWiseModel> _syncWiseDataList = [];
  List<BatchPassingModel> _batchData = [];
  List<CutOffField> _cutOffField = [];
  List<SampleData> oneOffList = [];
  List<CutOffData> cutoffdata = [];

  //late List<QaAchievementParseModel> _qaAchievement;
  late List<MyData> _qaStatus;
  late List<QaPassModel> _qaPass = [];
  late List<QaFailModel> _qaFail = [];
  late List<QaOverAllModel> _overAll = [];

  late List<GDPDataABC> _chartDataABC;

  late List<ExpenseData> _chartData2;
  late List<ExpenseData> _chartData3;
  late List<ExpenseData> _chartData4;
  late List<GDPData> _chartData;
  late List<SampleData> _sampleData;
  late List<CutOffField> _cutOffFieldData;
  late List<GDPData> _chartDataHor;
  late TooltipBehavior _tooltipBehavior;
  late TooltipBehavior _tooltipBehaviorQAAch;
  late TooltipBehavior _tooltipBehaviorQAPass;
  late TooltipBehavior _tooltipBehaviorQAFail;

  @override
  void initState() {
    //_sampleData = getSample();
    // _cutOffFieldData = cutOff();

    getFailQa();
    getOverAllQa();
    getPassQa();
    getBatchPercentData();
    getQaAchievement();
    getSyncWiseData();

    if (widget.projectClassificationTypeId == AppConstants.ONE_OFF) {
      getCutOff();
      getOneOffWave();
    }else{
      getCutOffTracking();
      getOneOffWaveSampleTracking();
    }

    _qaStatus = getQaStatus();

    _chartDataABC = getChartDataABC();
    _chartData = getChartData();
    _chartDataHor = getChartData();
    _chartData2 = getChartData2();
    _chartData3 = getChartData2();
    _chartData4 = getChartData2();
    _tooltipBehavior = TooltipBehavior(enable: true);
    _tooltipBehaviorQAAch = TooltipBehavior(enable: true);
    _tooltipBehaviorQAPass = TooltipBehavior(enable: true);
    _tooltipBehaviorQAFail = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () => setState(() {
              getBatchPercentData();
              _qaStatus = getQaStatus();
              getQaAchievement();
              getFailQa();
              getPassQa();
              getOverAllQa();
            }),
            child: const Icon(Icons.refresh, color: Colors.white),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                buildSfCircularChart(),
                buildSfCartesianChart(),
                //BarChartHorizontal(),
                //buildHorizontalChart(),
                MyHorizontalChart(),
                MyHorizontalFail(),
                //  MyHorizontalQAOverAll(),
                //BarChartHorizontalFail(),
              ],
            ),
          )),
    );
  }

/*  SfCartesianChart BarChartHorizontalFail() {
    return SfCartesianChart(
      title: ChartTitle(text: 'QA Fail'),
      legend: Legend(isVisible: true),
      tooltipBehavior: _tooltipBehavior,
      series: <ChartSeries>[
        StackedBarSeries<ExpenseData, String>(
            dataSource: _chartData4,
            xValueMapper: (ExpenseData exp, _) => exp.expenseCategory,
            yValueMapper: (ExpenseData exp, _) => exp.father,
            name: 'Father',
            color: Colors.green,
            markerSettings: MarkerSettings(
              isVisible: true,
            )),
        StackedBarSeries<ExpenseData, String>(
            dataSource: _chartData4,
            xValueMapper: (ExpenseData exp, _) => exp.expenseCategory,
            yValueMapper: (ExpenseData exp, _) => exp.mother,
            name: 'Mother',
            color: Colors.blueAccent,
            markerSettings: MarkerSettings(
              isVisible: true,
            )),
        StackedBarSeries<ExpenseData, String>(
            dataSource: _chartData4,
            xValueMapper: (ExpenseData exp, _) => exp.expenseCategory,
            yValueMapper: (ExpenseData exp, _) => exp.son,
            name: 'Son',
            color: Colors.amber,
            markerSettings: MarkerSettings(
              isVisible: true,
            )),
        StackedBarSeries<ExpenseData, String>(
            dataSource: _chartData4,
            xValueMapper: (ExpenseData exp, _) => exp.expenseCategory,
            yValueMapper: (ExpenseData exp, _) => exp.daughter,
            name: 'Daughter',
            color: Colors.purple,
            markerSettings: MarkerSettings(
              isVisible: true,
            )),
      ],
      primaryXAxis: CategoryAxis(),
    );
  }*/

  SfCartesianChart BarChartHorizontal() {
    return SfCartesianChart(
      title: ChartTitle(text: 'QA Pass'),
      legend: Legend(isVisible: true),
      tooltipBehavior: _tooltipBehavior,
      series: <ChartSeries>[
        StackedBarSeries<ExpenseData, String>(
            dataSource: _chartData3,
            xValueMapper: (ExpenseData exp, _) => exp.expenseCategory,
            yValueMapper: (ExpenseData exp, _) => exp.father,
            name: 'Father',
            markerSettings: MarkerSettings(
              isVisible: true,
            )),
        StackedBarSeries<ExpenseData, String>(
            dataSource: _chartData3,
            xValueMapper: (ExpenseData exp, _) => exp.expenseCategory,
            yValueMapper: (ExpenseData exp, _) => exp.mother,
            name: 'Mother',
            markerSettings: MarkerSettings(
              isVisible: true,
            )),
        StackedBarSeries<ExpenseData, String>(
            dataSource: _chartData3,
            xValueMapper: (ExpenseData exp, _) => exp.expenseCategory,
            yValueMapper: (ExpenseData exp, _) => exp.son,
            name: 'Son',
            markerSettings: MarkerSettings(
              isVisible: true,
            )),
        StackedBarSeries<ExpenseData, String>(
            dataSource: _chartData3,
            xValueMapper: (ExpenseData exp, _) => exp.expenseCategory,
            yValueMapper: (ExpenseData exp, _) => exp.daughter,
            name: 'Daughter',
            markerSettings: MarkerSettings(
              isVisible: true,
            )),
      ],
      primaryXAxis: CategoryAxis(),
    );
  }

  SfCartesianChart MyHorizontalChart() {
    return SfCartesianChart(
      title: ChartTitle(text: "QA Pass"),
      legend: Legend(isVisible: true, position: LegendPosition.bottom),
      tooltipBehavior: _tooltipBehaviorQAPass,
      series: <ChartSeries>[
        BarSeries<QaPassModel, String>(
            name: 'QA Pass',
            dataSource: _qaPass,
            xValueMapper: (QaPassModel data, _) => data.label,
            yValueMapper: (QaPassModel data, _) => data.y,
            dataLabelSettings: DataLabelSettings(isVisible: true),
            sortingOrder: SortingOrder.descending,
            sortFieldValueMapper: (QaPassModel data, _) => data.label,
            enableTooltip: true,
            color: Colors.green),
      ],
      primaryXAxis: CategoryAxis(),
      /*    primaryYAxis: NumericAxis(
          edgeLabelPlacement: EdgeLabelPlacement.shift,
          numberFormat: NumberFormat.simpleCurrency(decimalDigits: 0),
          title: AxisTitle(text: "QA")),*/
    );
  }

  SfCartesianChart MyHorizontalFail() {
    return SfCartesianChart(
      title: ChartTitle(text: "QA Fail"),
      legend: Legend(isVisible: true, position: LegendPosition.bottom),
      tooltipBehavior: _tooltipBehaviorQAFail,
      series: <ChartSeries>[
        BarSeries<QaFailModel, String>(
            name: 'QA Fail',
            dataSource: _qaFail,
            xValueMapper: (QaFailModel data, _) => data.label,
            yValueMapper: (QaFailModel data, _) => data.y,
            dataLabelSettings: DataLabelSettings(isVisible: true),
            enableTooltip: true,
            sortingOrder: SortingOrder.descending,
            sortFieldValueMapper: (QaFailModel data, _) => data.label,
            color: Colors.redAccent),
      ],
      primaryXAxis: CategoryAxis(),
      /*   primaryYAxis: NumericAxis(
          edgeLabelPlacement: EdgeLabelPlacement.shift,
          numberFormat: NumberFormat.simpleCurrency(decimalDigits: 0),
          title: AxisTitle(text: "QA")),*/
    );
  }

  SfCartesianChart MyHorizontalQAOverAll() {
    return SfCartesianChart(
      title: ChartTitle(text: "Overall Achievement"),
      legend: Legend(isVisible: true, position: LegendPosition.bottom),
      tooltipBehavior: _tooltipBehavior,
      series: <ChartSeries>[
        BarSeries<QaOverAllModel, String>(
          name: 'OverAll Achv.',
          dataSource: _overAll,
          xValueMapper: (QaOverAllModel data, _) => data.label,
          yValueMapper: (QaOverAllModel data, _) => data.y,
          dataLabelSettings: DataLabelSettings(isVisible: true),
          enableTooltip: true,
        ),
      ],
      primaryXAxis: CategoryAxis(),
      /*primaryYAxis: NumericAxis(
          edgeLabelPlacement: EdgeLabelPlacement.shift,
          numberFormat: NumberFormat.simpleCurrency(decimalDigits: 0),
          title: AxisTitle(text: "QA")),*/
    );
  }

  SfCartesianChart buildHorizontalChart() {
    return SfCartesianChart(
      title: ChartTitle(text: "QA Pass"),
      legend:
          Legend(isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
      tooltipBehavior: _tooltipBehavior,
      series: <ChartSeries>[
        BarSeries<GDPData, String>(
            dataSource: _chartDataHor,
            xValueMapper: (GDPData gdp, _) => gdp.continent,
            yValueMapper: (GDPData gdp, _) => gdp.gdp,
            dataLabelSettings: DataLabelSettings(isVisible: true),
            enableTooltip: true),
      ],
      primaryYAxis: CategoryAxis(),
      primaryXAxis: NumericAxis(
          edgeLabelPlacement: EdgeLabelPlacement.shift,
          numberFormat: NumberFormat.simpleCurrency(decimalDigits: 0)),
    );
  }

  SfCircularChart buildSfCircularChart() {
    return SfCircularChart(
      title: ChartTitle(text: "QA Status"),
      legend: Legend(
          isVisible: true,
          overflowMode: LegendItemOverflowMode.wrap,
          position: LegendPosition.bottom),
      tooltipBehavior: _tooltipBehavior,
      series: <CircularSeries>[
        PieSeries<MyData, String>(
          dataSource: _qaStatus,
          xValueMapper: (MyData data, _) => data.legend,
          yValueMapper: (MyData data, _) => data.value,
          pointColorMapper: (MyData data, _) => data.color,
          dataLabelSettings: DataLabelSettings(isVisible: true),
          enableTooltip: true,
          // maximumValue: 5,
        )
      ],
    );
  }

/*  SfCartesianChart buildSfCartesianChart() {
    return SfCartesianChart(
      title: ChartTitle(text: 'QA Achievement'),
      legend: Legend(isVisible: true),
      tooltipBehavior: _tooltipBehavior,
      series: <ChartSeries>[
        LineSeries<QaAchievementParseModel, String>(
            dataSource: _qaAchievement,
            xValueMapper: (QaAchievementParseModel exp, _) =>
                DateFormat('yyyy-MM-dd').format(exp.qaDate),
            yValueMapper: (QaAchievementParseModel exp, _) => exp.total,
            //name: 'Father',
            markerSettings: MarkerSettings(
              isVisible: true,
            )),
      ],
      primaryXAxis: CategoryAxis(),
    );
  }*/

  FutureBuilder<Object?> buildSfCartesianChart() {
    return FutureBuilder(builder: (context, snapshot) {
      //if (snapshot.hasData) {
      return (SfCartesianChart(
        title: ChartTitle(text: 'QA Achievement'),
        legend: Legend(
            isVisible: true,
            position: LegendPosition.bottom,
            overflowMode: LegendItemOverflowMode.wrap),
        tooltipBehavior: _tooltipBehaviorQAAch,
        series: <ChartSeries>[

          LineSeries<SampleData, DateTime>(
              dataSource: oneOffList,
              xValueMapper: (SampleData exp, _) => exp.lagend,
              yValueMapper: (SampleData exp, _) => int.parse(exp.value),
              dataLabelSettings: DataLabelSettings(isVisible: true),
              name: 'Total Sample',
              color: Colors.deepPurple,
              sortingOrder: SortingOrder.ascending,
              sortFieldValueMapper: (SampleData exp, _) => int.parse(exp.value),
              markerSettings: MarkerSettings(
                isVisible: true,
              )),
          LineSeries<MyData2, DateTime>(
              dataSource: _myDataQAAchievement,
              xValueMapper: (MyData2 exp, _) => exp.legend,
              yValueMapper: (MyData2 exp, _) => exp.value,
              dataLabelSettings: DataLabelSettings(isVisible: true),
              name: 'QA Achv.',
              isVisible: false,
              color: Colors.blue,
              markerSettings: MarkerSettings(
                isVisible: true,
              )),
          LineSeries<MyData2, DateTime>(
              dataSource: _myDataQAAchievement,
              xValueMapper: (MyData2 exp, _) => exp.legend,
              yValueMapper: (MyData2 exp, _) => exp.value2,
              dataLabelSettings: DataLabelSettings(isVisible: true),
              name: 'Cumula.QA Achv.',
              color: Colors.black45,
              markerSettings: MarkerSettings(
                isVisible: true,
              )),
          /*      LineSeries<SyncWiseModel, String>(
              dataSource: _syncWiseDataList,
              xValueMapper: (SyncWiseModel exp, _) => DateFormat('MM-dd').format(exp.syncDate),
              yValueMapper: (SyncWiseModel exp, _) => exp.total,
              name: 'Cumula.FieldAchv.',
              markerSettings: MarkerSettings(
                isVisible: true,
              )),
          LineSeries<SyncWiseModel, String>(
              dataSource: _syncWiseDataList,
              xValueMapper: (SyncWiseModel exp, _) => DateFormat('MM-dd').format(exp.syncDate),
              yValueMapper: (SyncWiseModel exp, _) => exp.subTotal,
              name: 'Cumula.FieldAchv.',
              markerSettings: MarkerSettings(
                isVisible: true,
              )),*/

          LineSeries<CutOffData, DateTime>(
              dataSource: cutoffdata,
              xValueMapper: (CutOffData exp, _) => exp.lagend,
              yValueMapper: (CutOffData exp, _) => int.parse(exp.value),
              dataLabelSettings: DataLabelSettings(isVisible: true),
              name: 'Cut Off',
              color: Colors.redAccent,
              markerSettings: MarkerSettings(
                isVisible: true,
              )),

        ],
        primaryXAxis: DateTimeAxis(),
      ));
      /*} else {
        Center(
          child: CircularProgressIndicator(),
        );
      }*/
    });
  }

  /*List<QaAchievementParseModel> getQaAchievement() {
    var field = Get.find<QAAchievementController>();
    field.mQAAchievement();
    print("printf " + field.qaAchievementList.toString());
    field.qaAchievementList.length;
    return field.qaAchievementList;
  }*/

  void getQaAchievement() {
    var field = Get.find<QAAchievementController>();

    //field.mQAAchievement();
    print("printf " + field.qaAchievementList.toString());
    field.qaAchievementList.length;

    List<MyData2> _myData = [];
    if (field.qaAchievementList.length > 0) {
      for (int i = 0; i < field.qaAchievementList.length; i++) {
        _myData.add(MyData2(
            field.qaAchievementList[i].qaDate,
            field.qaAchievementList[i].total,
            field.qaAchievementList[i].subTotal));
      }
      _myDataQAAchievement = _myData;
    }
  }

  void getSyncWiseData() {
    var field = Get.find<SyncWiseController>();

    //field.mQAAchievement();
    print("printf " + field.syncWise.toString());
    field.syncWiseList.length;

    _syncWiseDataList = field.syncWiseList;
  }

  void getBatchPercentData() {
    var field = Get.find<BatchController>();

    //field.mQAAchievement();
    print("printf " + field.batchPassingList.toString());
    field.batchPassingList.length;

    _batchData = field.batchPassingList;
  }

  void getOneOffWave() {
    var field = Get.find<WaveProjectControllerOneOff>();
    // field.getWaveOneOff(one[1].toString(), one[2], one[3].toString());
    print("printf " + field.waveList.toString());
    field.waveList.length;

    double batchDataPercent = (int.parse(widget.sampleQuotaAllocation) / 100) *
        _batchData[0].batchPassingPercentage;

    String dataPercent = batchDataPercent.ceil().toString();

    if (field.waveList.length > 0) {
      List<SampleData> getWave = [
        SampleData(
            field.waveList[0].fieldStartDate, "0"),
        SampleData(field.waveList[0].fieldEndDate,
            dataPercent)
      ];
      oneOffList = getWave;
      setState(() {});
    }
  }

  void getOneOffWaveSampleTracking() {
    var field = Get.find<WaveProjectController>();
    // field.getWaveOneOff(one[1].toString(), one[2], one[3].toString());
    print("printf " + field.waveList.toString());
    field.waveList.length;

    double batchDataPercent = (int.parse(widget.sampleQuotaAllocation) / 100) *
        _batchData[0].batchPassingPercentage;

    String dataPercent = batchDataPercent.ceil().toString();

    if (field.waveList.length > 0) {
      List<SampleData> getWave = [
        SampleData(field.waveList[0].waveStartDate, "0"),
        SampleData(field.waveList[0].waveEndDate, dataPercent)
      ];
      oneOffList = getWave;
      setState(() {});
    }
  }

  void getCutOffTracking() {
    var field = Get.find<WaveProjectController>();
    // field.getWaveOneOff(one[1].toString(), one[2], one[3].toString());
    print("printf " + field.waveList.toString());
    field.waveList.length;

    double batchDataPercent = (int.parse(widget.sampleQuotaAllocation) / 100) *
        _batchData[0].batchPassingPercentage;
    String dataPercent = batchDataPercent.ceil().toString();

    if (field.waveList.length > 0) {
      List<CutOffData> getWave = [
        CutOffData(
            field.waveList[0].qaCutOffDate, "0"),
        CutOffData(field.waveList[0].qaCutOffDate,
            dataPercent)
      ];
      print("cut off");
      print(DateFormat('MM-dd').format(field.waveList[0].qaCutOffDate));
      cutoffdata = getWave;
      setState(() {});
    }
  }

  void getCutOff() {
    var field = Get.find<WaveProjectControllerOneOff>();
    // field.getWaveOneOff(one[1].toString(), one[2], one[3].toString());
    print("printf " + field.waveList.toString());
    field.waveList.length;

    double batchDataPercent = (int.parse(widget.sampleQuotaAllocation) / 100) *
        _batchData[0].batchPassingPercentage;
    String dataPercent = batchDataPercent.ceil().toString();

    if (field.waveList.length > 0) {
      List<CutOffData> getWave = [
        CutOffData(
            field.waveList[0].qaCutOffDate, "0"),
        CutOffData(field.waveList[0].qaCutOffDate,
            dataPercent)
      ];
      print("cut off");
      print(DateFormat('MM-dd').format(field.waveList[0].qaCutOffDate));
      cutoffdata = getWave;
      setState(() {});
    }
  }

  /////////////////////////////////////////////pas fail pending
  void getPassQa() {
    var field = Get.find<QAPassController>();
    // field.mQAPass();
    print("printf " + field.qaPassList.toString());
    field.qaPassList.length;
    if (field.qaPassList.length > 0) {
      _qaPass = field.qaPassList;
    } else {
      //_qaPass.add(QaPassModel(y: 0, label: "no Data"));
    }
  }

  void getFailQa() {
    var field = Get.find<QAFailController>();
    // field.mQAPass();
    print("printf " + field.qaFailList.toString());
    field.qaFailList.length;
    if (field.qaFailList.length > 0) {
      _qaFail = field.qaFailList;
    } else {
      //  _qaFail.add(QaFailModel(y: 0, label: "no Data"));
    }
  }

  void getOverAllQa() {
    var field = Get.find<OverAllAchievementController>();
    //field.mOverAllAchievement();
    print("printf " + field.qaPassList.toString());
    field.qaPassList.length;
    if (field.qaPassList.length > 0) {
      _overAll = field.qaPassList;
    } else {
      //_overAll.add(QaOverAllModel(y: 0, label: "no Data"));
    }
  }

/////////////////////////////////////////////pas fail pending
  List<MyData> getQaStatus() {
    //List<QaStatusParseModel> qaData = [];
    var field = Get.find<StatusQAController>();
    //field.mQaStatus("120","Quota Testing","pass","pending");
    field.qaStatusAchievement;
//    var data =  (field.qaStatusAchievement[0].fail! / field.qaStatusAchievement[0].total!) * 100;

    final List<MyData> chartData = [
      //MyData('LastDayQA', field.qaStatusAchievement[0-].lastDayQa),
      MyData('Fail', field.qaStatusAchievement[0].fail ?? 0, Colors.redAccent),
      MyData('Pass', field.qaStatusAchievement[0].pass ?? 0, Colors.green),
      MyData(
          'Total', field.qaStatusAchievement[0].total ?? 0, Colors.deepPurple)
    ];

    return chartData;
  }

  List<GDPData> getChartData() {
    final List<GDPData> chartData = [
      GDPData("ABCD", 1600),
      GDPData("XCVB", 1700),
      GDPData("WERT", 2600),
      GDPData("POIUY", 1900),
      GDPData("GHJKL", 5600),
      GDPData("ASDFG", 9600),
    ];
    return chartData;
  }

  List<ExpenseData> getChartData2() {
    final List<ExpenseData> chartData = [
      ExpenseData('Food', 0, 40, 45, 48, 0),
      ExpenseData('Transport', 33, 45, 54, 28, 12),
      ExpenseData('Medical', 43, 23, 20, 34, 24),
      ExpenseData('Clothes', 32, 54, 23, 54, 36),
      ExpenseData('Books', 56, 18, 43, 55, 48),
      ExpenseData('Others', 23, 54, 33, 60, 60),
    ];
    return chartData;
  }
}

class GDPData {
  final String continent;
  final int gdp;

  GDPData(this.continent, this.gdp);
}

/*class SampleData {
  final int id;
  final String name;
  final String fieldStartDate;
  final String fieldEndDate;
  final String fieldCutOffDate;
  final String qaCutOffDate;

  SampleData(this.id, this.name, this.fieldStartDate, this.fieldEndDate,
      this.fieldCutOffDate, this.qaCutOffDate);
}*/

class SampleData {
  final DateTime lagend;
  final String value;

  SampleData(this.lagend, this.value);
}

/*class SampleData {
  final DateTime lagend;
  final String  value;

  SampleData(this.lagend, this.value);
}*/

class CutOffData {
  final DateTime lagend;
  final String value;

  CutOffData(this.lagend, this.value);
}

List<GDPDataABC> getChartDataABC() {
  final List<GDPDataABC> chartData = [
    GDPDataABC("ABCD", 1600),
    GDPDataABC("XCVB", 1700),
    GDPDataABC("WERT", 2600),
    GDPDataABC("POIUY", 1900),
    GDPDataABC("GHJKL", 5600),
    GDPDataABC("ASDFG", 9600),
  ];
  return chartData;
}

class ExpenseData {
  ExpenseData(this.expenseCategory, this.father, this.mother, this.son,
      this.daughter, this.maxRange);

  final String expenseCategory;
  final num father;
  final num mother;
  final num son;
  final num daughter;
  final num maxRange;
}

class GDPDataABC {
  final String continent;
  final int gdp;

  GDPDataABC(this.continent, this.gdp);
}

class MyData {
  final String legend;
  final int value;
  final Color color;

  MyData(this.legend, this.value, this.color);
}

class MyData2 {
  final DateTime legend;
  final int value;
  final int value2;

  MyData2(this.legend, this.value, this.value2);
}


class CutOffField {
  final String legend;
  final int value;

  CutOffField(this.legend, this.value);
}
