
import 'package:get/get.dart';
import 'package:markit_jetty/data/repository/tracking_repo.dart';

import '../models/tracking_model.dart';

class TrackingController extends GetxController implements GetxService{


  final TrackingRepo trackingRepo;

  TrackingController({required this.trackingRepo});

  bool _isLoading = false;

  bool get isLoading => _isLoading;



  Future<List<TrackingModel>> tracking(String id) async {

    print("Tracking");
    _isLoading = true;
    update();
    Response response = await trackingRepo.trackingData(id);

    List<TrackingModel> responseModel = [];
    if(response.statusCode == 200){
      print("Backend Tracking");
      print(response.body);

      if(response.body != null && response.bodyString != "[]" && response.body != 0 ) {
        responseModel = List.from(response.body)
            .map((e) => TrackingModel.fromJson(e))
            .toList();
        update();
      }
    }else{
      print("No Tracking");
      //responseModel = ResponseModel();
      //responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoading = false;
    update();
    return responseModel;
  }

}