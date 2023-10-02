
import 'package:get/get.dart';

import '../../utils/app_constants.dart';
import '../api/api_client.dart';

class BatchRepo extends GetxService{

  ApiClient apiClient;

  BatchRepo({required this.apiClient});


  Future<Response> batchData(String id) async {
    return await apiClient.getBatchData('${AppConstants.GET_BATCH_PASSING}''/$id');
  }
}