import 'package:get/get.dart';

import '../../utils/app_constants.dart';
import '../api/api_client.dart';

class DDAppProjectRepo extends GetxService{

  ApiClient apiClient;

  DDAppProjectRepo({required this.apiClient});


  Future<Response> ddData() async {
    return await apiClient.getDiagnostic(AppConstants.GET_ALLPROJECT_PAGE_DD);
  }


}