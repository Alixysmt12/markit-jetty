import 'package:get/get.dart';
import 'package:markit_jetty/data/api/api_client.dart';
import 'package:markit_jetty/data/repository/one_off_repo.dart';
import 'package:markit_jetty/models/one_off_setting.dart';

import '../utils/app_constants.dart';

class OneOffSetting extends GetxController implements GetxService{


  final OneOffSettingRepo oneOffSettingRepo;

  OneOffSetting({required this.oneOffSettingRepo});

  bool _isLoading = false;

  bool get isLoading => _isLoading;



  Future<List<ProjectClassificationOneOffSettings>> oneOff(String id) async {

    print("One OFF");
    _isLoading = true;
    update();
    Response response = await oneOffSettingRepo.oneOffSetting(id);

    List<ProjectClassificationOneOffSettings> responseModel = [];
    if(response.statusCode == 200){
      print("Backend One OFF");
      print(response.body);

      if(response.body != null && response.bodyString != "[]") {
        responseModel = List.from(response.body)
            .map((e) => ProjectClassificationOneOffSettings.fromJson(e))
            .toList();

        update();
      }
    }else{
      //responseModel = ResponseModel();
      //responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoading = false;
    update();
    return responseModel;
  }

}