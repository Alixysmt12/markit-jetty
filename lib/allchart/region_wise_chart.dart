import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../controller/heirarchy_controller.dart';
import '../controller/qa_status_user_filed_date_controller.dart';
import '../controller/qa_status_user_id_controller.dart';
import '../controller/region_level_wave_controller.dart';
import '../controller/region_progress_controller.dart';
import '../models/qa_status_user_field_date_model.dart';
import '../models/status_user_id_model.dart';
import '../widget/input_field.dart';

class RegionWiseChart extends StatefulWidget {
  final sampleQuotaAllocation;
  final String id;
  final String visitMonth;

  const RegionWiseChart(
      {Key? key,
      required this.id,
      required this.visitMonth,
      required this.sampleQuotaAllocation})
      : super(key: key);

  @override
  State<RegionWiseChart> createState() => _RegionWiseChartState();
}

class _RegionWiseChartState extends State<RegionWiseChart> {
  bool regionWise = true;
  bool userWise = false;

  String _selectedRemind = "Region Wise";
  String _hierarchy = "Select User";
  late int _hierarchyId ;
  late TooltipBehavior _tooltipBehavior;
  late int _selectedId;
  late int _levelId;

  List<int> userId = [];

  late List<StatusUserFieldDateModel> _fieldDateWiseData = [];
  late List<StatusUserIdModel> _fieldIdWiseData = [];
  List<RegionRefData> regionData = [];
  List<OneOffWave> userHierarchy = [];
  late List<DataPass> _regionProgress;
  late List<DataFail> _regionProgressFail;
  late List<DataPending> _regionProgressPending;

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    getRegionProgress();
    getRegionProgressFail();
    getRegionProgressPending();
    getOneOffWave();
    //getSyncWiseData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: MyInputWidget(
                  title: "Select Region",
                  hint: _selectedRemind,
                  widget: DropdownButton(
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.grey,
                    ),
                    iconSize: 32,
                    elevation: 4,
                    //style: subHeadingStyle,
                    underline: Container(
                      height: 0,
                    ),
                    items: regionData.map<DropdownMenuItem<RegionRefData>>(
                        (RegionRefData value) {
                      return DropdownMenuItem<RegionRefData>(
                        value: value,
                        child: Text(value.name),
                      );
                    }).toList(),
                    onChanged: (RegionRefData? value) {
                      setState(() {
                        _selectedRemind = value!.name;
                        _selectedId = value.id;
                        _levelId = value.levelId;
                        _hierarchy = "Select User";
                        if (_selectedRemind != "Region Wise") {
                          regionWise = false;
                          userWise = true;

                        } else {
                          regionWise = true;
                          userWise = false;
                          _hierarchy = " ";
                          userHierarchy.clear();
                        }

                        getData(value.id);
                      });
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: MyInputWidget(
                  title: "Select User",
                  hint: _hierarchy,
                  widget: DropdownButton(
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.grey,
                    ),
                    iconSize: 32,
                    elevation: 4,
                    //style: subHeadingStyle,
                    underline: Container(
                      height: 0,
                    ),
                    items:
                        /* remindList.map<DropdownMenuItem<String>>((int value) {
                      return DropdownMenuItem<String>(
                        value: value.toString(),
                        child: Text(value.toString()),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        _selectedRemind = int.parse(value!);
                      });
                    },*/
                        userHierarchy.map<DropdownMenuItem<OneOffWave>>(
                            (OneOffWave value) {
                      return DropdownMenuItem<OneOffWave>(
                        value: value,
                        child: Text(value.name),
                      );
                    }).toList(),
                    onChanged: (OneOffWave? value) {
                      setState(() {
                        _hierarchy = value!.name;
                        _hierarchyId = value.id;
                        getFieldDateData(_selectedId, _levelId,
                            _hierarchyId, widget.id, widget.visitMonth);
                        userWise = false;
                      });
                    },
                  ),
                ),
              ),
              BarChartHorizontal(),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> getData(int id) async {
    await getUserHierarchy(
        _selectedId, _selectedRemind, _levelId, widget.id, widget.visitMonth);

    if(userHierarchy.isNotEmpty) {

      for(int i = 0 ; i < userHierarchy.length ; i++){
        await getFieldiDData(_selectedId, _levelId, userId,
            widget.id, widget.visitMonth);
      }

    }
  }

  SfCartesianChart BarChartHorizontal() {
    return regionWise
        ? SfCartesianChart(
            title: ChartTitle(text: 'Region Progress'),
            legend: Legend(isVisible: true, position: LegendPosition.bottom),
            tooltipBehavior: _tooltipBehavior,
            series: <ChartSeries>[
              StackedColumnSeries<DataPending, String>(
                dataSource: _regionProgressPending,
                xValueMapper: (DataPending exp, _) => exp.label,
                yValueMapper: (DataPending exp, _) => exp.value,
                name: 'Pending',
                color: Colors.deepPurple,
                markerSettings: MarkerSettings(
                  isVisible: true,
                ),
                dataLabelSettings: DataLabelSettings(
                    isVisible: true, showCumulativeValues: true),
              ),
              StackedColumnSeries<DataFail, String>(
                dataSource: _regionProgressFail,
                xValueMapper: (DataFail exp, _) => exp.label,
                yValueMapper: (DataFail exp, _) => exp.value,
                name: 'Fail',
                color: Colors.redAccent,
                markerSettings: MarkerSettings(
                  isVisible: true,
                ),
                dataLabelSettings: DataLabelSettings(
                    isVisible: true, showCumulativeValues: true),
              ),
              StackedColumnSeries<DataPass, String>(
                dataSource: _regionProgress,
                xValueMapper: (DataPass exp, _) => exp.label,
                yValueMapper: (DataPass exp, _) => exp.value,
                name: 'Pass',
                color: Colors.green,
                markerSettings: MarkerSettings(
                  isVisible: true,
                ),
                dataLabelSettings: DataLabelSettings(
                    isVisible: true, showCumulativeValues: true),
              ),
            ],
            primaryXAxis: CategoryAxis(),
          )
        : userWise
            ? SfCartesianChart(
                title: ChartTitle(text: 'Region Progress'),
                legend:
                    Legend(isVisible: true, position: LegendPosition.bottom),
                tooltipBehavior: _tooltipBehavior,
                series: <ChartSeries>[
                  StackedColumnSeries<StatusUserIdModel, String>(
                    dataSource: _fieldIdWiseData,
                    xValueMapper: (StatusUserIdModel exp, _) => exp.name,
                    yValueMapper: (StatusUserIdModel exp, _) =>
                        int.parse(exp.pending),
                    name: 'Pending',
                    color: Colors.deepPurple,
                    markerSettings: MarkerSettings(
                      isVisible: true,
                    ),
                    dataLabelSettings: DataLabelSettings(
                        isVisible: true, showCumulativeValues: true),
                  ),
                  StackedColumnSeries<StatusUserIdModel, String>(
                    dataSource: _fieldIdWiseData,
                    xValueMapper: (StatusUserIdModel exp, _) => exp.name,
                    yValueMapper: (StatusUserIdModel exp, _) =>
                        int.parse(exp.fail),
                    name: 'Fail',
                    color: Colors.redAccent,
                    markerSettings: MarkerSettings(
                      isVisible: true,
                    ),
                    dataLabelSettings: DataLabelSettings(
                        isVisible: true, showCumulativeValues: true),
                  ),
                  StackedColumnSeries<StatusUserIdModel, String>(
                    dataSource: _fieldIdWiseData,
                    xValueMapper: (StatusUserIdModel exp, _) => exp.name,
                    yValueMapper: (StatusUserIdModel exp, _) =>
                        int.parse(exp.pass),
                    name: 'Pass',
                    color: Colors.green,
                    markerSettings: MarkerSettings(
                      isVisible: true,
                    ),
                    dataLabelSettings: DataLabelSettings(
                        isVisible: true, showCumulativeValues: true),
                  ),
                ],
                primaryXAxis: CategoryAxis(),
              )
            : SfCartesianChart(
                title: ChartTitle(text: 'Region Progress'),
                legend:
                    Legend(isVisible: true, position: LegendPosition.bottom),
                tooltipBehavior: _tooltipBehavior,
                series: <ChartSeries>[
                  StackedColumnSeries<StatusUserFieldDateModel, String>(
                    dataSource: _fieldDateWiseData,
                    xValueMapper: (StatusUserFieldDateModel exp, _) =>
                        DateFormat('yyyy-MM-dd').format(exp.fieldDate),
                    yValueMapper: (StatusUserFieldDateModel exp, _) =>
                        int.parse(exp.pending),
                    name: 'Pending',
                    color: Colors.deepPurple,
                    markerSettings: MarkerSettings(
                      isVisible: true,
                    ),
                    dataLabelSettings: DataLabelSettings(
                        isVisible: true, showCumulativeValues: true),
                  ),
                  StackedColumnSeries<StatusUserFieldDateModel, String>(
                    dataSource: _fieldDateWiseData,
                    xValueMapper: (StatusUserFieldDateModel exp, _) =>
                        DateFormat('yyyy-MM-dd').format(exp.fieldDate),
                    yValueMapper: (StatusUserFieldDateModel exp, _) =>
                        int.parse(exp.fail),
                    name: 'Fail',
                    color: Colors.redAccent,
                    markerSettings: MarkerSettings(
                      isVisible: true,
                    ),
                    dataLabelSettings: DataLabelSettings(
                        isVisible: true, showCumulativeValues: true),
                  ),
                  StackedColumnSeries<StatusUserFieldDateModel, String>(
                    dataSource: _fieldDateWiseData,
                    xValueMapper: (StatusUserFieldDateModel exp, _) =>
                        DateFormat('yyyy-MM-dd').format(exp.fieldDate),
                    yValueMapper: (StatusUserFieldDateModel exp, _) =>
                        int.parse(exp.pass),
                    name: 'Pass',
                    color: Colors.green,
                    markerSettings: MarkerSettings(
                      isVisible: true,
                    ),
                    dataLabelSettings: DataLabelSettings(
                        isVisible: true, showCumulativeValues: true),
                  ),
                ],
                primaryXAxis: CategoryAxis(),
              );
  }

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

  Future<void> getUserHierarchy(int id, String name, int levelId,
      String projectId, String visitMonth) async {
    var field = Get.find<HierarchyControllerUser>();
    await field.getHierarchyData(id, name, levelId, projectId, visitMonth);
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



      for(int i = 0 ; i < userHierarchy.length ; i++){

         userId.add(userHierarchy[i].id);
      }

  /*    _getWave.insert(0, OneOffWave(0, "Select User"));
      userHierarchy = _getWave;*/

      if (userHierarchy[0].id != null) {
        await getFieldiDData(
            id, levelId, userId, projectId, visitMonth);
      }

      setState(() {});
    }
  }

  Future<void> getFieldiDData(int id, int levelId, List<int> userId, String projectId,
      String visitMonth) async {
    var field = Get.find<QAStatusUserIdController>();
    await field
        .fieldDateQaData(id, levelId, userId, widget.id, widget.visitMonth)
        .then((value) {
      if (value != null) {
        _fieldIdWiseData = value;
      }
    });

    setState(() {});

/*    // field.mQAPass();
    print("printf " + field.userIdList.toString());
    field.userIdList.length;
    _fieldIdWiseData = field.userIdList;*/
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

  Future<void> getFieldDateData(int id, int levelId, int userId,
      String projectId, String visitMonth) async {
    var field = Get.find<QAStatusUserFieldDateController>();
    await field.fieldDateQaData(
        id, levelId, userId, widget.id, widget.visitMonth);
    // field.mQAPass();
    print("printf " + field.fieldDateModelList.toString());
    field.fieldDateModelList.length;
    _fieldDateWiseData = field.fieldDateModelList;
    setState(() {});
  }

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

class RegionRefData {
  final int id;
  final String name;
  final int levelId;

  RegionRefData(this.id, this.name, this.levelId);
}

class UserData {
  final int id;
  final String name;
  final int levelId;

  UserData(this.id, this.name, this.levelId);
}

class OneOffWave {
  final int id;
  final String name;

  OneOffWave(this.id, this.name);
}
