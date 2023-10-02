import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:markit_jetty/controller/qa_status_user_id_controller.dart';
import 'package:markit_jetty/controller/region_progress_controller.dart';
import 'package:markit_jetty/data/repository/region_progress_repo.dart';
import 'package:markit_jetty/models/field_achievement_model_perse_json.dart';
import 'package:markit_jetty/models/field_achievment_model.dart';
import 'package:markit_jetty/models/region_progress_model.dart';
import 'package:markit_jetty/models/status_user_id_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

import '../controller/filed_achievement_controller.dart';
import '../controller/heirarchy_controller.dart';
import '../controller/overall_achievement.dart';
import '../controller/qa_status_user_filed_date_controller.dart';
import '../controller/region_level_wave_controller.dart';
import '../controller/sync_wise_controller.dart';
import '../controller/wave_controller_one_off.dart';
import '../controller/wave_project_controller.dart';
import '../models/qa_overall.dart';
import '../models/qa_status_user_field_date_model.dart';
import '../models/sync_wise_model.dart';
import '../utils/app_constants.dart';
import '../widget/check_box_status.dart';
import '../widget/input_field.dart';

class LineChart extends StatefulWidget {
  final sampleQuotaAllocation;
  final String id;
  final String visitMonth;
  final int projectClassificationTypeId;
  final String quotaStatus;

  const LineChart(
      {Key? key,
      required this.id,
      required this.visitMonth,
      required this.sampleQuotaAllocation,
      required this.projectClassificationTypeId, required this.quotaStatus})
      : super(key: key);

  @override
  State<LineChart> createState() => _LineChartState();
}

class _LineChartState extends State<LineChart> {
  bool oneOffTracking = false;

  List<String> selectedItems = ["pass", "pending"];

  void _showMultiSelect() async {
    // a list of selectable items
    // these items can be hard-coded or dynamically fetched from a database/API
    List<String> _items = ["pass", "pending", "fail", "test"];

    final List<String>? results = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return MultiSelect(items: _items);
      },
    );

    // Update UI
    if (results != null) {
      setState(() {
        selectedItems = results;
        print("My selected Items");
        print(selectedItems);

        oneOffTracking
            ? getAllPassPendingData(widget.id, widget.visitMonth, selectedItems,widget.projectClassificationTypeId,widget.quotaStatus)
                .then((_) {
                setState(() {
                  getFieldAchievementData();
                  getSyncWiseData();


                  if (widget.projectClassificationTypeId == AppConstants.ONE_OFF) {
                    getCutOff();
                    getOneOffWaveSample();
                  }else{
                    getCutOffTracking();
                    getOneOffWaveSampleTracking();
                  }
                });
              })
            : getAllPassPendingData(widget.id, widget.visitMonth, selectedItems,widget.projectClassificationTypeId,widget.quotaStatus)
                .then((_) {
                getFieldAchievementData();
                getSyncWiseData();

                if (widget.projectClassificationTypeId == AppConstants.ONE_OFF) {
                  getCutOff();
                  getOneOffWaveSample();
                }else{
                  getCutOffTracking();
                  getOneOffWaveSampleTracking();
                }

              });

/*        getFieldAchievementData();
        getSyncWiseData();
        getCutOff();
        getOneOffWaveSample();*/

        setState(() {});
      });
    }

    setState(() {});
  }

  late List<DataPass> _regionProgress;
  late List<DataFail> _regionProgressFail;
  late List<DataPending> _regionProgressPending;

  late List<GDPData> _chartData4;
  late List<ExpenseData> _chartData;
  late List<ExpenseData> _chartData3;

  //late List<FieldAchievementParseModel> _listFieldAchievement;
  late TooltipBehavior _tooltipBehavior;
  late TooltipBehavior _tooltipBehaviorOverAll;

  List<MyData> _myDataOverAll = [];

  List<RegionRefData> regionData = [];
  List<OneOffWave> userHierarchy = [];
  List<SampleData> oneOffList = [];
  List<CutOffData> cutoffdata = [];
  late List<QaOverAllModel> _overAll = [];
  List<SyncWiseModel> _syncWiseDataList = [];

  late int _selectedId;
  late int _levelId;

  late List<StatusUserFieldDateModel> _fieldDateWiseData = [];
  late List<StatusUserIdModel> _fieldIdWiseData = [];

  String _selectedRemind = "Region Wise";
  String _hierarchy = "Select User";
  List<int> remindList = [
    5,
    10,
    15,
    20,
  ];

  bool regionWise = true;
  bool userWise = false;

  @override
  void initState() {
    getFieldAchievementData();

    getRegionProgress();
    getRegionProgressFail();
    getRegionProgressPending();
    getOneOffWave();
    getSyncWiseData();
    getOverAllQa();


    if (widget.projectClassificationTypeId == AppConstants.ONE_OFF) {
      getCutOff();
      getOneOffWaveSample();
    }else{
      getCutOffTracking();
      getOneOffWaveSampleTracking();
    }

    _tooltipBehavior = TooltipBehavior(enable: true);
    _tooltipBehaviorOverAll = TooltipBehavior(enable: true);
    // _fieldDateWiseData = getFieldDateData();

/*    _regionProgress = getRegionProgress();
    _regionProgressFail = getRegionProgressFail();

    _chartData = getChartData();
    _chartData3 = getChartData();

    _chartData4 = getChartDataCircular();*/
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            floatingActionButton: Visibility(
              visible: true,
              child: FloatingActionButton(
                onPressed: () => setState(() {
                  getOverAllQa();
                  getRegionProgress();
                  getRegionProgressFail();
                  getRegionProgressPending();
                  getOneOffWave();
                  getFieldAchievementData();
                  getSyncWiseData();

                  if (widget.projectClassificationTypeId == AppConstants.ONE_OFF) {
                    getCutOff();
                    getOneOffWaveSample();
                  }else{
                    getCutOffTracking();
                    getOneOffWaveSampleTracking();
                  }
                }),
                child: const Icon(Icons.refresh, color: Colors.white),
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // use this button to open the multi-select dialog
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              side: BorderSide(
                                width: 1.0,
                                color: Colors.grey.shade300,
                              )),
                          child: const Text(
                            'Select Status',
                            style: TextStyle(color: Colors.blue),
                          ),
                          onPressed: _showMultiSelect,
                        ),
                        /*    Container(
                          width: 150,
                          child: OutlinedButton(
                            onPressed: () {
                              _showMultiSelect;
                            },
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0))),
                            ),
                            child: const Text('Select Status'),
                          ),
                        ),*/
                        const Divider(
                          height: 30,
                        ),
                        // display selected items
                        Wrap(
                          children: selectedItems
                              .map((e) => Chip(
                                    label: Text(e),
                                  ))
                              .toList(),
                        )
                      ],
                    ),
                  ),
                  buildSfCartesianChart(),
                  MyHorizontalQAOverAll(),
                  // BarChartHorizontal(),
                  //  buildSfCircularChart(),
                ],
              ),
            )));
  }

  SfCartesianChart buildSfCartesianChart() {
    return SfCartesianChart(
      title: ChartTitle(text: 'Field Work Achievement'),
      legend: Legend(
          isVisible: true,
          position: LegendPosition.bottom,
          overflowMode: LegendItemOverflowMode.wrap),
      tooltipBehavior: _tooltipBehavior,
      series: <ChartSeries>[
        LineSeries<MyData, DateTime>(
            dataSource: _myDataOverAll,
            xValueMapper: (MyData exp, _) => exp.legend,
            yValueMapper: (MyData exp, _) => exp.value,
            dataLabelSettings: DataLabelSettings(isVisible: true),
            isVisible: false,
            name: 'DateAchv.',
            color: Colors.blue,
            markerSettings: const MarkerSettings(
              isVisible: true,
            )),
        LineSeries<MyData, DateTime>(
            dataSource: _myDataOverAll,
            xValueMapper: (MyData exp, _) => exp.legend,
            yValueMapper: (MyData exp, _) => exp.value2,
            dataLabelSettings: DataLabelSettings(isVisible: true),
            isVisible: true,
            name: 'Cumula.Achv.',
            color: Colors.black45,
            markerSettings: MarkerSettings(
              isVisible: true,
            )),
        LineSeries<SyncWiseModel, DateTime>(
            dataSource: _syncWiseDataList,
            xValueMapper: (SyncWiseModel exp, _) => exp.syncDate,
            yValueMapper: (SyncWiseModel exp, _) => exp.total,
            dataLabelSettings: DataLabelSettings(isVisible: true),
            isVisible: false,
            name: 'SyncWiseAchv.',
            color: Colors.green,
            markerSettings: MarkerSettings(
              isVisible: true,
            )),
        LineSeries<SyncWiseModel, DateTime>(
            dataSource: _syncWiseDataList,
            xValueMapper: (SyncWiseModel exp, _) => exp.syncDate,
            yValueMapper: (SyncWiseModel exp, _) => exp.subTotal,
            dataLabelSettings: DataLabelSettings(isVisible: true),
            isVisible: false,
            name: 'Cumula.SyncAchv.',
            color: Colors.orange,
            markerSettings: MarkerSettings(
              isVisible: true,
            )),
        LineSeries<SampleData, DateTime>(
            dataSource: oneOffList,
            xValueMapper: (SampleData exp, _) => exp.lagend,
            yValueMapper: (SampleData exp, _) => int.parse(exp.value),
            dataLabelSettings: DataLabelSettings(isVisible: true),
            name: 'Total Sample',
            color: Colors.deepPurple,
            markerSettings: MarkerSettings(
              isVisible: true,
            )),
        LineSeries<CutOffData, DateTime>(
            dataSource: cutoffdata,
            xValueMapper: (CutOffData exp, _) => exp.lagend,
            yValueMapper: (CutOffData exp, _) => int.parse(exp.value),
            dataLabelSettings: DataLabelSettings(isVisible: true),
            isVisible: false,
            name: 'Cut Off',
            color: Colors.redAccent,
            markerSettings: MarkerSettings(
              isVisible: true,
            )),
      ],
      primaryXAxis: DateTimeAxis(),
    );
  }

  SfCartesianChart MyHorizontalQAOverAll() {
    return SfCartesianChart(
      title: ChartTitle(text: "Overall Achievement"),
      legend: Legend(isVisible: true, position: LegendPosition.bottom),
      tooltipBehavior: _tooltipBehaviorOverAll,
      series: <ChartSeries>[
        BarSeries<QaOverAllModel, String>(
          name: 'OverAll Achv.',
          dataSource: _overAll,
          xValueMapper: (QaOverAllModel data, _) => data.label,
          yValueMapper: (QaOverAllModel data, _) => data.y,
          dataLabelSettings: DataLabelSettings(isVisible: true),
          enableTooltip: true,
          sortingOrder: SortingOrder.ascending,
          sortFieldValueMapper: (QaOverAllModel data, _) => data.label,
          color: Colors.deepPurple,
        ),
      ],
      primaryXAxis: CategoryAxis(),
      /*primaryYAxis: NumericAxis(
          edgeLabelPlacement: EdgeLabelPlacement.shift,
          numberFormat: NumberFormat.simpleCurrency(decimalDigits: 0),
          title: AxisTitle(text: "QA")),*/
    );
  }

  void getFieldAchievementData() {
    var field = Get.find<FieldAchievementController>();
    //field.fieldAchievementData();
    print("printf " + field.fieldAchievementList.toString());
    field.fieldAchievementList.length;

    List<MyData> _myData = [];

    if (field.fieldAchievementList.length > 0) {
      for (int i = 0; i < field.fieldAchievementList.length; i++) {
        _myData.add(MyData(
            field.fieldAchievementList[i].fieldDate,
            field.fieldAchievementList[i].total,
            field.fieldAchievementList[i].subTotal));
      }
    } else {
      _myData.clear();
    }
    //_myDataOverAll.addAll(_myData);

    _myDataOverAll = _myData;
    setState(() {});
  }

  void getCutOff() {
    var field = Get.find<WaveProjectControllerOneOff>();
    // field.getWaveOneOff(one[1].toString(), one[2], one[3].toString());
    print("printf " + field.waveList.toString());
    field.waveList.length;

    if (field.waveList.length > 0) {
      List<CutOffData> getWave = [
        CutOffData(field.waveList[0].fieldCutOffDate, "0"),
        CutOffData(
            field.waveList[0].fieldCutOffDate, widget.sampleQuotaAllocation)
      ];
      print("cut off");
      print(DateFormat('MM-dd').format(field.waveList[0].qaCutOffDate));
      cutoffdata = getWave;
      setState(() {});
    }
  }
  void getCutOffTracking() {
    var field = Get.find<WaveProjectController>();
    // field.getWaveOneOff(one[1].toString(), one[2], one[3].toString());
    print("printf " + field.waveList.toString());
    field.waveList.length;

    if (field.waveList.length > 0) {
      List<CutOffData> getWave = [
        CutOffData(field.waveList[0].fieldCutOffDate, "0"),
        CutOffData(
            field.waveList[0].fieldCutOffDate, widget.sampleQuotaAllocation)
      ];
      print("cut off");
      print(DateFormat('MM-dd').format(field.waveList[0].qaCutOffDate));
      cutoffdata = getWave;
      setState(() {});
    }
  }

  void getOneOffWaveSample() {
    var field = Get.find<WaveProjectControllerOneOff>();
    // field.getWaveOneOff(one[1].toString(), one[2], one[3].toString());
    print("printf " + field.waveList.toString());
    field.waveList.length;

    if (field.waveList.length > 0) {
      List<SampleData> getWave = [
        SampleData(field.waveList[0].fieldStartDate, "0"),
        SampleData(field.waveList[0].fieldEndDate, widget.sampleQuotaAllocation)
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

    if (field.waveList.length > 0) {
      List<SampleData> getWave = [
        SampleData(field.waveList[0].waveStartDate, "0"),
        SampleData(field.waveList[0].waveEndDate, widget.sampleQuotaAllocation)
      ];
      oneOffList = getWave;
      setState(() {});
    }
  }



  ////////////////////////////////Pass Fail Pending Region Wise
  void getRegionProgress() {
    var field = Get.find<RegionProgressController>();
    //field.mRegionProgress();
    //  print("printf " + field.regionProgress.toString());
    // field.regionProgress.length;
    //field.regionProgress[0].responsePass;
    List<DataPass> chartPass = [];
    if (field.regionProgress.length > 0) {
      for (int i = 0; i < field.regionProgress[0].responsePass.length; i++) {
        chartPass.add(DataPass(field.regionProgress[0].responsePass[i].label,
            field.regionProgress[0].responsePass[i].y));
        /*      chartPass = [
          DataPass(field.regionProgress[0].responsePass[i].label,
              field.regionProgress[0].responsePass[i].y),
        ];*/
      }
    } else {
      chartPass.add(DataPass("No Data", 0));
    }
    _regionProgress = chartPass;
  }

  void getRegionProgressFail() {
    var field = Get.find<RegionProgressController>();
    //field.mRegionProgress();
    /*   print("printf " + field.regionProgress.toString());
    field.regionProgress.length;
    field.regionProgress[0].responseFail;*/

    List<DataFail> chartFail = [];
    if (field.regionProgress.length > 0) {
      for (int i = 0; i < field.regionProgress[0].responseFail.length; i++) {
        chartFail.add(DataFail(field.regionProgress[0].responseFail[i].label,
            field.regionProgress[0].responseFail[i].y));
        /*      chartPass = [
          DataPass(field.regionProgress[0].responsePass[i].label,
              field.regionProgress[0].responsePass[i].y),
        ];*/
      }
    } else {
      chartFail.add(DataFail("No Data", 0));
    }

    _regionProgressFail = chartFail;
  }

  void getRegionProgressPending() {
    var field = Get.find<RegionProgressController>();
    //field.mRegionProgress();
    /*print("printf " + field.regionProgress.toString());
    field.regionProgress.length;
    field.regionProgress[0].response;*/

    List<DataPending> chartPending = [];
    if (field.regionProgress.length > 0) {
      for (int i = 0; i < field.regionProgress[0].response.length; i++) {
        chartPending.add(DataPending(field.regionProgress[0].response[i].label,
            field.regionProgress[0].response[i].y));
        /*      chartPass = [
          DataPass(field.regionProgress[0].responsePass[i].label,
              field.regionProgress[0].responsePass[i].y),
        ];*/
      }
    } else {
      chartPending.add(DataPending("No Data", 0));
    }

    _regionProgressPending = chartPending;
  }

  ////////////////////////////////Pass Fail Pending Region Wise

  void getOneOffWave() {
    var field = Get.find<RegionLevelWaveController>();
    //field.getRegionLevelWave(one[1].toString(), one[2], one[3].toString());
    print("level " + field.waveList.toString());
    field.waveList.length;
    //print("level 0 "+field.waveList);
    List<RegionRefData> _getWave = [];
    String name = "";

    if (field.waveList.length > 0) {
      for (int i = 0; i < field.waveList[0].regionRefData!.length; i++) {
        var choices = field.waveList[0].regionRefData![i].choices;
        if (choices != null) {
          for (int j = 0; j < choices.length; j++) {
            name = "/${choices[0].name}";
          }
        } else {
          name = "";
        }

        _getWave.add(RegionRefData(
            field.waveList[0].regionRefData![i].id!,
            field.waveList[0].regionRefData![i].name! + name,
            field.waveList[0].regionRefData![i].levelId!));
      }

/*  List<RegionRefData> _getWave = [];
  for (int i = 0; i < field.waveList.length; i++) {
    _getWave.add(RegionRefData(
      field.waveList[i].id!,
      field.waveList[i].regionRefData![0].name!,
    ));
  }*/
      // _selectedRepeat = repeatList[0].name;

      _getWave.insert(0, RegionRefData(0, "Region Wise", 0));
      regionData = _getWave;
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

  void getFieldDateData(
      int id, int levelId, int userId, String projectId, String visitMonth) {
    var field = Get.find<QAStatusUserFieldDateController>();
    field.fieldDateQaData(id, levelId, userId, widget.id, widget.visitMonth);
    // field.mQAPass();
    print("printf " + field.fieldDateModelList.toString());
    field.fieldDateModelList.length;
    _fieldDateWiseData = field.fieldDateModelList;
  }

  void getSyncWiseData() {
    var field = Get.find<SyncWiseController>();

    //field.mQAAchievement();
    print("printf " + field.syncWise.toString());
    field.syncWiseList.length;

    _syncWiseDataList = field.syncWiseList;
    setState(() {});
  }

/*  Future<void> getFieldiDData(int id, int levelId, List<int> userId, String projectId,
      String visitMonth) async {
    var field = Get.find<QAStatusUserIdController>();
    field
        .fieldDateQaData(id, levelId, userId, widget.id, widget.visitMonth)
        .then((value) {
      if (value != null) {
        _fieldIdWiseData = value;
      }
    });*/

/*    // field.mQAPass();
    print("printf " + field.userIdList.toString());
    field.userIdList.length;
    _fieldIdWiseData = field.userIdList;*/
}

/*  void getUserHierarchy(
      int id, String name, int levelId, String projectId, String visitMonth) {
    var field = Get.find<HierarchyControllerUser>();
    field.getHierarchyData(id, name, levelId, projectId, visitMonth);
    print("printf " + field.hierarchyslist.toString());
    field.hierarchyslist.length;

    List<OneOffWave> _getWave = [];
    if (field.hierarchyslist.length > 0) {
      for (int i = 0; i < field.hierarchyslist.length; i++) {
        _getWave.add(OneOffWave(
          field.hierarchyslist[i].userId,
          field.hierarchyslist[i].name,
        ));
      }
      // _selectedRepeat = repeatList[0].name;
      userHierarchy = _getWave;

      if (userHierarchy[0].id != null) {
        getFieldiDData(id, levelId, [718,724,717], projectId, visitMonth);
      }
    }
  }
}*/

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

class GDPData {
  final String continent;
  final int gdp;

  GDPData(this.continent, this.gdp);
}

class MyData {
  final DateTime legend;
  final int value;
  final int value2;

  MyData(this.legend, this.value, this.value2);
}

/*void getOneOffWave() {
  var field = Get.find<RegionLevelWaveController>();
  //field.getRegionLevelWave(one[1].toString(), one[2], one[3].toString());
  print("level " + field.waveList.toString());
  field.waveList.length;
  //print("level 0 "+field.waveList);
  List<RegionRefData> _getWave = [];

  for (int i = 0; i < field.waveList[0].regionRefData!.length; i++) {
    _getWave.add(RegionRefData(field.waveList[0].regionRefData![i].id!,
        field.waveList[0].regionRefData![i].name!));
  }

*/ /*  List<RegionRefData> _getWave = [];
  for (int i = 0; i < field.waveList.length; i++) {
    _getWave.add(RegionRefData(
      field.waveList[i].id!,
      field.waveList[i].regionRefData![0].name!,
    ));
  }*/ /*
  // _selectedRepeat = repeatList[0].name;
  _getWave;



}*/

/*class RegionRefData{

  final int id;
  final String name;
  final int levelId;
  final String levelName;
  final int choicesId;
  final String choicesName;

  RegionRefData(this.id, this.name, this.levelId, this.levelName,
      this.choicesId, this.choicesName);
}*/

class RegionRefData {
  final int id;
  final String name;
  final int levelId;

  RegionRefData(this.id, this.name, this.levelId);
}

class OneOffWave {
  final int id;
  final String name;

  OneOffWave(this.id, this.name);
}

class SampleData {
  final DateTime lagend;
  final String value;

  SampleData(this.lagend, this.value);
}

class CutOffData {
  final DateTime lagend;
  final String value;

  CutOffData(this.lagend, this.value);
}

class DataPass {
  final String label;
  final int value;

  DataPass(this.label, this.value);
}

class DataFail {
  final String label;
  final int value;

  DataFail(this.label, this.value);
}

class DataPending {
  final String label;
  final int value;

  DataPending(this.label, this.value);
}

Future<void> getAllPassPendingData(
    String id, String name, List<String> selectedItem, int projectClassificationTypeId, String quotaStatus) async {
  await Get.find<FieldAchievementController>()
      .fieldAchievementData(id, name, selectedItem);
  await Get.find<SyncWiseController>().syncWise(id, name, selectedItem);

  //await Get.find<WaveProjectController>().getWave(id, quotaStatus.toString(), projectClassificationTypeId.toString());
}
