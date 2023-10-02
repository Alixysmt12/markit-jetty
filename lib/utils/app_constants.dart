class AppConstants {

  static const String APP_NAME = "DBFood";
  static const int APP_VERSION = 1;

  static const int ONE_OFF = 2;
  static const int TRACKING = 1;

  static const String NEW_PROTOCOL_HTTP = "http://";
  static const String NEW_PROTOCOL_IP = "54.179.225.22:";
  static const String NEW_PORT = "6150";
  static const String NEW_LOGIN_PORT = "6050";
  static const String NEW_PROTOCOL_VERSION = "api/v1/";

  static const String BASE_URL = "http://54.179.225.22:6050/api/v1/";
  static const String LOGIN_URL = "simpleSurveyAuth";
  static const String TOKEN = "DBToken";

  ///////////////////////portal URL
  static const String PORTAL_BASE_URL = "http://54.179.225.22:6150/api/v1/";
  static const String PORTAL_BASE_URL_LOGIN = "http://54.179.225.22:6050/api/v1/";
  static const String PORTAL_LOGIN_URL = "authentication/auth";

  //static const String GET_PROJECT_URL = "projects/getCompanyProjects/51/1";
  static const String GET_PROJECT_URL = "projects/getRecentCompanyProjects";

  ////////////////////////Login///////////////////////////
  static const String GET_LOGIN = "markitJettyAuth";
  static const String ONE_OFF_SETTING = "projectClassificationOneOffSettings/";
  static const String TRACKING_SETTING = "projectWaveSetting/getProjectWaveForDDByProjectId";
  static const String TOTAL_ACHIEVEMENT = "simpleSurveyData/totalAchievementByProjectIdAndVisitMonth";


  //////////////////////GRAPH
  static const String POST_FIELD_ACHIEVEMENT_URL = "simpleSurveyDashboard/getFieldAchievement/";
  static const String POST_QA_ACHIEVEMENT_URL = "simpleSurveyDashboard/getQAAchievement/";
  static const String POST_QA_STATUS_URL = "simpleSurveyDashboard/getQADetailsByProjectIdAndVisitMonth/";
  static const String POST_FIELD_ACHIEVEMENT_SYNC_WISE_URL = "simpleSurveyDashboard/getFieldAchievementSyncWise/";
  static const String POST_QA_PASS_URL = "simpleSurveyDashboard/getRegionHeirarchyQAPass/";
  static const String POST_QA_FAIL_URL = "simpleSurveyDashboard/getRegionHeirarchyQAFail/";
  static const String POST_OVERALL_URL = "simpleSurveyDashboard/getRegionHeirarchy/";
  static const String POST_REGION_PROGRESS_URL = "simpleSurveyDashboard/getQAStatusByRegionsJetty";
  static const String POST_FIRST_DAY_URL = "simpleSurveyDashboard/firstDayAchievement/";
  static const String POST_SYNC_WISE_URL = "simpleSurveyDashboard/getFieldAchievementSyncWise/";
  static const String GET_BATCH_PASSING ="projectSetting/getBatchPassingPercentageByProjectId";

  /////////////////////WAVE
  static const String GET_PROJECT_WAVE = "projectWaveSetting/getProjectWaveForDDByProjectId";
  static const String GET_PROJECT_CLASSIFICATION = "projectClassificationOneOffSettings";

  /////////////////////Google Map Field Lat Long
  static const String POST_LAT_LONG = "simpleSurveyData/mapDataByProjectIdAndVisitMonth";


  /////////////////////Region Progress Api Wave
  static const GET_REGION_LEVEL_WAVE = "regionLevelManagement/getRegionLevelManagementByProjectId";
  static const POST_REGION_HEIRARCHY_WAVE = "simpleSurveyDashboard/getUserByRegionHeirarchy";


  ////////////////////Diagnostic
  static const GET_ALLPROJECT_PAGE_DD = "diagnostic/getAllProjectPagesAndActionsForDD";
  static const GET_DIAGNOSTIC_FOR_JETTY = "diagnostic/getDiagnosticDetailByActivityAndActionForJetty";
  static const GET_STATUS_BY_USER_ID_AND_FIELD_DATE = "simpleSurveyDashboard/getQAStatusByUsersAndFieldDate";
  static const GET_STATUS_BY_USER_ID = "simpleSurveyDashboard/getQAStatusByUserId";

  ///////////////////////Shared Pref
  static const String USER_ID = "";
  static const String COMPANY_ID = "";
}