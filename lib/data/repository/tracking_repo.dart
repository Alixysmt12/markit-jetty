import 'package:get/get.dart';

import '../../utils/app_constants.dart';
import '../api/api_client.dart';

class TrackingRepo extends GetxService{

  ApiClient apiClient;

  TrackingRepo({required this.apiClient});


  Future<Response> trackingData(String id) async {
    return await apiClient.getTracking('${AppConstants.TRACKING_SETTING}''/$id');
  }
}