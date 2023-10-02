import 'package:get/get.dart';

import '../../utils/app_constants.dart';
import '../api/api_client.dart';

class LatLongRepo extends GetxService{

  final ApiClient apiClient;

  LatLongRepo({required this.apiClient});

  Future<Response> mLatLong(String projectId,String visitMonth,String pass,String pending) async {
    return await apiClient.postQAFail(AppConstants.POST_LAT_LONG,
        {
          "projectId": projectId,
          "visitMonth": visitMonth,
          "recordStatus": [
            pass,
            pending
          ]
        });
  }
}