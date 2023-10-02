import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:markit_jetty/controller/app_project_dd_controller.dart';
import 'package:markit_jetty/controller/batch_controller.dart';
import 'package:markit_jetty/controller/diagnostic_jetty_controller.dart';
import 'package:markit_jetty/controller/filed_achievement_controller.dart';
import 'package:markit_jetty/controller/first_day_controller.dart';
import 'package:markit_jetty/controller/heirarchy_controller.dart';
import 'package:markit_jetty/controller/lat_long_controller.dart';
import 'package:markit_jetty/controller/qa_fail_controller.dart';
import 'package:markit_jetty/controller/qa_pass_controller.dart';
import 'package:markit_jetty/controller/qa_status_user_id_controller.dart';
import 'package:markit_jetty/controller/region_progress_controller.dart';
import 'package:markit_jetty/controller/sync_wise_controller.dart';
import 'package:markit_jetty/controller/wave_project_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controller/achievement_controller.dart';
import '../controller/one_off_controller.dart';
import '../controller/overall_achievement.dart';
import '../controller/project_controller.dart';
import '../controller/qa_achievement_controller.dart';
import '../controller/qa_status_controller.dart';
import '../controller/qa_status_user_filed_date_controller.dart';
import '../controller/region_level_wave_controller.dart';
import '../controller/tracking_controller.dart';
import '../controller/wave_controller_one_off.dart';
import '../helper/dependencies.dart';
import '../routes/route_helper.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  late SharedPreferences prefs;

  Future<void> _loadResources() async {
/*    Get.find<ProjectController>();
    await Get.find<ProjectController>().getProjectList("3","1");*/

    prefs = await SharedPreferences.getInstance();
    var status = prefs.getBool('isLoggedIn') ?? false;


    print(status);
/*    if (status) {
      String userId = prefs.getString("userId") ?? "0";
      String userCompanyId = prefs.getString("userCompanyId") ?? "0";

      await Get.find<ProjectController>().getProjectList(userId, userCompanyId);
    }*/

   /* await Get.find<DDAppProjectController>().getDdData();
    await Get.find<DiagnosticJettyController>();
    await Get.find<OneOffSetting>();
    await Get.find<TrackingController>();
    await Get.find<AchievementController>();
    await Get.find<StatusQAController>()
        .mQaStatus("120", "Quota Testing", "pass", "pending");
    await Get.find<QAAchievementController>()
        .mQAAchievement("7", "Wave - 8 June", ["pass", "pending"]);*/
    //await Get.find<QAFailController>().mQAPass();
    // await Get.find<QAPassController>().mQAPass("120","Quota Testing","interLockQuota");
    //await Get.find<FieldAchievementController>().fieldAchievementData("7","Wave - 8 June",["pass","pending"]);
    //await Get.find<OverAllAchievementController>().mOverAllAchievement();
    //await Get.find<FirstDayController>().fieldAchievementData("120","Quota Testing","One-Off");
    //await Get.find<RegionProgressController>().mRegionProgress("120","Quota Testing","fixedQuota");
  /*  await Get.find<LatLongController>()
        .mGetLatLong("120", "Quota Testing", "pass", "pending");
    Get.find<WaveProjectController>();
    Get.find<WaveProjectControllerOneOff>();*/

    // await Get.find<RegionLevelWaveController>().getRegionLevelWave("155", "", "");
/*    await Get.find<SyncWiseController>()
        .syncWise("155", "MerginSampleComp", ["pass", "pending"]);*/
    //await Get.find<BatchController>().getBatchData("155");
    //await Get.find<HierarchyControllerUser>().getHierarchyData(291, "sindh", 1,"155","MerginSampleComp");
    //await Get.find<QAStatusUserFieldDateController>().fieldDateQaData(127, 2, 665,"155","MerginSampleComp");
    //await Get.find<QAStatusUserIdController>().fieldDateQaData(127, 2, 665,"155","MerginSampleComp");
  }

  @override
  void initState() {
    super.initState();
    _loadResources();

    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2))
          ..forward();
    animation =
        CurvedAnimation(parent: controller, curve: Curves.linearToEaseOut);

    Timer(
        //const Duration(seconds: 3), () => Get.offNamed(RouteHelper.getlogin()));
        const Duration(seconds: 3), () {
      navigateUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Stack(
          children: [
            Positioned.fill(
              child: Opacity(
                opacity: 0.7,
                child: Image.asset(
                  "assets/images/bgback.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            ScaleTransition(
              scale: animation,
              child: Transform.scale(
                scale: .7,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset("assets/images/jetty04.png"),
                        /*Text(
                          'Markit Jetty',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              fontWeight: FontWeight.bold),
                        )*/

                        /*   Spacer(),
                        Transform.scale(
                          scale: 0.25,
                          child: Image.asset(
                            "assets/images/digital.png",
                          ),
                        ),*/
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              child: Transform.scale(
                scale: 0.25,
                child: Image.asset(
                  "assets/images/pb2.png",
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void navigateUser() async {
    //await init();

    var status = prefs.getBool('isLoggedIn') ?? false;
    print(status);
    if (status) {
      String userId = prefs.getString("userId") ?? "0";
      String userCompanyId = prefs.getString("userCompanyId") ?? "0";

      /* await Get.find<ProjectController>()
          .getProjectList(userId, userCompanyId);*/

      Get.offNamed(RouteHelper.getNavePages());
    } else {
      Get.offNamed(RouteHelper.getlogin());
    }
  }
}
