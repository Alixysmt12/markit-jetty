import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:markit_jetty/auth/login_page.dart';
import 'package:markit_jetty/auth/my_login_page.dart';
import 'package:markit_jetty/controller/project_controller.dart';
import 'package:markit_jetty/home_page.dart';
import 'package:markit_jetty/routes/route_helper.dart';
import 'package:markit_jetty/ui/project.dart';
import 'package:markit_jetty/ui/splash.dart';
import 'helper/dependencies.dart' as dep;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //Get.find<ProjectController>().getProjectList("51","1");
    //Get.find<ProjectController>().getProjectList();

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: GoogleFonts.robotoTextTheme(Theme.of(context).textTheme),
        primarySwatch: Colors.blue,
      ),
      initialRoute: RouteHelper.getSplashPage(),
      getPages: RouteHelper.routes,
    );
  }
}
