import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:markit_jetty/controller/project_controller.dart';
import 'package:markit_jetty/home_page.dart';
import 'package:markit_jetty/routes/route_helper.dart';
import 'package:markit_jetty/ui/project.dart';
import 'package:markit_jetty/ui/project_detailed.dart';
import 'package:markit_jetty/utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../navui/page1.dart';
import '../navui/page2.dart';
import 'navigation_drawer.dart';

class NavigationHomePage extends StatefulWidget {
  const NavigationHomePage({Key? key}) : super(key: key);

  @override
  State<NavigationHomePage> createState() => _NavigationHomePageState();
}

class _NavigationHomePageState extends State<NavigationHomePage> {
  var one = Get.arguments;

  dynamic data = Get.arguments;
  var currentPage = DrawerSections.dashboard;

  late SharedPreferences prefs;
  String name = "";
  String userName = "";

  Future<void> _loadResources() async {
    prefs = await SharedPreferences.getInstance();

    setState(() {
      name = prefs.getString("name") ?? "";
      userName = prefs.getString("userName") ?? "";
    });

  }
  @override
  void initState() {
    super.initState();
    _loadResources();

  }


  @override
  Widget build(BuildContext context) {
    var container;

    print(jsonEncode(data));
    if (currentPage == DrawerSections.dashboard) {
      try {
        ///find the controller and
        ///crush here if it's not initialized
        final authController = Get.find<ProjectController>();

        if (authController.initialized)
          Get.toNamed('/auth');
        else {
          Get.lazyPut(() => ProjectController(projectRepo: Get.find()));
          //Get.toNamed('/auth');
        }
      } catch (e) {
        Get.lazyPut(() => ProjectController(projectRepo: Get.find()));
        //Get.toNamed('/auth');
      }
      container = ProjectPage();
    } else if (currentPage == DrawerSections.logout) {
      container = ProjectPage();
      try {
        ///find the controller and
        ///crush here if it's not initialized
        final authController = Get.find<ProjectController>();

        if (authController.initialized)
          Get.toNamed('/auth');
        else {
          Get.lazyPut(() => ProjectController(projectRepo: Get.find()));
          //Get.toNamed('/auth');
        }
      } catch (e) {
        Get.lazyPut(() => ProjectController(projectRepo: Get.find()));
        //Get.toNamed('/auth');
      }

      SchedulerBinding.instance.addPostFrameCallback((_) {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.rightSlide,
          title: 'Are you Sure Want To Logout?',
          //desc: 'Dialog description here.............',
          btnCancelOnPress: () {},
          btnOkOnPress: () {
            logoutUser();
            //  Get.deleteAll();
          },
        ).show();
      });

      //container =
    }
/*    else if (currentPage == DrawerSections.contacts) {
      container = HomePage();
    } else if (currentPage == DrawerSections.events) {
      container = ProjectDetailed();
    }*/
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: Text("My Projects"),
        //title: Text(DrawerSections.values[currentPage].name),
      ),
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                MyHeaderDrawe(email: userName, name: name),
                MyDrawerList(),
              ],
            ),
          ),
        ),
      ),
      body: container,
    );
  }

  Widget menuItem(int id, String title, IconData icon, bool selected) {
    return Material(
      color: selected ? Colors.grey[300] : Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          setState(() {
            if (id == 1) {
              currentPage = DrawerSections.dashboard;
            } else if (id == 2) {
              currentPage = DrawerSections.logout;
            } else if (id == 3) {
              currentPage = DrawerSections.events;
            } else if (id == 4) {
              currentPage = DrawerSections.notes;
            } else if (id == 5) {
              currentPage = DrawerSections.settings;
            } else if (id == 6) {
              currentPage = DrawerSections.notifications;
            } else if (id == 7) {
              currentPage = DrawerSections.privacy_policy;
            } else if (id == 8) {
              currentPage = DrawerSections.send_feedback;
            }
          });
        },
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Row(
            children: [
              Expanded(
                child: Icon(
                  icon,
                  size: 20,
                  color: AppColors.mainColor,
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget MyDrawerList() {
    return Container(
      padding: EdgeInsets.only(
        top: 15,
      ),
      child: Column(
        // shows the list of menu drawer
        children: [
          menuItem(1, "My Projects", Icons.dashboard_outlined,
              currentPage == DrawerSections.dashboard ? true : false),
          menuItem(2, "Logout", Icons.logout,
              currentPage == DrawerSections.logout ? true : false),
          /*
          menuItem(3, "Events", Icons.event,
              currentPage == DrawerSections.events ? true : false),
          menuItem(4, "Notes", Icons.notes,
              currentPage == DrawerSections.notes ? true : false),
          Divider(),
          menuItem(5, "Settings", Icons.settings_outlined,
              currentPage == DrawerSections.settings ? true : false),
          menuItem(6, "Notifications", Icons.notifications_outlined,
              currentPage == DrawerSections.notifications ? true : false),
          Divider(),
          menuItem(7, "Privacy policy", Icons.privacy_tip_outlined,
              currentPage == DrawerSections.privacy_policy ? true : false),
          menuItem(8, "Send feedback", Icons.feedback_outlined,
              currentPage == DrawerSections.send_feedback ? true : false),*/
        ],
      ),
    );
  }

  Future<void> logoutUser() async {
    try {
      ///find the controller and
      ///crush here if it's not initialized
      final authController = Get.find<ProjectController>();

      if (authController.initialized)
        Get.toNamed('/auth');
      else {
        Get.lazyPut(() => ProjectController(projectRepo: Get.find()));
        //Get.toNamed('/auth');
      }
    } catch (e) {
      Get.lazyPut(() => ProjectController(projectRepo: Get.find()));
      //Get.toNamed('/auth');
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    Get.offNamed(RouteHelper.getlogin());
  }
}

enum DrawerSections {
  dashboard,
  logout,
  events,
  notes,
  settings,
  notifications,
  privacy_policy,
  send_feedback,
}
