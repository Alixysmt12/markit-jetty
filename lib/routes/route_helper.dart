import 'package:get/get.dart';
import 'package:markit_jetty/auth/my_login_page.dart';
import 'package:markit_jetty/home_page.dart';
import 'package:markit_jetty/ui/api_chart.dart';
import 'package:markit_jetty/ui/project.dart';
import 'package:markit_jetty/ui/project_detailed.dart';

import '../ui/for_pieChart.dart';
import '../ui/nav_home.dart';
import '../ui/splash.dart';

class RouteHelper {
  static const String splashPage = "/splash-page";
  static const String initial = "/";
  static const String login = "/login";
  static const String projectScreen = "/project-data";
  static const String botomBarScreen = "/bottombar-chart";
  static const String projectDetailedScreen = "/project-detailed-chart";
  static const String navPages = "/nave-pages";
  static const String pie = "/pie-pages";

  static String getSplashPage() => '$splashPage';
  static String getPie() => '$pie';

  static String getlogin() => '$login';

  static String getProjectScreen() => '$projectScreen';

  static String getBottomScreen() => '$botomBarScreen';

  static String getProjectDetailed(int pageIdIndex) =>
      '$projectDetailedScreen?pageIdIndex=$pageIdIndex';

  static String getNavePages() => '$navPages';

  static List<GetPage> routes = [
    GetPage(name: splashPage, page: () => SplashPage()),
    GetPage(name: pie, page: () => MyApiChart()),
    GetPage(name: login, page: () => MyLoginPage()),
    GetPage(name: projectScreen, page: () => ProjectPage()),
    GetPage(name: botomBarScreen, page: () => HomePage()),
    GetPage(
        name: projectDetailedScreen,
        page: () {
          var pageIdIndex = Get.parameters['pageIdIndex'];
          print("project called");

          return ProjectDetailed(pageIdIndex: int.parse(pageIdIndex!));
        }),
    GetPage(name: navPages, page: () => NavigationHomePage()),
  ];
}
