import 'package:get/get.dart';

import '../../utils/app_constants.dart';
import '../api/api_client.dart';

class DiagnosticRepo extends GetxService{


  ApiClient apiClient;

  DiagnosticRepo({required this.apiClient});


  Future<Response> diagnosticRepo(String startDate,String endDate,String pageNumber,String actionName) async {
    return await apiClient.getTracking('${AppConstants.GET_DIAGNOSTIC_FOR_JETTY}''/$startDate''/$endDate''/$pageNumber''/$actionName');
  }

}