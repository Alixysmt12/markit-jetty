import 'package:get/get.dart';

import '../allchart/region_wise_chart.dart';
import '../data/repository/qa_status_user_id.dart';
import '../models/status_user_id_model.dart';

class QAStatusUserIdController extends GetxController implements GetxService {
  final QAStatusUserIdRepo qaStatusUserIdRepo;

  QAStatusUserIdController({required this.qaStatusUserIdRepo});

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  List<StatusUserIdModel> _userIdList = [];

  Future<List<StatusUserIdModel>> fieldDateQaData(int regionId, int levelId, List<int> userId,
      String projectId, String visitMonth) async {
    print("Get qa status");
    _isLoading = true;
    update();

    Response response = await qaStatusUserIdRepo.fieldDateQaId(
        regionId, levelId, userId, projectId, visitMonth);

    late StatusUserIdModel statusUserIdModel;
    if (response.statusCode == 200) {
      _userIdList = [];
      print(response.body);


      if(response.body != null && response.bodyString != "[]" && response.body != 0) {
        _userIdList = List.from(response.body)
            .map((e) => StatusUserIdModel.fromJson(e))
            .toList();
      }
    }else {
      print('field ID qa api 404 not found');
    }

    _isLoading = false;
    update();
    return _userIdList;
  }
}
/*
class QAStatusUserIdController extends GetxController
    implements GetxService {
  final QAStatusUserIdRepo qaStatusUserIdRepo;

  QAStatusUserIdController({required this.qaStatusUserIdRepo});

  List<StatusUserIdModel> _userIdList = [];

  List<StatusUserIdModel> get userIdList => _userIdList;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<void> fieldDateQaData(int regionId, int levelId, int userId,
      String projectId, String visitMonth) async {
    print("Get token");
    _isLoading = true;
    update();

    Response response =
    await qaStatusUserIdRepo.fieldDateQaId(regionId,levelId,userId,projectId,visitMonth);
    if (response.statusCode == 200) {
      print("field ID qa api 200");
      print(response.body);

      _userIdList = [];

      _userIdList = List.from(response.body)
          .map((e) => StatusUserIdModel.fromJson(e))
          .toList();

      print(_userIdList);
    } else {
      print('field ID qa api 404 not found');
    }
    _isLoading = false;
    update();
  }
}
*/
