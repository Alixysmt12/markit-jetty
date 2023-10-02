import 'package:get/get.dart';

import '../../utils/app_constants.dart';
import '../api/api_client.dart';

class QAStatusUserFieldDateRepo extends GetxService{

  ApiClient apiClient;

  QAStatusUserFieldDateRepo({required this.apiClient});

  Future<Response> fieldDateQa(int regionId,int levelId,int userId,String projectId,String visitMonth) async {
    return await apiClient.postStatusByUserFieldDate(AppConstants.GET_STATUS_BY_USER_ID_AND_FIELD_DATE,
        {
          "regionId": regionId,
          "levelId": levelId,
          "userId": userId,
          "projectId": projectId,
          "visitMonth": visitMonth
        }


        /*{
        "regionId": 127,
        "levelId": 2,
        "userId": 665,
        "projectId": "155",
        "visitMonth": "MerginSampleComp"
        }*/


    );
  }
}