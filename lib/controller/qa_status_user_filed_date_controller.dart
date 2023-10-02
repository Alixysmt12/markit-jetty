import 'package:get/get.dart';

import '../data/repository/qa_status_user_filed_date_repo.dart';
import '../models/qa_status_user_field_date_model.dart';

class QAStatusUserFieldDateController extends GetxController
    implements GetxService {
  final QAStatusUserFieldDateRepo qaStatusUserFieldDateRepo;

  QAStatusUserFieldDateController({required this.qaStatusUserFieldDateRepo});

  List<StatusUserFieldDateModel> _fieldDateModelList = [];

  List<StatusUserFieldDateModel> get fieldDateModelList => _fieldDateModelList;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<void> fieldDateQaData(int regionId, int levelId, int userId,
      String projectId, String visitMonth) async {
    print("Get token");
    _isLoading = true;
    update();

    Response response =
        await qaStatusUserFieldDateRepo.fieldDateQa(regionId,levelId,userId,projectId,visitMonth);
    if (response.statusCode == 200) {
      print("field date qa api 200");
      print(response.body);

      /*_fieldAchievementList = [];
      _fieldAchievementList.addAll(List.from(response.body)
          .map((e) => FieldAchievementModel.fromJson(e)));
      _fieldAchievementList;*/
      _fieldDateModelList = [];

      //  _fieldAchievementList = fieldAchievementParseModelFromJson(response.body);

      //  _fieldAchievementList = jsonDecode(response.body);

      _fieldDateModelList = List.from(response.body)
          .map((e) => StatusUserFieldDateModel.fromJson(e))
          .toList();

      print(_fieldDateModelList);
    } else {
      print('field date qa api 404 not found');
    }
    _isLoading = false;
    update();
  }
}
