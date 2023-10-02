import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:markit_jetty/controller/tracking_controller.dart';
import 'package:markit_jetty/data/repository/project_repo.dart';
import 'package:markit_jetty/models/my_project_model.dart';

import '../models/one_off_setting.dart';
import '../models/tracking_model.dart';
import '../utils/app_constants.dart';
import 'achievement_controller.dart';
import 'one_off_controller.dart';

class ProjectController extends GetxController {

  final ProjectRepo projectRepo;

  ProjectController({required this.projectRepo});

  List<dynamic> _projectList = [];

  List<dynamic> get projectList => _projectList;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<void> getProjectList(String userId, String companyId) async {

  //Future<void> getProjectList() async {
    Response response = await projectRepo.getProject(userId, companyId);
    //Response response = await projectRepo.getProject();
    update();
    if (response.statusCode == 200) {
      print('got products');

      _projectList = [];
      // _projectList.addAll(Project.fromJson(response.body));
      _projectList
          .addAll(List.from(response.body).map((e) => Project.fromJson(e)));
      //_projectList.addAll(List.from(response.body).map((e) => Project.fromJson(e)).toList());

      print(_projectList);

      for(int i = 0 ; i < _projectList.length ; i++){
        if (_projectList[i].studyType == "Simple Survey") {
          if (_projectList[i].projectClassificationTypeId ==
              AppConstants.ONE_OFF) {

            update();
            var oneOff = Get.find<OneOffSetting>();

            await getOneOffSetting(oneOff, _projectList[i]);
          } else if (_projectList[i].projectClassificationTypeId ==
              AppConstants.TRACKING) {
            var oneOff = Get.find<TrackingController>();
            update();
            await getTracking(oneOff, _projectList[i]);
          }
        }
      }



      _isLoading = true;
      update();
    } else {
      print('not got products');
    }
  }
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

      // project.projectName = value[0].name;

/*        graphDateStart = value[0].fieldStartDate;
        startDate = DateFormat('yyyy-MM-dd').format(graphDateStart);

        graphDateEnd = value[0].fieldEndDate;
        dateEnd = DateFormat('yyyy-MM-dd').format(graphDateEnd);

        project.startingDate = startDate;
        project.endingDate = dateEnd;*/

      print("My Date");
      print(project.startingDate);

      project.fieldStartDate = project.startingDate;
      project.fieldEndDate = project.endingDate;

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
      await getTotalAchievementOneOff(total,project,value);

 //     getTotalAchievement(total, project, value, i);


     /* total
          .totalAchievementData(project.id.toString(), value[0].name)
          .then((value) {
        if (value.isNotEmpty) {
          //     setState(() {

          print("Inside Total Achievement");
          print(value);
          project.totalAchivement = value;
          //   });
          *//*setState(() {});*//*
        }
      });*/

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

Future getTracking(TrackingController oneOff, Project project) async {
  return await oneOff.tracking(project.id.toString()).then((value) async {
    //return oneOff.tracking("7").then((value) {
    if (value.isNotEmpty) {
      // List<MYData> mydata=  value;
      print("Inside Tracking Api");

      project.waveCount = value.length;
      for (int i = 0; i < value.length; i++) {
        if (value[i].currentWave == true) {
          print(value[i].name);

          String startDate = "";
          String dateEnd = "";
          int totalSample = 0;
          DateTime graphDateStart;
          DateTime graphDateEnd;

          project.fieldStartDate = project.startingDate;
          project.fieldEndDate = project.endingDate;
          //project.projectName = value[0].name;
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


Future getTotalAchievementOneOff(AchievementController total, Project project,
    List<ProjectClassificationOneOffSettings> value) async {
  return await total
      .totalAchievementData(project.id.toString(), value[0].name)
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
    }else{
      print(totalValue.toString());
    }
  });
}
