import 'package:get/get.dart';

import '../../allchart/region_wise_chart.dart';
import '../../utils/app_constants.dart';
import '../api/api_client.dart';


class QAStatusUserIdRepo extends GetxService{

  ApiClient apiClient;

  QAStatusUserIdRepo({required this.apiClient});

  Future<Response> fieldDateQaId(int regionId,int levelId,List<int> userId,String projectId,String visitMonth) async {
    return await apiClient.postStatusByUserId(AppConstants.GET_STATUS_BY_USER_ID,
        {
          "regionId": [
            regionId,
          ],
          "levelId": levelId,
          "projectId": projectId,
          "visitMonth": visitMonth,
          "userId": userId

        }


      /*{
    "regionId": [
        128,
        129
    ],
    "levelId": 2,
    "projectId": "155",
    "visitMonth": "MerginSampleComp",
    "userId": [
        665
    ]
}*/


    );
  }
}