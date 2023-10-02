import 'package:get/get.dart';

import '../../utils/app_constants.dart';
import '../api/api_client.dart';

class ProjectRepo extends GetxService{

  final ApiClient apiClient;

  ProjectRepo({required this.apiClient});

/*
  Future<Response> getProject() async {
    return await apiClient.getProjectData(AppConstants.GET_PROJECT_URL);
  }
*/

  Future<Response> getProject(String userId,String companyId) async {
    return await apiClient.getProjectData('${AppConstants.GET_PROJECT_URL}''/$userId''/$companyId');
  }
}