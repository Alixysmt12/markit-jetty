import 'package:get/get.dart';
import 'package:markit_jetty/data/repository/qa_pass_repo.dart';
import 'package:markit_jetty/models/qa_pase_model_pass.dart';

import '../models/qa_pass_model.dart';

class QAPassController extends GetxController implements GetxService{


  final QAPassRepo qaPassRepo;

  QAPassController({required this.qaPassRepo});

  List<QaPassModel> _qaPassList = [];

  List<QaPassModel> get qaPassList => _qaPassList;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<void> mQAPass(String id,String visitMonth,String quotaStatus) async {
    print("Get token");
    _isLoading = true;
    update();

    Response response = await qaPassRepo.mQAPass(id,visitMonth,quotaStatus);
    late QaPassParseModel fieldAchievementModel;
    if (response.statusCode == 200) {
      print("QA Pass");
      print(response.body);

      _qaPassList = [];

      if(response.body != null && response.bodyString != "[]" && response.body != 0) {
        _qaPassList = List.from(response.body)
            .map((e) => QaPassModel.fromJson(e))
            .toList();
      }
    } else {
      print('not QA Pass');
    }
    _isLoading = false;
    update();
  }
}