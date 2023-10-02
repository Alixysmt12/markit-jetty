import 'package:get/get.dart';
import 'package:markit_jetty/controller/qa_achievement_controller.dart';
import 'package:markit_jetty/controller/qa_fail_controller.dart';
import 'package:markit_jetty/controller/qa_pass_controller.dart';
import 'package:markit_jetty/controller/qa_status_controller.dart';
import 'package:markit_jetty/controller/region_progress_controller.dart';
import 'package:markit_jetty/controller/sync_wise_controller.dart';
import 'package:markit_jetty/data/repository/one_off_wave.dart';

import '../models/one_off_waveModel.dart';
import 'filed_achievement_controller.dart';
import 'first_day_controller.dart';
import 'heirarchy_controller.dart';
import 'lat_long_controller.dart';
import 'overall_achievement.dart';

class WaveProjectControllerOneOff extends GetxController
    implements GetxService {

  final OneOffWave oneOffWave;

  WaveProjectControllerOneOff({required this.oneOffWave});

  List<OneOffWaveModel> _waveList = [];

  List<OneOffWaveModel> get waveList => _waveList;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<void> getWaveOneOff(
      String id, String quotaStatus, String projectClassificationTypeId) async {
    //Future<void> getProjectList() async {
    Response response = await oneOffWave.oneOffWave(id);
    //Response response = await projectRepo.getProject();
    update();


    if (response.statusCode == 200) {
      print('got wave one off');
      print(response.body);

      _waveList = [];
      _waveList = List.from(response.body)
          .map((e) => OneOffWaveModel.fromJson(e))
          .toList();

      await Get.find<StatusQAController>()
          .mQaStatus(id, _waveList[0].name, "pass", "pending");
      await Get.find<QAAchievementController>()
          .mQAAchievement(id, _waveList[0].name, ["pass", "pending"]);
      await Get.find<FieldAchievementController>()
          .fieldAchievementData(id, _waveList[0].name, ["pass", "pending"]);
      await Get.find<LatLongController>()
          .mGetLatLong(id, _waveList[0].name, "pass", "pending");
      await Get.find<SyncWiseController>().syncWise(id, _waveList[0].name, ["pass", "pending"]);

//      await Get.find<HierarchyControllerUser>().getHierarchyData(1, "", 1,"","");

      if (projectClassificationTypeId == '1') {
        projectClassificationTypeId = "Tracking";
        await Get.find<FirstDayController>().fieldAchievementData(
            id, _waveList[0].name, projectClassificationTypeId);
      } else {
        projectClassificationTypeId = "One-Off";
        await Get.find<FirstDayController>().fieldAchievementData(
            id, _waveList[0].name, projectClassificationTypeId);
      }

      if (quotaStatus != null || quotaStatus == "") {
        await Get.find<QAPassController>()
            .mQAPass(id, _waveList[0].name, quotaStatus);
        await Get.find<QAFailController>()
            .mQAPass(id, _waveList[0].name, quotaStatus);
        await Get.find<OverAllAchievementController>()
            .mOverAllAchievement(id, _waveList[0].name, quotaStatus);
        await Get.find<RegionProgressController>()
            .mRegionProgress(id, _waveList[0].name, quotaStatus);
      }

      print(_waveList);

      _isLoading = true;
      update();
    } else {
      print('not got wave one off');
    }

    update();
  }
}
