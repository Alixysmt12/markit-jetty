import 'dart:convert';

import 'package:get/get.dart';
import 'package:markit_jetty/data/repository/region_progress_repo.dart';
import 'package:markit_jetty/models/region_progress_model.dart';

class RegionProgressController extends GetxController implements GetxService {
  final RegionProgressRepo regionProgressRepo;

  RegionProgressController({required this.regionProgressRepo});

  List<RegionProgressModel> _regionProgress = [];

  List<RegionProgressModel> get regionProgress => _regionProgress;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<void> mRegionProgress(
      String id, String visitMonth, String quotaStatus) async {
    print("Get token");
    _isLoading = true;
    update();

    Response response =
        await regionProgressRepo.regionProgress(id, visitMonth, quotaStatus);
    late RegionProgressModel progress;
    if (response.statusCode == 200) {
      print("region progress");
      print(response.body);

      _regionProgress = [];

      /*     _regionProgress = List.from(response.body)
          .map((e) => RegionProgressModel.fromJson(e))
          .toList();*/
      //progress = RegionProgressModel(responsePass: response.body["responsePass"], responseFail: response.body["responseFail"]);
      //regionProgress.add(progress);

/*      Map<String, dynamic> data = Map<String, dynamic>.from(response.body);
      List<dynamic> passList = data["responsePass"];
      List<dynamic> failList = data["responseFail"];*/

      if (response.body != null &&
          response.body != 0 &&
          response.bodyString != "{}") {
        progress = RegionProgressModel(
            response: List.from(response.body["response"])
                .map((e) => ResponseModel.fromJson(e))
                .toList(),
            responsePass: List.from(response.body["responsePass"])
                .map((e) => ResponseModel.fromJson(e))
                .toList(),
            responseFail: List.from(response.body["responseFail"])
                .map((e) => ResponseModel.fromJson(e))
                .toList());

        //progress = RegionProgressModel(responsePass: List.from(response.body["responsePass"]), responseFail: List.from(response.body["responseFail"]));
        regionProgress.add(progress);
        progress.responseFail;
        progress.responsePass;
      }
    } else {
      print('not got region progress');
    }
    _isLoading = false;
    update();
  }
}
