import 'package:get/get.dart';

import '../../utils/app_constants.dart';
import '../api/api_client.dart';

class OneOffSettingRepo extends GetxService{

  ApiClient apiClient;

  OneOffSettingRepo({required this.apiClient});


  Future<Response> oneOffSetting(String id) async {
    return await apiClient.getOneOff('${AppConstants.ONE_OFF_SETTING}''/$id');
  }
}