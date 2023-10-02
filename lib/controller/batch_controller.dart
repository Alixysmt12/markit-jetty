
import 'package:get/get.dart';

import '../data/repository/batch_repo.dart';
import '../models/batch_passing_model.dart';

class BatchController extends GetxController implements GetxService{

  final BatchRepo batchRepo;

  BatchController({required this.batchRepo});

  List<BatchPassingModel> _batchPassingList = [];

  List<BatchPassingModel> get batchPassingList => _batchPassingList;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<void> getBatchData(String projectId) async {
    print("Get Batch Data");
    _isLoading = true;
    update();

    Response response = await batchRepo.batchData(projectId);

    if (response.statusCode == 200) {
      print("Batch Body");
      print(response.body);

      _batchPassingList = [];

      _batchPassingList = List.from(response.body)
          .map((e) => BatchPassingModel.fromJson(e))
          .toList();

      print("Batch list");
      print(_batchPassingList);

      update();
    } else {
      print('Batch Fail');
    }
    _isLoading = false;
    update();
  }
}