import 'package:get/get.dart';

import '../../utils/app_constants.dart';
import '../api/api_client.dart';

class RegionLevelWaveRepo extends GetxService{


  final ApiClient apiClient;

  RegionLevelWaveRepo({required this.apiClient});

  Future<Response> getRegionLevelWave(String id) async {
    return await apiClient.getRegionLevelManagementData('${AppConstants.GET_REGION_LEVEL_WAVE}''/$id');
  }
}