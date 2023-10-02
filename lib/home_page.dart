import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:markit_jetty/allchart/region_wise_chart.dart';
import 'package:markit_jetty/controller/tracking_controller.dart';
import 'package:markit_jetty/controller/wave_project_controller.dart';
import 'package:markit_jetty/ui/google_map.dart';
import 'package:markit_jetty/utils/app_constants.dart';
import 'package:markit_jetty/utils/colors.dart';
import 'package:markit_jetty/widget/check_box_status.dart';
import 'package:markit_jetty/widget/input_field.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

import 'allchart/qa_charts.dart';
import 'allchart/field_chart.dart';
import 'allchart/stack_row_chart_hor.dart';
import 'allchart/first_day.dart';
import 'controller/filed_achievement_controller.dart';
import 'controller/first_day_controller.dart';
import 'controller/heirarchy_controller.dart';
import 'controller/lat_long_controller.dart';
import 'controller/overall_achievement.dart';
import 'controller/qa_achievement_controller.dart';
import 'controller/qa_fail_controller.dart';
import 'controller/qa_pass_controller.dart';
import 'controller/qa_status_controller.dart';
import 'controller/qa_status_user_filed_date_controller.dart';
import 'controller/qa_status_user_id_controller.dart';
import 'controller/region_level_wave_controller.dart';
import 'controller/region_progress_controller.dart';
import 'controller/sync_wise_controller.dart';
import 'controller/wave_controller_one_off.dart';
import 'models/one_off_waveModel.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var one = Get.arguments;

  //////////////////////////Status
  // this variable holds the selected items
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
            ? getAllPassPendingData(
                one[1].toString(), repeatList[0].name, selectedItems)
            : getAllPassPendingData(
                one[1].toString(), oneOffList[0].name, selectedItems);
      });
    }
  }

  late final Future<int> _future;

/*  Future<void> _loadResources() async {
    await Get.find<StatusQAController>().mQaStatus();
    await Get.find<QAAchievementController>().mQAAchievement();
  }*/

  late List<MyData> _qaStatus;

  int _currentIndex = 0;

  PageController _pageController = PageController(initialPage: 0);

  String _selectedRepeat = "Wave - 8 June";

/*  List<String> repeatList = [
    "Wave - 8 June",
    "Wave - 19 july",
    "Wave - 10 August",
    "Wave - 1 September",
  ];*/

  List<ProjectWave> repeatList = [];
  List<OneOffWave> oneOffList = [];

  String _status = "Pass";
  List<String> statusList = [
    "Pass",
    "Pending",
    "Fail",
  ];

  int _selectedIndex = 0;
  late PersistentTabController _controller;

  void onTapNav(int index) {
    setState(() {
      // Get.find<QAAchievementController>().mQAAchievement();
      _selectedIndex = index;
    });
  }

  bool trackingWave = false;
  bool oneOffTracking = false;

  Future<void> _loadResources() async {
    /*   await Get.find<StatusQAController>()
        .mQaStatus(one[1].toString(), _selectedRepeat, "pass", "pending");*/
    // await Get.find<QAAchievementController>().mQAAchievement("7","Wave - 8 June","pass","pending");
    // await Get.find<QAFailController>().mQAPass();
    //await Get.find<QAPassController>().mQAPass();
    //await Get.find<FieldAchievementController>().fieldAchievementData();
    // await Get.find<OverAllAchievementController>().mOverAllAchievement();
    /* await Get.find<FirstDayController>()
        .fieldAchievementData("120", "Quota Testing", "One-Off");*/
    await Get.find<RegionLevelWaveController>()
        .getRegionLevelWave(one[1].toString(), "", "");
    //await Get.find<RegionProgressController>().mRegionProgress();
    //await Get.find<LatLongController>().mGetLatLong();

    if (one[2] != null && one[0] == AppConstants.ONE_OFF) {
      await Get.find<WaveProjectControllerOneOff>()
          .getWaveOneOff(one[1].toString(), one[2], one[3].toString());
    } else if (one[2] != null && one[0] == AppConstants.TRACKING) {
      await Get.find<WaveProjectController>()
          .getWave(one[1].toString(), one[2], one[3].toString());
    }
/*    await Get.find<HierarchyControllerUser>()
        .getHierarchyData(291, "sindh", 1, "155", "MerginSampleComp");
    await Get.find<QAStatusUserFieldDateController>().fieldDateQaData(127, 2, 665,"155","MerginSampleComp");
    await Get.find<QAStatusUserIdController>().fieldDateQaData(127, 2, 665,"155","MerginSampleComp");*/
    var field = Get.find<QAAchievementController>();
  }

  @override
  void initState() {
    _loadResources();
    _qaStatus = [];
    // _future = _calculate();
    //Get.find<QAAchievementController>().mQAAchievement();
    //_loadResources();
    _controller = PersistentTabController(initialIndex: 0);

    if (one[0] == AppConstants.ONE_OFF) {
      //trackingWave = true;
      trackingWave = false;
      getOneOffWave();
    } else if (one[0] == AppConstants.TRACKING) {
      oneOffTracking = true;
      getWaveController();
    }

    //getWaveController();
    super.initState();
  }

  Future<int> _calculate() => Future.delayed(Duration(seconds: 3), () => 42);

/*  @override
  Widget build(BuildContext context) {
    return Container();
  }*/

  final _bottomNavigationBarItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.stacked_line_chart),
      label: "Field",
    ),
    BottomNavigationBarItem(icon: Icon(Icons.pie_chart_sharp), label: "QA"),
    BottomNavigationBarItem(
        icon: Icon(Icons.table_chart_rounded), label: "First Day"),
    BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: "Region Wise"),
    BottomNavigationBarItem(
        icon: Icon(
          Icons.location_on,
        ),
        label: "Map"),
  ];

  @override
  Widget build(BuildContext context) {
/*    if (one[0] == AppConstants.ONE_OFF) {
      trackingWave = true;
      getOneOffWave();
    } else if (one[0] == AppConstants.TRACKING) {
      oneOffTracking = true;
      getWaveController();
    }*/

    //rebuildAllChildren(context);
    print("hello $one");

    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   onPressed: ()=>setState(() {
      //   //  rebuildAllChildren(context);
      //   }),
      //   child: const Icon(Icons.refresh, color: Colors.white),
      // ),
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: Container(
            width: 270,
            child: Text(
              one[5],
              overflow: TextOverflow.ellipsis,
            )),
      ),
      body: Column(
        children: [
          oneOffTracking
              ? Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: MyInputWidget(
                    title: "Select Wave",
                    hint: "$_selectedRepeat",
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
                          /*   repeatList.map<DropdownMenuItem<ProjectWave>>((ProjectWave? value) {
                  return DropdownMenuItem<ProjectWave>(
                    value: value,
                    child: Text(value!.name, style: TextStyle(color: Colors.grey)),
                  );
                }*/
                          repeatList.map<DropdownMenuItem<ProjectWave>>(
                              (ProjectWave? value) {
                        return DropdownMenuItem<ProjectWave>(
                          value: value,
                          child: Text(value!.name,
                              style: TextStyle(color: Colors.grey)),
                        );
                      }).toList(),
                      onChanged: (ProjectWave? value) {
                        setState(() {
                          _selectedRepeat = value!.name;

                          getAllFutureData(one[1].toString(), _selectedRepeat,
                              one[2] ?? "", one[3].toString(), selectedItems);
                          build(context);

                          /*Get.find<StatusQAController>().mQaStatus("120","Quota Testing","pass","pending").then((status){

                      if(status != null){

                        final List<MyData> chartData = [
                          //MyData('LastDayQA', field.qaStatusAchievement[0].lastDayQa),
                          MyData('Fail', status.fail),
                          MyData('Pass', status.pass),
                          MyData('Total', status.total)
                        ];

                        _qaStatus.addAll(chartData);

                      }
                    });*/
                        });
                      },
                    ),
                  ),
                )
              : Container(),
          trackingWave
              ? Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: MyInputWidget(
                    title: "Select Wave",
                    hint: "$_selectedRepeat",
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
                          /*   repeatList.map<DropdownMenuItem<ProjectWave>>((ProjectWave? value) {
                  return DropdownMenuItem<ProjectWave>(
                    value: value,
                    child: Text(value!.name, style: TextStyle(color: Colors.grey)),
                  );
                }*/
                          oneOffList.map<DropdownMenuItem<OneOffWave>>(
                              (OneOffWave? value) {
                        return DropdownMenuItem<OneOffWave>(
                          value: value,
                          child: Text(value!.name,
                              style: TextStyle(color: Colors.grey)),
                        );
                      }).toList(),
                      onChanged: (OneOffWave? value) {
                        setState(() {
                          _selectedRepeat = value!.name;

                          getAllFutureData(one[1].toString(), _selectedRepeat,
                                  one[2], one[3].toString(), selectedItems)
                              .then((_) {
                            setState(() {
                              //rebuildAllChildren(context);

                              //Navigator.popAndPushNamed(context,'/home_page');
                              //  build(context);
                            });
                          });

                          /*Get.find<StatusQAController>().mQaStatus("120","Quota Testing","pass","pending").then((status){

                      if(status != null){

                        final List<MyData> chartData = [
                          //MyData('LastDayQA', field.qaStatusAchievement[0].lastDayQa),
                          MyData('Fail', status.fail),
                          MyData('Pass', status.pass),
                          MyData('Total', status.total)
                        ];

                        _qaStatus.addAll(chartData);

                      }
                    });*/
                        });
                      },
                    ),
                  ),
                )
              : Container(),
          SizedBox(
            height: 15,
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (newIndex) {
                setState(() {
                  _currentIndex = newIndex;
                });
              },
              scrollDirection: Axis.horizontal,
              children: [
                /*  Container(child: Text("Data"),),
                Container(child: Text("Data2"),),
                Container(child: Text("Data3"),),
                Container(child: Text("Data4"),),*/

                oneOffTracking
                    ? LineChart(
                        id: one[1].toString(),
                        visitMonth: repeatList[0].name,
                        sampleQuotaAllocation: one[4].toString(),
                        projectClassificationTypeId: one[0],
                        quotaStatus: one[2] ?? "")
                    : LineChart(
                        id: one[1].toString(),
                        visitMonth: oneOffList[0].name,
                        sampleQuotaAllocation: one[4].toString(),
                        projectClassificationTypeId: one[0],
                        quotaStatus: one[2] ?? ""),
                CircularChart(
                    sampleQuotaAllocation: one[4].toString(),
                    projectClassificationTypeId: one[0],
                    quotaStatus: one[2] ?? ""),
                BarChartVertical(),
                oneOffTracking
                    ? RegionWiseChart(
                        id: one[1].toString(),
                        visitMonth: repeatList[0].name,
                        sampleQuotaAllocation: one[4].toString())
                    : RegionWiseChart(
                        id: one[1].toString(),
                        visitMonth: oneOffList[0].name,
                        sampleQuotaAllocation: one[4].toString()),
                GoogleMapPage(),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppColors.mainColor,
        unselectedItemColor: AppColors.mainColor1,
        items: _bottomNavigationBarItems,
        currentIndex: _currentIndex,
        onTap: (index) {
          _pageController.animateToPage(index,
              duration: Duration(milliseconds: 900), curve: Curves.ease);
        },
        //type: BottomNavigationBarType.shifting,
      ),
    );
  }

  List<Widget> _buildScreens() {
    return [
      //CircularChart(),
      //LineChart(),
      //BarChartVertical(),
      //BarChartHorizontal(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.home),
        title: ("Home"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.chart_bar),
        title: ("Settings"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.chart_pie),
        title: ("Home"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.graph_circle),
        title: ("Settings"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }

  void rebuildAllChildren(BuildContext context) {
    void rebuild(Element el) {
      el.markNeedsBuild();
      el.visitChildren(rebuild);
    }

    (context as Element).visitChildren(rebuild);
  }

  void getOneOffWave() {
    var field = Get.find<WaveProjectControllerOneOff>();
    if (one[2] != null) {
      field.getWaveOneOff(one[1].toString(), one[2], one[3].toString());
    }
    print("printf " + field.waveList.toString());
    field.waveList.length;

    List<OneOffWave> _getWave = [];
    for (int i = 0; i < field.waveList.length; i++) {
      _getWave.add(OneOffWave(
        field.waveList[i].id,
        field.waveList[i].name,
      ));
    }
    // _selectedRepeat = repeatList[0].name;
    oneOffList = _getWave;
  }

  void getWaveController() {
    var field = Get.find<WaveProjectController>();
    if (one[2] != null) {
      field.getWave(one[1].toString(), one[2], one[3].toString());
    }
    print("printf " + field.waveList.toString());
    field.waveList.length;

    List<ProjectWave> _getWave = [];
    for (int i = 0; i < field.waveList.length; i++) {
      _getWave.add(ProjectWave(
        field.waveList[i].id,
        field.waveList[i].name,
        field.waveList[i].currentWave,
        DateFormat('yyyy-MM-dd').format(field.waveList[i].waveStartDate),
        DateFormat('yyyy-MM-dd').format(field.waveList[i].waveEndDate),
        DateFormat('yyyy-MM-dd').format(field.waveList[i].fieldCutOffDate),
        DateFormat('yyyy-MM-dd').format(field.waveList[i].qaCutOffDate),
      ));
      _selectedRepeat = _getWave[i].name;
    }

    //_selectedRepeat = repeatList[0].name;
    repeatList = _getWave;
  }

/*  void getTrackingWave() {
    var field = Get.find<TrackingController>();
    field.tr();
    print("printf " + field.waveList.toString());
    field.waveList.length;

    List<ProjectWave> _getWave = [];
    for (int i = 0; i < field.waveList.length; i++) {
      _getWave.add(ProjectWave(
        field.waveList[i].id,
        field.waveList[i].name,
        field.waveList[i].currentWave,
        DateFormat('yyyy-MM-dd').format(field.waveList[i].waveStartDate),
        DateFormat('yyyy-MM-dd').format(field.waveList[i].waveEndDate),
        DateFormat('yyyy-MM-dd').format(field.waveList[i].fieldCutOffDate),
        DateFormat('yyyy-MM-dd').format(field.waveList[i].qaCutOffDate),
      ));
    }

    repeatList = _getWave;
  }*/

}

class ProjectWave {
  final int id;
  final String name;
  final bool currentWave;
  final String waveStartDate;
  final String waveEndDate;
  final String fieldCutOffDate;
  final String qaCutOffDate;

  ProjectWave(this.id, this.name, this.currentWave, this.waveStartDate,
      this.waveEndDate, this.fieldCutOffDate, this.qaCutOffDate);
}

class OneOffWave {
  final int id;
  final String name;

  OneOffWave(this.id, this.name);
}

class MyData {
  final String legend;
  final int value;

  MyData(this.legend, this.value);
}

Future<void> getAllFutureData(
    String id,
    String selectedRepeat,
    String quotaStatus,
    String projectClassificationTypeId,
    List<String> status) async {
  await Get.find<StatusQAController>()
      .mQaStatus(id, selectedRepeat, "pass", "pending");

  await Get.find<QAAchievementController>()
      .mQAAchievement(id, selectedRepeat, status);
  await Get.find<SyncWiseController>().syncWise(id, selectedRepeat, status);

  await Get.find<FieldAchievementController>()
      .fieldAchievementData(id, selectedRepeat, ["pass,pending"]);

  if (projectClassificationTypeId == '1') {
    projectClassificationTypeId = "Tracking";
    await Get.find<FirstDayController>()
        .fieldAchievementData(id, selectedRepeat, projectClassificationTypeId);
  } else {
    projectClassificationTypeId = "One-Off";
    await Get.find<FirstDayController>()
        .fieldAchievementData(id, selectedRepeat, projectClassificationTypeId);
  }
  if (quotaStatus != null || quotaStatus == "") {
    await Get.find<QAPassController>().mQAPass(id, selectedRepeat, quotaStatus);
    await Get.find<QAFailController>().mQAPass(id, selectedRepeat, quotaStatus);
    await Get.find<OverAllAchievementController>()
        .mOverAllAchievement(id, selectedRepeat, quotaStatus);
    await Get.find<RegionProgressController>()
        .mRegionProgress(id, selectedRepeat, quotaStatus);
  }
/*  var field = Get.find<StatusQAController>();
  await field.mQaStatus("120","Quota Testing","pass","pending");
  field.qaStatusAchievement;*/
}

Future<void> getAllPassPendingData(
    String id, String name, List<String> selectedItem) async {
  await Get.find<FieldAchievementController>()
      .fieldAchievementData(id, name, selectedItem);
  await Get.find<SyncWiseController>().syncWise(id, name, selectedItem);
}
