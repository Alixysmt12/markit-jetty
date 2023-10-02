import 'dart:convert';

import 'package:get/get.dart';
import 'package:markit_jetty/data/repository/qa_status.dart';

import '../models/response_model.dart';
import '../models/status_qa_model.dart';

class StatusQAController extends GetxController implements GetxService {
  final StatusQARepo statusQARepo;

  StatusQAController({required this.statusQARepo});

  List<QaStatusParseModel> _qaStatusAchievementList = [];

  List<QaStatusParseModel> get qaStatusAchievement => _qaStatusAchievementList;


  var myQaData = <QaStatusParseModel>[].obs;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<void> mQaStatus(String projectId,String visitMonth,String pass,String pending) async {
    print("Get status");
    _isLoading = true;
    update();

    Response response = await statusQARepo.statusQAAchievement(projectId,visitMonth,pass,pending);
    late QaStatusParseModel qaStatusParseModel;
    if (response.statusCode == 200) {
      qaStatusAchievement.clear();
      _qaStatusAchievementList.clear();
      update();
      print("Backend qa pass");
      print(response.body);

      _qaStatusAchievementList = [];

      //  _qaStatusAchievementList = List.from(response.body).map((e) => QaStatusParseModel.fromJson(e)).toList();

      qaStatusParseModel = new QaStatusParseModel(
          //lastDayQa: response.body["LastDayQA"],
          fail: response.body["Fail"],
          pass: response.body["Pass"],
          total: response.body["Total"]);

      qaStatusParseModel;

      //List<Map<String, dynamic>> tasks = await DBHelper.getSpecificTemplate(taskName);
     // myQaData.assignAll(qaStatusParseModel);


      myQaData.add(qaStatusParseModel);

      _qaStatusAchievementList.add(qaStatusParseModel);


      update();
      ////////always remember when data come from this
      // {
      // key = value
      // key = value
      // ...
      // }
      //so we need custom work;


      //_qaStatusAchievementList.addAll(qaStatusParseModel);
      //Map<String, dynamic> data = Map<String, dynamic>.from(json.decode(response.body));

      //_qaStatusAchievementList =data;
      // _qaStatusAchievementList = new Map<String, dynamic>.from(response.body);
      // _qaStatusAchievementList = List.from(response.body).map((e) => QaStatusParseModel.fromJson(e));
      //Map<String,dynamic> map = json.decode(response.body);
      //_qaStatusAchievementList = response.body;

/*      Map<String, dynamic> map = jsonDecode(response.body);
      _qaStatusAchievementList = (map as List<QaStatusParseModel>)
          .map((e) => QaStatusParseModel.fromJson(e))
          .toList();*/
    } else {
      print('not got qa');
    }
    _isLoading = false;
    update();
    //return qaStatusParseModel;
  }
}
/*

class StatusQAController extends GetxController implements GetxService {

  final StatusQARepo statusQARepo;

  StatusQAController({required this.statusQARepo});



  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<QaStatusParseModel> mQaStatus(String projectId,String visitMonth,String pass,String pending) async {

    print("Get status");
    _isLoading = true;
    update();
    Response response = await statusQARepo.statusQAAchievement(projectId,visitMonth,pass,pending);

    late QaStatusParseModel qaStatusParseModel;

    if (response.statusCode == 200) {
      print("Backend qa pass");
      print(response.body);


      qaStatusParseModel =  QaStatusParseModel(
          lastDayQa: response.body["LastDayQA"],
          fail: response.body["Fail"],
          pass: response.body["Pass"],
          total: response.body["Total"]);

    }else{

      print("error in qa status");
    }

    _isLoading = false;
    update();
    return qaStatusParseModel;

  }



}
*/
