import 'package:get/get.dart';
import 'package:markit_jetty/data/api/api_client.dart';

import '../../utils/app_constants.dart';

class FirstDayRepo extends GetxService{

  ApiClient apiClient;

  FirstDayRepo({required this.apiClient});

  Future<Response> firstDay(String id,String visitMonth,String projectClassificationType) async {
    return await apiClient.postFirstDay(AppConstants.POST_FIRST_DAY_URL,
        {
          "projectId": id,
          "visitMonth": visitMonth,
          "projectClassificationType": projectClassificationType
        } );
  }
}