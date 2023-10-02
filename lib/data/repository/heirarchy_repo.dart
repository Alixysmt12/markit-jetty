import 'package:get/get.dart';

import '../../utils/app_constants.dart';
import '../api/api_client.dart';

class HierarchyRepoUser extends GetxService{

  final ApiClient apiClient;

  HierarchyRepoUser({required this.apiClient});

  Future<Response> getHierarchy(int id,String name,int levelId,String projectId,String visitMonth) async {
    return await apiClient.postHeirarchyData(AppConstants.POST_REGION_HEIRARCHY_WAVE,
        {
          "data": {
            "id": [
              id
            ],
            "name": name,
            "levelId": levelId
          },
          "projectId": projectId,
          "visitMonth": visitMonth
        });
  }
}