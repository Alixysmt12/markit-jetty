import 'package:get/get.dart';

import '../../utils/app_constants.dart';
import '../api/api_client.dart';

class OneOffWave extends GetxService{

  ApiClient apiClient;

  OneOffWave({required this.apiClient});


  Future<Response> oneOffWave(String id) async {
    return await apiClient.getWaveDataOneOff('${AppConstants.GET_PROJECT_CLASSIFICATION}''/$id');
  }
}