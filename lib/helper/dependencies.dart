import 'package:get/get.dart';
import 'package:markit_jetty/controller/achievement_controller.dart';
import 'package:markit_jetty/controller/app_project_dd_controller.dart';
import 'package:markit_jetty/controller/batch_controller.dart';
import 'package:markit_jetty/controller/diagnostic_jetty_controller.dart';
import 'package:markit_jetty/controller/first_day_controller.dart';
import 'package:markit_jetty/controller/heirarchy_controller.dart';
import 'package:markit_jetty/controller/lat_long_controller.dart';
import 'package:markit_jetty/controller/one_off_controller.dart';
import 'package:markit_jetty/controller/overall_achievement.dart';
import 'package:markit_jetty/controller/qa_fail_controller.dart';
import 'package:markit_jetty/controller/filed_achievement_controller.dart';
import 'package:markit_jetty/controller/project_controller.dart';
import 'package:markit_jetty/controller/qa_achievement_controller.dart';
import 'package:markit_jetty/controller/qa_pass_controller.dart';
import 'package:markit_jetty/controller/qa_status_controller.dart';
import 'package:markit_jetty/controller/qa_status_user_filed_date_controller.dart';
import 'package:markit_jetty/controller/region_level_wave_controller.dart';
import 'package:markit_jetty/controller/region_progress_controller.dart';
import 'package:markit_jetty/controller/sync_wise_controller.dart';
import 'package:markit_jetty/controller/tracking_controller.dart';
import 'package:markit_jetty/controller/wave_project_controller.dart';
import 'package:markit_jetty/data/api/api_client_login.dart';
import 'package:markit_jetty/data/repository/achievement_repo.dart';
import 'package:markit_jetty/data/repository/app_project_dd.dart';
import 'package:markit_jetty/data/repository/batch_repo.dart';
import 'package:markit_jetty/data/repository/diagnostic_jetty.dart';
import 'package:markit_jetty/data/repository/field_achievement_repo.dart';
import 'package:markit_jetty/data/repository/first_day_repo.dart';
import 'package:markit_jetty/data/repository/lat_long_repo.dart';
import 'package:markit_jetty/data/repository/one_off_repo.dart';
import 'package:markit_jetty/data/repository/one_off_wave.dart';
import 'package:markit_jetty/data/repository/project_repo.dart';
import 'package:markit_jetty/data/repository/qa_achievement.dart';
import 'package:markit_jetty/data/repository/qa_pass_repo.dart';
import 'package:markit_jetty/data/repository/qa_status.dart';
import 'package:markit_jetty/data/repository/qa_status_user_filed_date_repo.dart';
import 'package:markit_jetty/data/repository/region_level_wave_repo.dart';
import 'package:markit_jetty/data/repository/region_progress_repo.dart';
import 'package:markit_jetty/data/repository/syvc_wise_repo.dart';
import 'package:markit_jetty/data/repository/tracking_repo.dart';
import 'package:markit_jetty/data/repository/wave_project_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controller/auth_controller.dart';
import '../controller/qa_fail_controller.dart';
import '../controller/qa_status_user_id_controller.dart';
import '../controller/wave_controller_one_off.dart';
import '../data/api/api_client.dart';
import '../data/repository/auth_repo.dart';
import '../data/repository/heirarchy_repo.dart';
import '../data/repository/overall_repo.dart';
import '../data/repository/qa_fail_repo.dart';
import '../data/repository/qa_status_user_id.dart';
import '../utils/app_constants.dart';

Future<void> init() async {

  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);
  //api client
  Get.lazyPut(() => ApiClient(appBaseURL: AppConstants.PORTAL_BASE_URL));
  Get.lazyPut(() => ApiClientLogin(appBaseURL: AppConstants.PORTAL_BASE_URL_LOGIN));
  //Get.lazyPut(() => ApiClient(http: AppConstants.NEW_PROTOCOL_HTTP, ip: AppConstants.NEW_PROTOCOL_IP, port: AppConstants.NEW_PROTOCOL_PORT, version: AppConstants.NEW_PROTOCOL_VERSION));

  //repos
  Get.lazyPut(() => AuthRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => ProjectRepo(apiClient: Get.find()),fenix: true);
  Get.lazyPut(() => FieldAchievement(apiClient: Get.find()));
  Get.lazyPut(() => AQAchievement(apiClient: Get.find()));
  Get.lazyPut(() => StatusQARepo(apiClient: Get.find()));
  Get.lazyPut(() => QAPassRepo(apiClient: Get.find()));
  Get.lazyPut(() => QAFailRepo(apiClient: Get.find()));
  Get.lazyPut(() => OverallRepo(apiClient: Get.find()));
  Get.lazyPut(() => WaveProjectRepo(apiClient: Get.find()));
  Get.lazyPut(() => RegionProgressRepo(apiClient: Get.find()));
  Get.lazyPut(() => FirstDayRepo(apiClient: Get.find()));
  Get.lazyPut(() => LatLongRepo(apiClient: Get.find()));
  Get.lazyPut(() => OneOffSettingRepo(apiClient: Get.find()));
  Get.lazyPut(() => TrackingRepo(apiClient: Get.find()));
  Get.lazyPut(() => TotalAchievement(apiClient: Get.find()));
  Get.lazyPut(() => DDAppProjectRepo(apiClient: Get.find()));
  Get.lazyPut(() => DiagnosticRepo(apiClient: Get.find()));
  Get.lazyPut(() => OneOffWave(apiClient: Get.find()));
  Get.lazyPut(() => RegionLevelWaveRepo(apiClient: Get.find()));
  Get.lazyPut(() => HierarchyRepoUser(apiClient: Get.find()));
  Get.lazyPut(() => QAStatusUserFieldDateRepo(apiClient: Get.find()));
  Get.lazyPut(() => QAStatusUserIdRepo(apiClient: Get.find()));
  Get.lazyPut(() => SyncWiseRepo(apiClient: Get.find()));
  Get.lazyPut(() => BatchRepo(apiClient: Get.find()));


  //controller
  Get.lazyPut(() => AuthController(authRepo: Get.find()));
  Get.lazyPut(() => ProjectController(projectRepo: Get.find()),fenix: true);
  Get.lazyPut(() => FieldAchievementController(fieldAchievementrepo: Get.find()));
  Get.lazyPut(() => QAAchievementController(qAchievement: Get.find()));
  Get.lazyPut(() => StatusQAController(statusQARepo: Get.find()));
  Get.lazyPut(() => QAPassController(qaPassRepo: Get.find()));
  Get.lazyPut(() => QAFailController(qaFailRepo: Get.find()));
  Get.lazyPut(() => OverAllAchievementController(overallRepo: Get.find()));
  Get.lazyPut(() => WaveProjectController(waveProjectRepo: Get.find()));
  Get.lazyPut(() => RegionProgressController(regionProgressRepo: Get.find()));
  Get.lazyPut(() => FirstDayController(firstDayRepo: Get.find()));
  Get.lazyPut(() => LatLongController(latLongRepo: Get.find()));
  Get.lazyPut(() => OneOffSetting(oneOffSettingRepo: Get.find()));
  Get.lazyPut(() => TrackingController(trackingRepo: Get.find()));
  Get.lazyPut(() => AchievementController(totalAchievement: Get.find()));
  Get.lazyPut(() => DDAppProjectController(ddRepo: Get.find()));
  Get.lazyPut(() => DiagnosticJettyController(diagnosticRepo: Get.find()));
  Get.lazyPut(() => WaveProjectControllerOneOff(oneOffWave: Get.find()));
  Get.lazyPut(() => RegionLevelWaveController(regionLevelWaveRepo: Get.find()));
  Get.lazyPut(() => HierarchyControllerUser(hierarchyRepoUser: Get.find()));
  Get.lazyPut(() => QAStatusUserFieldDateController(qaStatusUserFieldDateRepo: Get.find()));
  Get.lazyPut(() => QAStatusUserIdController(qaStatusUserIdRepo: Get.find()));
  Get.lazyPut(() => SyncWiseController(syncWiseRepo: Get.find()));
  Get.lazyPut(() => BatchController(batchRepo: Get.find()));
}
