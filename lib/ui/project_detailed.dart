import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:markit_jetty/controller/project_controller.dart';
import 'package:markit_jetty/utils/colors.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../controller/achievement_controller.dart';
import '../controller/one_off_controller.dart';
import '../controller/qa_status_controller.dart';
import '../controller/tracking_controller.dart';
import '../controller/wave_controller_one_off.dart';
import '../controller/wave_project_controller.dart';
import '../models/project_model.dart';
import '../routes/route_helper.dart';
import '../utils/app_constants.dart';
import '../widget/input_field.dart';

class ProjectDetailed extends StatefulWidget {
  final int pageIdIndex;

  const ProjectDetailed({Key? key, required this.pageIdIndex})
      : super(key: key);

  @override
  State<ProjectDetailed> createState() => _ProjectDetailedState();
}

class _ProjectDetailedState extends State<ProjectDetailed>
    with TickerProviderStateMixin {
  /* @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    Get.find<ProjectController>();
    Get.find<OneOffSetting>();
    Get.find<TrackingController>();
    Get.find<AchievementController>();
  }
*/

  bool progressShow = false;
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2))
          ..forward();
    animation =
        CurvedAnimation(parent: controller, curve: Curves.linearToEaseOut);
  }

  bool visibilityAction = false;
  bool visibilityDateTime = false;

  void _changed(bool visibility, String field) {
    setState(() {
      if (field == "action") {
        visibilityAction = visibility;
      }
      if (field == "datetime") {
        visibilityDateTime = visibility;
      }
    });
  }

  String _selectedRepeat = "Wave - 8 June";
  List<String> repeatList = [
    "Wave - 8 June",
    "Wave - 19 july",
    "Wave - 10 August",
    "Wave - 1 September",
  ];
  bool _isAction = false;

  DateTime _selectedDate = DateTime.now();

  List stocksList = [
    CompanyStocks(name: "Data Tool", price: 24.863744, price2: 67.0604318),
    CompanyStocks(
        name: "Project Setting", price: 24.963744, price2: 67.1304318),
    CompanyStocks(
        name: "Region Management", price: 24.763744, price2: 67.040428),
    CompanyStocks(name: "Data Tool", price: 24.863744, price2: 67.0604318),
    CompanyStocks(
        name: "Project Setting", price: 24.963744, price2: 67.1304318),
    CompanyStocks(
        name: "Region Management", price: 24.763744, price2: 67.040428),
  ];

  @override
  Widget build(BuildContext context) {
    Get.find<ProjectController>();
    var project = Get.find<ProjectController>().projectList[widget.pageIdIndex];

    String checkClass = project.projectClassificationType;

    String date = "";
    String dateEnd = "";

    String dateField = "";
    String dateEndField = "";
    if (project.startingDate != null) {
      DateTime tempDate = DateFormat('yyyy-MM-dd').parse(project.startingDate!);
      date = DateFormat('yyyy-MM-dd').format(tempDate);
    }
    if (project.endingDate != null) {
      DateTime tempDate = DateFormat('yyyy-MM-dd').parse(project.endingDate!);
      dateEnd = DateFormat('yyyy-MM-dd').format(tempDate);
    }

    if (project.fieldStartDate != null) {
      DateTime tempDate =
          DateFormat('yyyy-MM-dd').parse(project.fieldStartDate!);
      dateField = DateFormat('yyyy-MM-dd').format(tempDate);
    }
    if (project.fieldEndDate != null) {
      DateTime tempDate = DateFormat('yyyy-MM-dd').parse(project.fieldEndDate!);
      dateEndField = DateFormat('yyyy-MM-dd').format(tempDate);
    }

    print("page is id " + widget.pageIdIndex.toString());
    print("product name is " + project.projectName.toString());

    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/detailedbg.png"),
                  fit: BoxFit.fill,
                ),
              ),
              padding: EdgeInsets.only(top: 50, left: 30, right: 30),
              width: MediaQuery.of(context).size.width,
              height: 280,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.back();
                          //Get.toNamed(RouteHelper.getNavePages());
                        },
                        child: Icon(
                          Icons.arrow_back_ios,
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: 270,
                        child: Text(
                          project.projectName,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      /*Expanded(child: Container()),
                        Icon(
                          Icons.info_outline,
                          size: 20,
                          color: Colors.white,
                        ),*/
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                CircularPercentIndicator(
                                  radius: 60.0,
                                  lineWidth: 11.0,
                                  animation: true,
                                  percent: project.indicatorProgress ?? 0,
                                  center: Text(
                                    "${project.percent} %" ?? "0",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 19.0),
                                  ),
                                  circularStrokeCap: CircularStrokeCap.round,
                                  progressColor: project.color,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Sample Achieved: ${project.percent}%",
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13,
                                            overflow: TextOverflow.ellipsis)
                                        //DateFormat('MM-dd').format(project.startingDate),
                                        ),
                                    SizedBox(height: 9),
                                    Text(
                                        "Achievement Count: ${project.totalAchivement.toString()}",
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13,
                                            overflow: TextOverflow.ellipsis)
                                        //DateFormat('MM-dd').format(project.startingDate),
                                        ),
                                    SizedBox(height: 9),
                                    Text(
                                        "Total Sample: ${project.sampleQuotaAllocation.toString()}",
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13,
                                            overflow: TextOverflow.ellipsis)
                                        //DateFormat('MM-dd').format(project.startingDate),
                                        ),
                                    SizedBox(height: 9),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GetBuilder<WaveProjectControllerOneOff>(
                    builder: (controller) {
                      return GestureDetector(
                        onTap: () async {
                          setState(() {
                            progressShow = true;
                          });

                          //  await Get.find<WaveProjectController>().getWave(project.id.toString(),project.projectSettings[0].quotaStatus,project.projectClassificationTypeId.toString());
                          if (project.projectClassificationTypeId ==
                              AppConstants.ONE_OFF) {
                            await Get.find<WaveProjectControllerOneOff>()
                                .getWaveOneOff(
                                    project.id.toString(),
                                    project.projectSettings[0].quotaStatus ??
                                        "",
                                    project.projectClassificationTypeId
                                        .toString());
                          } else if (project.projectClassificationTypeId ==
                              AppConstants.TRACKING) {
                            await Get.find<WaveProjectController>().getWave(
                                project.id.toString(),
                                project.projectSettings[0].quotaStatus ?? "",
                                project.projectClassificationTypeId.toString());
                          }

                          Get.toNamed(RouteHelper.getBottomScreen(),
                              arguments: [
                                project.projectClassificationTypeId,
                                project.id,
                                project.projectSettings[0].quotaStatus,
                                project.projectClassificationTypeId,
                                project.sampleQuotaAllocation,
                                project.projectName,
                              ]);

                          setState(() {
                            progressShow = false;
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            /*                         progressShow
                                ? Center(
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 60),
                                      child: Container(
                                        width: 21,
                                        height: 21,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  )
                                : Container(),*/
                            Container(
                              width: 90,
                              height: 30,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(
                                  colors: [
                                    AppColors.textColor,
                                    AppColors.mainColorGrad2,
                                  ],
                                  begin: Alignment.bottomLeft,
                                  end: Alignment.topRight,
                                ),
                                /*     boxShadow: [
                                BoxShadow(
                                  color: Colors.white.withOpacity(0.2),
                                  spreadRadius: 1,
                                  blurRadius: 3,
                                  offset: Offset(-2, 3), // changes position of shadow
                                ),
                              ],*/
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.stacked_line_chart,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "Info",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            /*      ScaleTransition(
              scale: animation,
              child:*/
            Container(
              padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
              margin: EdgeInsets.only(bottom: 15, right: 15, left: 15, top: 15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(0),
                  ),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black54.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: Offset(-2, 3), // changes position of shadow
                    ),
                  ]),
              width: double.infinity,
              height: 220,
              /*          decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(0),
                        topLeft: Radius.circular(0),
                      ),
                    ),*/
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Project Details",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87),
                  ),
                  Divider(color: Colors.black45),
                  /*SizedBox(
                        height: 10,
                      ),*/
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Created On:",
                        style: TextStyle(
                            fontSize: 13,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        dateField ?? "not found",
                        //date ?? "not found",
                        style: TextStyle(fontSize: 13, color: Colors.black54),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Ending On:",
                        style: TextStyle(
                            fontSize: 13,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        dateEndField ?? "not found",
                        //dateEnd ?? "not found",
                        style: TextStyle(fontSize: 13, color: Colors.black54),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Study Type:",
                        style: TextStyle(
                            fontSize: 13,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        project.studyType! ?? "not found",
                        style: TextStyle(fontSize: 13, color: Colors.black54),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Classification:",
                        style: TextStyle(
                            fontSize: 13,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        project.projectClassificationType! ?? "not found",
                        style: TextStyle(fontSize: 13, color: Colors.black54),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Description:",
                        style: TextStyle(
                            fontSize: 13,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        project.projectDescription! ?? "not found",
                        style: TextStyle(fontSize: 13, color: Colors.black54),
                      ),
                    ],
                  ),
                  /*SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Field Start Date",
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.black54,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            project.fieldStartDate! ?? "not found",
                            style: TextStyle(fontSize: 15, color: Colors.black54),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Field End Date",
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.black54,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            project.fieldEndDate! ?? "not found",
                            style: TextStyle(fontSize: 15, color: Colors.black54),
                          ),
                        ],
                      ),*/

                  /*   SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Current Wave",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              project.projectDescription! ?? "not found",
                              style: TextStyle(
                                  fontSize: 15, color: Colors.black54),
                            ),
                          ],
                        ),
*/
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Created By:",
                        style: TextStyle(
                            fontSize: 13,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        project.users![0].incharge ?? "not found",
                        style: TextStyle(fontSize: 13, color: Colors.black54),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  checkClass == "One-Off"
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Quota Type:",
                              style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              project.projectSettings[0].quotaName ?? " ",
                              // project.users![0].incharge ?? "not found",
                              style: TextStyle(
                                  fontSize: 13, color: Colors.black54),
                            ),
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Wave Count:",
                              style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              project.waveCount.toString() ?? " ",
                              // project.users![0].incharge ?? "not found",
                              style: TextStyle(
                                  fontSize: 13, color: Colors.black54),
                            ),
                          ],
                        ),
                ],
              ),
              /*child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              "Diagnostic Area",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54),
                            ),
                            */ /* Expanded(child: Container()),
                            Icon(
                              Icons.info_rounded,
                              size: 26,
                              color: Colors.grey,
                            ),*/ /*
                            SizedBox(
                              width: 20,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 18.0, right: 18.0),
                          child: MyInputWidget(
                            title: "Activity",
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
                                  */ /*   repeatList.map<DropdownMenuItem<ProjectWave>>((ProjectWave? value) {
                      return DropdownMenuItem<ProjectWave>(
                        value: value,
                        child: Text(value!.name, style: TextStyle(color: Colors.grey)),
                      );
                    }*/ /*
                                  repeatList.map<DropdownMenuItem<String>>(
                                      (String? value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value!,
                                      style: TextStyle(color: Colors.grey)),
                                );
                              }).toList(),
                              onChanged: (String? value) {
                                setState(() {
                                  _selectedRepeat = value!;
                                  _changed(true, "action");

                                  //     getAllFutureData();
                                  build(context);

                                  */ /*Get.find<StatusQAController>().mQaStatus("120","Quota Testing","pass","pending").then((status){

                          if(status != null){

                            final List<MyData> chartData = [
                              //MyData('LastDayQA', field.qaStatusAchievement[0].lastDayQa),
                              MyData('Fail', status.fail),
                              MyData('Pass', status.pass),
                              MyData('Total', status.total)
                            ];

                            _qaStatus.addAll(chartData);

                          }
                        });*/ /*
                                });
                              },
                            ),
                          ),
                        ),
                        visibilityAction
                            ? Padding(
                                padding:
                                    const EdgeInsets.only(left: 18.0, right: 18.0),
                                child: MyInputWidget(
                                  title: "Action",
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
                                        */ /*   repeatList.map<DropdownMenuItem<ProjectWave>>((ProjectWave? value) {
                      return DropdownMenuItem<ProjectWave>(
                          value: value,
                          child: Text(value!.name, style: TextStyle(color: Colors.grey)),
                      );
                    }*/ /*
                                        repeatList.map<DropdownMenuItem<String>>(
                                            (String? value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value!,
                                            style: TextStyle(color: Colors.grey)),
                                      );
                                    }).toList(),
                                    onChanged: (String? value) {
                                      setState(() {
                                        _selectedRepeat = value!;
                                        _changed(true, "datetime");

                                        //     getAllFutureData();
                                        build(context);

                                        */ /*Get.find<StatusQAController>().mQaStatus("120","Quota Testing","pass","pending").then((status){

                            if(status != null){

                              final List<MyData> chartData = [
                                //MyData('LastDayQA', field.qaStatusAchievement[0].lastDayQa),
                                MyData('Fail', status.fail),
                                MyData('Pass', status.pass),
                                MyData('Total', status.total)
                              ];

                              _qaStatus.addAll(chartData);

                            }
                          });*/ /*
                                      });
                                    },
                                  ),
                                ),
                              )
                            : Container(),
                        visibilityDateTime
                            ? Padding(
                                padding:
                                    const EdgeInsets.only(left: 18.0, right: 18.0),
                                child: MyInputWidget(
                                  title: "From",
                                  hint: DateFormat.yMd().format(_selectedDate),
                                  widget: IconButton(
                                    icon: Icon(
                                      Icons.calendar_today_outlined,
                                      color: Colors.grey,
                                    ),
                                    onPressed: () {
                                      _getDateFromUser();
                                    },
                                  ),
                                ),
                              )
                            : Container(),
                        visibilityDateTime
                            ? Padding(
                                padding:
                                    const EdgeInsets.only(left: 18.0, right: 18.0),
                                child: MyInputWidget(
                                  title: "To",
                                  hint: DateFormat.yMd().format(_selectedDate),
                                  widget: IconButton(
                                    icon: Icon(
                                      Icons.calendar_today_outlined,
                                      color: Colors.grey,
                                    ),
                                    onPressed: () {
                                      _getDateFromUser();
                                    },
                                  ),
                                ),
                              )
                            : Container(),
                        _showProjects(),
                      ],
                    ),*/
            ),
            // ),
            Container(
              padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
              margin: EdgeInsets.only(bottom: 15, right: 15, left: 15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(0),
                  ),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black54.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: Offset(-2, 3), // changes position of shadow
                    ),
                  ]),
              width: double.infinity,
              height: 140,
              /*          decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(0),
                      topLeft: Radius.circular(0),
                    ),
                  ),*/
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Field Details",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87),
                  ),
                  Divider(color: Colors.black45),
                  /*SizedBox(
                      height: 10,
                    ),*/
                  /* Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Created On:",
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.black54,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          date ?? "not found",
                          style: TextStyle(fontSize: 15, color: Colors.black54),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Ending On:",
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.black54,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          dateEnd ?? "not found",
                          style: TextStyle(fontSize: 15, color: Colors.black54),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Study Type:",
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.black54,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          project.studyType! ?? "not found",
                          style: TextStyle(fontSize: 15, color: Colors.black54),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Classification",
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.black54,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          project.projectClassificationType! ?? "not found",
                          style: TextStyle(fontSize: 15, color: Colors.black54),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),*/
                  /* Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Description",
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.black54,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          project.projectDescription! ?? "not found",
                          style: TextStyle(fontSize: 15, color: Colors.black54),
                        ),
                      ],
                    ),*/
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Field Start Date:",
                        style: TextStyle(
                            fontSize: 13,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        date ?? "not found",
                        style: TextStyle(fontSize: 13, color: Colors.black54),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Field End Date:",
                        style: TextStyle(
                            fontSize: 13,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        dateEnd ?? "not found",
                        style: TextStyle(fontSize: 13, color: Colors.black54),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Current Wave:",
                        style: TextStyle(
                            fontSize: 13,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        project.wave ?? "not found",
                        style: TextStyle(fontSize: 13, color: Colors.black54),
                      ),
                    ],
                  ),
                  /*         SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Created By",
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.black54,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          project.users![0].incharge ?? "not found",
                          style: TextStyle(fontSize: 15, color: Colors.black54),
                        ),
                      ],
                    ),*/
                ],
              ),
              /*child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            "Diagnostic Area",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black54),
                          ),
                          */ /* Expanded(child: Container()),
                          Icon(
                            Icons.info_rounded,
                            size: 26,
                            color: Colors.grey,
                          ),*/ /*
                          SizedBox(
                            width: 20,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 18.0, right: 18.0),
                        child: MyInputWidget(
                          title: "Activity",
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
                                */ /*   repeatList.map<DropdownMenuItem<ProjectWave>>((ProjectWave? value) {
                    return DropdownMenuItem<ProjectWave>(
                      value: value,
                      child: Text(value!.name, style: TextStyle(color: Colors.grey)),
                    );
                  }*/ /*
                                repeatList.map<DropdownMenuItem<String>>(
                                    (String? value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value!,
                                    style: TextStyle(color: Colors.grey)),
                              );
                            }).toList(),
                            onChanged: (String? value) {
                              setState(() {
                                _selectedRepeat = value!;
                                _changed(true, "action");

                                //     getAllFutureData();
                                build(context);

                                */ /*Get.find<StatusQAController>().mQaStatus("120","Quota Testing","pass","pending").then((status){

                        if(status != null){

                          final List<MyData> chartData = [
                            //MyData('LastDayQA', field.qaStatusAchievement[0].lastDayQa),
                            MyData('Fail', status.fail),
                            MyData('Pass', status.pass),
                            MyData('Total', status.total)
                          ];

                          _qaStatus.addAll(chartData);

                        }
                      });*/ /*
                              });
                            },
                          ),
                        ),
                      ),
                      visibilityAction
                          ? Padding(
                              padding:
                                  const EdgeInsets.only(left: 18.0, right: 18.0),
                              child: MyInputWidget(
                                title: "Action",
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
                                      */ /*   repeatList.map<DropdownMenuItem<ProjectWave>>((ProjectWave? value) {
                    return DropdownMenuItem<ProjectWave>(
                        value: value,
                        child: Text(value!.name, style: TextStyle(color: Colors.grey)),
                    );
                  }*/ /*
                                      repeatList.map<DropdownMenuItem<String>>(
                                          (String? value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value!,
                                          style: TextStyle(color: Colors.grey)),
                                    );
                                  }).toList(),
                                  onChanged: (String? value) {
                                    setState(() {
                                      _selectedRepeat = value!;
                                      _changed(true, "datetime");

                                      //     getAllFutureData();
                                      build(context);

                                      */ /*Get.find<StatusQAController>().mQaStatus("120","Quota Testing","pass","pending").then((status){

                          if(status != null){

                            final List<MyData> chartData = [
                              //MyData('LastDayQA', field.qaStatusAchievement[0].lastDayQa),
                              MyData('Fail', status.fail),
                              MyData('Pass', status.pass),
                              MyData('Total', status.total)
                            ];

                            _qaStatus.addAll(chartData);

                          }
                        });*/ /*
                                    });
                                  },
                                ),
                              ),
                            )
                          : Container(),
                      visibilityDateTime
                          ? Padding(
                              padding:
                                  const EdgeInsets.only(left: 18.0, right: 18.0),
                              child: MyInputWidget(
                                title: "From",
                                hint: DateFormat.yMd().format(_selectedDate),
                                widget: IconButton(
                                  icon: Icon(
                                    Icons.calendar_today_outlined,
                                    color: Colors.grey,
                                  ),
                                  onPressed: () {
                                    _getDateFromUser();
                                  },
                                ),
                              ),
                            )
                          : Container(),
                      visibilityDateTime
                          ? Padding(
                              padding:
                                  const EdgeInsets.only(left: 18.0, right: 18.0),
                              child: MyInputWidget(
                                title: "To",
                                hint: DateFormat.yMd().format(_selectedDate),
                                widget: IconButton(
                                  icon: Icon(
                                    Icons.calendar_today_outlined,
                                    color: Colors.grey,
                                  ),
                                  onPressed: () {
                                    _getDateFromUser();
                                  },
                                ),
                              ),
                            )
                          : Container(),
                      _showProjects(),
                    ],
                  ),*/
            ),

            //SizedBox(height: 30,),
            progressShow
                ? Transform.scale(
                    scale: .8,
                    child: Container(
                      child: SpinKitThreeInOut(
                        color: AppColors.mainColor,
                        size: 50.0,
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  _showProjects() {
    return Expanded(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: stocksList.length,
        itemBuilder: (context, index) {
          CompanyStocks project = stocksList[index];
          return AnimationConfiguration.staggeredList(
            position: index,
            child: SlideAnimation(
              child: FadeInAnimation(
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        //  Get.toNamed(RouteHelper.getBottomScreen());
                      },
                      child: getProjectData(context, project),
                    ),
                  ],
                ),
              ),
            ),
          );
          /*return GestureDetector(

            onTap: (){

              Get.toNamed(RouteHelper.getBottomScreen());
            },

            child: Card(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: ListTile(
                  title: Text(
                    stocksList[index].name,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  leading: CircleAvatar(
                    child: Text(
                      stocksList[index].name[0],
                      style:
                      TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ),
                  trailing: Text("\$ ${stocksList[index].price}"),
                ),
              ),
            ),
          );*/
        },
      ),
    );
  }

  Container getProjectData(BuildContext context, CompanyStocks task) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(bottom: 12),
      child: Container(
        padding: EdgeInsets.all(16),
        //  width: SizeConfig.screenWidth * 0.78,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 3,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Row(children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.name ?? "",
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      color: AppColors.mainColor,
                      size: 18,
                    ),
                    SizedBox(width: 4),
                    Text(
                      "${task.price} - ${task.price2}",
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Text(
                  "IP Address: 113.203.241.3",
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: 100,
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(
                          colors: [
                            AppColors.green,
                            AppColors.green1,
                          ],
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.done_all,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Success",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
/*          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            height: 60,
            width: 0.5,
            color: Colors.grey[200]!.withOpacity(0.7),
          ),
          RotatedBox(
            quarterTurns: 3,
            child: Text(
              task.isCompleted == 1
                  ? "COMPLETED"
                  : "Todo (${selectedContacts.length})",
              style: GoogleFonts.lato(
                textStyle: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ),*/
        ]),
      ),
    );
  }

  _getDateFromUser() async {
    DateTime? _pickerDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015),
        lastDate: DateTime(2222));

    if (_pickerDate != null) {
      setState(() {
        _selectedDate = _pickerDate;
        print(_selectedDate);
      });
    } else {
      print("it's null  or something is wrong");
    }
  }
}
