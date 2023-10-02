import 'package:get/get.dart';
import 'package:markit_jetty/data/repository/qa_fail_repo.dart';

import '../models/qa_fail_model.dart';
import '../models/qa_pase_model_pass.dart';

class QAFailController extends GetxController implements GetxService {
  final QAFailRepo qaFailRepo;

  QAFailController({required this.qaFailRepo});

  List<QaFailModel> _qaFailList = [];

  List<QaFailModel> get qaFailList => _qaFailList;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<void> mQAPass(String id,String visitMonth,String quotaStatus) async {
    print("Get token");
    _isLoading = true;
    update();

    Response response = await qaFailRepo.mQAFail(id,visitMonth,quotaStatus);

    if (response.statusCode == 200) {
      print("QA Fail");
      print(response.body);

      _qaFailList = [];

      if(response.body != null && response.bodyString != "[]" && response.body != 0) {
        _qaFailList = List.from(response.body)
            .map((e) => QaFailModel.fromJson(e))
            .toList();
      }
    } else {
      print('not QA Fail');
    }
    _isLoading = false;
    update();
  }
}
