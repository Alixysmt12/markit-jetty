import 'package:get/get.dart';
import 'package:markit_jetty/controller/qa_status_user_id_controller.dart';

import '../data/repository/heirarchy_repo.dart';
import '../models/hierarchy_model.dart';

class HierarchyControllerUser extends GetxController implements GetxService {

  final HierarchyRepoUser hierarchyRepoUser;

  HierarchyControllerUser({required this.hierarchyRepoUser});

  List<HierarchyUser> _hierarchyslist = [];

  List<HierarchyUser> get hierarchyslist => _hierarchyslist;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<void> getHierarchyData(int id, String name, int levelId,
      String projectId, String visitMonth) async {
    print("Get Lat Long");
    _isLoading = true;
    update();

    Response response = await hierarchyRepoUser.getHierarchy(
        id, name, levelId, projectId, visitMonth);

    if (response.statusCode == 200) {
      print("hierarchys list");
      print(response.body);

      _hierarchyslist = [];

      if(response.body != null) {
        _hierarchyslist = List.from(response.body)
            .map((e) => HierarchyUser.fromJson(e))
            .toList();

 /*       if(_hierarchyslist.length > 0){
          if(_hierarchyslist[0].userId != null) {
            await Get.find<QAStatusUserIdController>().fieldDateQaData(
                id, levelId, _hierarchyslist, projectId, visitMonth);

          }
        }*/


      }
      print("hierarchys list Data");
      print(_hierarchyslist);

      update();
    } else {
      print('hierarchys list fail');
    }
    _isLoading = false;
    update();
  }
}