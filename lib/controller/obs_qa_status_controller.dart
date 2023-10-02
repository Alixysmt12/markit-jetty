import 'package:get/get.dart';
import 'package:markit_jetty/models/status_qa_model.dart';

import '../data/repository/qa_status.dart';

class OBSQAStatusController extends GetxController implements GetxService{

  final StatusQARepo statusQARepo;

  OBSQAStatusController({required this.statusQARepo});


  var qaData = <QaStatusParseModel>[].obs;

  Future<void> mQaStatus(String projectId,String visitMonth,String pass,String pending) async {
    print("Get status");
  //  _isLoading = true;
    update();

    Response response = await statusQARepo.statusQAAchievement(projectId,visitMonth,pass,pending);
    late QaStatusParseModel qaStatusParseModel;
    if (response.statusCode == 200) {
      print("Backend qa pass");
      print(response.body);

      //_qaStatusAchievementList = [];

      //  _qaStatusAchievementList = List.from(response.body).map((e) => QaStatusParseModel.fromJson(e)).toList();

      qaStatusParseModel = new QaStatusParseModel(
        //lastDayQa: response.body["LastDayQA"],
          fail: response.body["Fail"],
          pass: response.body["Pass"],
          total: response.body["Total"]);

      qaStatusParseModel;
      qaData.value.add(qaStatusParseModel);
   //   _qaStatusAchievementList.add(qaStatusParseModel);


    //  update();
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
    //_isLoading = false;
   // update();
    //return qaStatusParseModel;
  }


}