import 'package:get/get.dart';

import '../../utils/app_constants.dart';
import '../api/api_client.dart';

class SyncWiseRepo extends GetxService{

  ApiClient apiClient;

  SyncWiseRepo({required this.apiClient});


  Future<Response> syncWiseData(String id,String visitMonth,List<String> status) async {
    return await apiClient.postSyncWise(AppConstants.POST_SYNC_WISE_URL,
        {
          "projectId": id,
          "visitMonth": visitMonth,
          "recordStatus": status
        });
  }
}