import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:markit_jetty/controller/one_off_controller.dart';
import 'package:markit_jetty/controller/project_controller.dart';
import 'package:markit_jetty/models/my_project_model.dart';
import 'package:markit_jetty/models/tracking_model.dart';
import 'package:markit_jetty/utils/app_constants.dart';
import 'package:markit_jetty/utils/colors.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controller/achievement_controller.dart';
import '../controller/batch_controller.dart';
import '../controller/tracking_controller.dart';
import '../controller/wave_project_controller.dart';
import '../models/project_model.dart';
import '../routes/route_helper.dart';

class ProjectPage extends StatefulWidget {
  const ProjectPage({Key? key}) : super(key: key);

  @override
  State<ProjectPage> createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {
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
  void initState() {
    // TODO: implement initState
    super.initState();

    getLoggedInDataProject();

    /*
    Get.find<ProjectController>();
    Get.find<OneOffSetting>();
    Get.find<TrackingController>();
    Get.find<AchievementController>();
*/
  }

/*  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    Get.find<ProjectController>();
    Get.find<OneOffSetting>();
    Get.find<TrackingController>();
    Get.find<AchievementController>();
  }*/

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final value = await showDialog<bool>(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Alert'),
                content: Text('Do you want to exit?'),
                actions: [
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: Text("No"),
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: Text("Exit"),
                  ),
                ],
              );
            });
        if (value != null) {
          return Future.value(value);
        } else {
          return Future.value(false);
        }
      },
      child: Scaffold(
        /*   floatingActionButton: FloatingActionButton(
          onPressed: ()=>setState(() {
          //  rebuildAllChildren(context);
          }),
          child: const Icon(Icons.refresh, color: Colors.white),
        ),*/
        body: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            _showProjects(),
          ],
        ),
      ),
    );
  }

  _showProjects() {
    return Expanded(
      child: GetBuilder<ProjectController>(
        builder: (projectList) {
          return projectList.isLoading
              ? ListView.builder(
                  /*     scrollDirection: Axis.vertical,
        shrinkWrap: true,*/
                  itemCount: projectList.projectList.length,
                  itemBuilder: (context, index) {
                    String startDate = "";
                    String dateEnd = "";
                    int totalSample = 0;
                    DateTime graphDateStart;
                    DateTime graphDateEnd;

                    //field.waveList[index].waveStartDate;
                    Project project = projectList.projectList[index];

                    getAllSimpleSurvey(project);
                    int sample = project.sampleQuotaAllocation!;

                    return AnimationConfiguration.staggeredList(
                      position: index,
                      child: SlideAnimation(
                        child: FadeInAnimation(
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed(
                                      RouteHelper.getProjectDetailed(index));
                                  //Get.offNamedUntil( RouteHelper.getProjectDetailed(index), (route) => false);
                                  Get.find<BatchController>()
                                      .getBatchData(project.id.toString());
                                  //Get.toNamed(RouteHelper.getBottomScreen());
                                },
                                child: getProjectData(
                                  context,
                                  project,
                                  /*elapsedTime.toString(),
                              expectedAchievement.toString(),
                              difference.toString()*/
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                )
              : Center(
                  child: Container(
                    child: SpinKitThreeInOut(
                      color: AppColors.mainColor,
                      size: 50.0,
                    ),
                    /*CircularProgressIndicator(
                      color: AppColors.mainColor,
                    ),*/
                  ),
                );
        },
      ),
    );
  }

  Future<void> getAllSimpleSurvey(Project project) async {
    if (project.studyType == "Simple Survey") {
      if (project.projectClassificationTypeId == AppConstants.ONE_OFF) {
        var oneOff = Get.find<OneOffSetting>();

        await getOneOffSetting(oneOff, project);
      } else if (project.projectClassificationTypeId == AppConstants.TRACKING) {
        var oneOff = Get.find<TrackingController>();

        await getTracking(oneOff, project);
      }
    }
  }

  Future getTracking(TrackingController oneOff, Project project) async {
    return await oneOff.tracking(project.id.toString()).then((value) async {
      //return oneOff.tracking("7").then((value) {
      if (value.isNotEmpty) {
        // List<MYData> mydata=  value;
        print("Inside Tracking Api");

        for (int i = 0; i < value.length; i++) {
          if (value[i].currentWave == true) {
            print(value[i].name);

            String startDate = "";
            String dateEnd = "";
            int totalSample = 0;
            DateTime graphDateStart;
            DateTime graphDateEnd;
            //project.projectName = value[0].name;

            project.wave = value[i].name;

            /*project.fieldStartDate = project.startingDate;
            project.fieldEndDate = project.endingDate;*/

            if (value[0].waveStartDate != null) {
              graphDateStart = value[0].waveStartDate;
              startDate = DateFormat('yyyy-MM-dd').format(graphDateStart);

              project.startingDate = startDate;
            } else {
              project.startingDate = "0";
            }

            if (value[0].waveEndDate != null) {
              graphDateEnd = value[0].waveEndDate;
              dateEnd = DateFormat('yyyy-MM-dd').format(graphDateEnd);
              project.endingDate = dateEnd;
            } else {
              project.endingDate = "0";
            }

            // project.startingDate = value[i].waveStartDate.toString();

            var total = Get.find<AchievementController>();
            await getTotalAchievement(total, project, value, i);

            /*  setState(() {

            });*/
          } else {}
        }

        /*
      graphDateStart = value[0].fieldStartDate;
      startDate = DateFormat('yyyy-MM-dd').format(graphDateStart);

      graphDateEnd = value[0].fieldEndDate;
      dateEnd = DateFormat('yyyy-MM-dd').format(graphDateEnd);*/
      } else {
        project.startingDate = null;
        project.endingDate = null;
      }
    });
  }

  Future getTotalAchievement(AchievementController total, Project project,
      List<TrackingModel> value, int i) async {
    return await total
        .totalAchievementData(project.id.toString(), value[i].name)
        // .totalAchievementData("7", "Wave - 8 June")
        .then((totalValue) {
      if (totalValue != null) {
        //  setState(() {
        print("Inside Total Achievement");
        print(totalValue);
        project.totalAchivement = totalValue;
        //});

        /*setState(() {});*/
        //totalSample = totalValue as int;
      }
    });
  }

  Future getOneOffSetting(OneOffSetting oneOff, Project project) async {
    return await oneOff.oneOff(project.id.toString()).then((value) async {
      //return oneOff.oneOff("120").then((value) {
      if (value.isNotEmpty) {
        // List<MYData> mydata=  value;
        print("Inside oneOff Api ");
        print(value[0].name);
        print("name");
        print(project.projectName);

        String startDate = "";
        String dateEnd = "";
        int totalSample = 0;
        DateTime graphDateStart;
        DateTime graphDateEnd;

        project.wave = value[0].name;

        // project.projectName = value[0].name;

/*        graphDateStart = value[0].fieldStartDate;
        startDate = DateFormat('yyyy-MM-dd').format(graphDateStart);

        graphDateEnd = value[0].fieldEndDate;
        dateEnd = DateFormat('yyyy-MM-dd').format(graphDateEnd);

        project.startingDate = startDate;
        project.endingDate = dateEnd;*/

        print("My Date");
        print(project.startingDate);
   /*     project.fieldStartDate = project.startingDate;
        project.fieldEndDate = project.endingDate;*/
        if (value[0].fieldStartDate != null) {
          graphDateStart = value[0].fieldStartDate;
          startDate = DateFormat('yyyy-MM-dd').format(graphDateStart);

          project.startingDate = startDate;
        } else {
          project.startingDate = "0";
        }

        if (value[0].fieldEndDate != null) {
          graphDateEnd = value[0].fieldEndDate;
          dateEnd = DateFormat('yyyy-MM-dd').format(graphDateEnd);
          project.endingDate = dateEnd;
        } else {
          project.endingDate = "0";
        }

        var total = Get.find<AchievementController>();
        await total
            .totalAchievementData(project.id.toString(), value[0].name)
            .then((value) {
          if (value.isNotEmpty) {
            //     setState(() {

            print("Inside Total Achievement");
            print(value);
            project.totalAchivement = value;
            //   });
            /*setState(() {});*/
          }
        });

/*
        setState(() {

        });*/

        /*
     graphDateStart = value[0].fieldStartDate;
     startDate = DateFormat('yyyy-MM-dd').format(graphDateStart);

     graphDateEnd = value[0].fieldEndDate;
     dateEnd = DateFormat('yyyy-MM-dd').format(graphDateEnd);*/
      } else {
        project.startingDate = null;
        project.endingDate = null;
      }
    });
  }

  Container getProjectData(BuildContext context, Project project) {
    int daysBetween(DateTime from, DateTime to) {
      from = DateTime(from.year, from.month, from.day);
      to = DateTime(to.year, to.month, to.day);
      DateTime newFromDate = from.subtract(Duration(days: 1));
      return (to.difference(newFromDate).inDays).round();
    }

    String dateE = "";
    String dateStart = "";
    double lag = 0;
    double lagProgressColor = 0;
    double percent = 0;
    String roundedX = "0";

    double forColor = 0;
    Map<int, Color> color = {
      50: Color.fromRGBO(4, 131, 184, .1),
      100: Color.fromRGBO(4, 131, 184, .2),
      200: Color.fromRGBO(4, 131, 184, .3),
      300: Color.fromRGBO(4, 131, 184, .4),
      400: Color.fromRGBO(4, 131, 184, .5),
      500: Color.fromRGBO(4, 131, 184, .6),
      600: Color.fromRGBO(4, 131, 184, .7),
      700: Color.fromRGBO(4, 131, 184, .8),
      800: Color.fromRGBO(4, 131, 184, .9),
      900: Color.fromRGBO(4, 131, 184, 1),
    };
    MaterialColor progress = MaterialColor(0xFF880E4F, color);

    /*   currentProgressColor(lag) {
      if (lag <= 90) {
        return Colors.red;
      }
      if (lag >=50 && lag < 100) {
        return Colors.yellow;
      } else {
        return Colors.green;
      }
    }*/

    currentProgressColor(lag) {
      print("$lag my color value");
      if (lag >= 90 && lag <= 99) {
        return Colors.yellow;
      }
      if (lag < 90) {
        return Colors.red;
      } else {
        return Colors.green;
      }
    }

    if (project.startingDate != null && project.endingDate != null) {
      final startDate = DateFormat('yyyy-MM-dd').parse(project.startingDate!);
      print("$startDate startdayB");
      dateStart = DateFormat('yyyy-MM-dd').format(startDate);
      print("$dateStart startday");
      final dateEnding = DateFormat('yyyy-MM-dd').parse(project.endingDate!);
      print("$dateEnding enddate");
      dateE = DateFormat('yyyy-MM-dd').format(dateEnding);
      print("$dateE enddateE");
      final date2 = DateTime.now();
      final difference = daysBetween(startDate, date2);
      final totalDays = daysBetween(startDate, dateEnding);
      print(
          "($difference difference with start and current date) ($totalDays totalDays with start and end)");
      final elapsedTime = difference / totalDays;
      print("$elapsedTime elapsedTime");
      int achivement = 0;
      double expectedAchievement = 0;



      if (project.totalAchivement != null) {
        print("${project.totalAchivement!} totalAchivement");
        achivement = int.parse(project.totalAchivement!);
        expectedAchievement = achivement * elapsedTime;
        //expectedAchievement = project.sampleQuotaAllocation! * elapsedTime;
        print("$expectedAchievement expectedAchievement");
        if (expectedAchievement != 0) {
          print(
              "${project.sampleQuotaAllocation!} sampleQuotaAllocation :: ${project.projectName!} projectName");
          final hammad =
              (project.sampleQuotaAllocation! * 100 / expectedAchievement);
          print("hammad $hammad");
          //lag = (project.sampleQuotaAllocation! / expectedAchievement) / 100;
          percent = (achivement / project.sampleQuotaAllocation!) * 100;
          //percent.round();
          //double x = 5.56753;
          if(percent >= 100){
            percent = 100;
          }

          if(difference <= totalDays) {
            lagProgressColor =
                (project.sampleQuotaAllocation! / totalDays) * difference;
          }else{
            lagProgressColor =
                (project.sampleQuotaAllocation! / totalDays) * totalDays;
          }
          print("color pro before $lagProgressColor");
          lagProgressColor = (achivement / lagProgressColor) * 100;
          print("color pro after $lagProgressColor");

          roundedX = percent.toStringAsFixed(2);
          roundedX = percent.ceil().toString();


          print(roundedX);

          forColor = double.parse(roundedX);

          project.percent = roundedX.toString();
          print((achivement / project.sampleQuotaAllocation!) * 100);
          lag = percent / 100;
          if (lag >= 1.0) {
            lag = 1.0;
          }
          project.indicatorProgress = lag;
          print("$lag lag");

          progress = currentProgressColor(lagProgressColor);
          project.color = progress;
        }
      }
    }

    print('');

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(bottom: 15),
      child: Container(
        padding: EdgeInsets.all(14),
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
            ]),
        child: Row(children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    CircularPercentIndicator(
                      radius: 40.0,
                      lineWidth: 8.0,
                      animation: true,
                      percent: lag,
                      center: new Text(
                        "$roundedX %",
                        style: new TextStyle(
                            fontWeight: FontWeight.w300, fontSize: 13.0),
                      ),
                      /*footer: new Text(
                    "Sales this week",
                    style: new TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 17.0),
                  ),*/
                      circularStrokeCap: CircularStrokeCap.round,
                      progressColor: progress,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Text(
                            project.projectName ?? "",
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.mainColor),
                            ),
                          ),
                          width: 190,
                        ),
                        SizedBox(
                          height: 22,
                        ),
                        Text("Field Start Date: $dateStart",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 11,
                                overflow: TextOverflow.ellipsis)
                            //DateFormat('MM-dd').format(project.startingDate),
                            ),
                        SizedBox(height: 5),
                        Text(
                          "Field End Date: $dateE",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 11,
                          ),
                          //DateFormat('MM-dd').format(project.startingDate),
                        ),
                        /*         SizedBox(height: 5),
                        Text(
                          "Field End Date: $different",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 11),
                          //DateFormat('MM-dd').format(project.startingDate),
                        ),*/
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 22),
                Divider(color: Colors.black),
                Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        //color: Colors.red,
                        child: Text(
                          "Created By: ${project.users![0].incharge}" ?? "",
                          style: TextStyle(
                              fontWeight: FontWeight.w200, color: Colors.grey),
                        ),
                      ),
                    ),
                  ],
                )
                /*  Text(
                  "Created By: ${project.clientName}" ?? "",
                  style: TextStyle(
                      fontWeight: FontWeight.w200, color: Colors.grey),
                ),*/
              ],
            ),
          ),
        ]),
      ),
    );
  }

  MaterialColor getColor(double lag) {
    if (lag < 90) {
      return Colors.red;
    }
    if (lag <= 90 && lag < 100) {
      return Colors.yellow;
    } else {
      return Colors.green;
    }
  }

  Future<void> getLoggedInDataProject() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var status = prefs.getBool('isLoggedIn') ?? false;

    String userId = prefs.getString("userId") ?? "0";
    String userCompanyId = prefs.getString("userCompanyId") ?? "0";

    if (status) {
      setState(() {
        Get.find<ProjectController>().getProjectList(userId, userCompanyId);
      });
    }
  }
}
