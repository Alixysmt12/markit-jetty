import 'package:get/get.dart';
import 'package:markit_jetty/utils/app_constants.dart';

import '../api/api_client.dart';

class WaveProjectRepo extends GetxService{


  final ApiClient apiClient;

  WaveProjectRepo({required this.apiClient});

  Future<Response> getWave(String id) async {
    return await apiClient.getWaveData('${AppConstants.GET_PROJECT_WAVE}''/$id');
  }
}