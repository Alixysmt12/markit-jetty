
import 'package:get/get.dart';

import '../data/repository/syvc_wise_repo.dart';
import '../models/sync_wise_model.dart';

class SyncWiseController extends GetxController implements GetxService {
  final SyncWiseRepo syncWiseRepo;

  SyncWiseController({required this.syncWiseRepo});

  List<SyncWiseModel> _syncWiseList = [];

  List<SyncWiseModel> get syncWiseList => _syncWiseList;

  bool _isLoading = false;

  bool get isLoading => _isLoading;
  Future<void> syncWise(String projectId,String visitMonth,List<String> status) async {
    print("Get Sync Wise");
    _isLoading = true;
    update();

    Response response = await syncWiseRepo.syncWiseData(projectId,visitMonth,status);

    if (response.statusCode == 200) {
      print("Sync Wise inside");
      print(response.body);

      _syncWiseList = [];

      _syncWiseList = List.from(response.body)
          .map((e) => SyncWiseModel.fromJson(e))
          .toList();

      print("Sync Wise Size");
      print(_syncWiseList);

      update();
    } else {
      print('SyncWise Fail');
    }
    _isLoading = false;
    update();
  }
}