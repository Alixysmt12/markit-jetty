import 'package:get/get.dart';

import '../data/repository/app_project_dd.dart';
import '../data/repository/diagnostic_jetty.dart';
import '../models/dd_model.dart';

class DDAppProjectController extends GetxController implements GetxService {

  final DDAppProjectRepo ddRepo;

  DDAppProjectController({required this.ddRepo});

  List<DdModel> _ddModel = [];

  List<DdModel> get ddModel => _ddModel;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<void> getDdData() async {
    Response response = await ddRepo.ddData();
    update();
    if (response.statusCode == 200) {
      print('got dd');
      print(response.body);

      _ddModel = [];
      _ddModel =
          List.from(response.body).map((e) => DdModel.fromJson(e)).toList();

      print(_ddModel);

      //_isLoaded = true;
      update();
    } else {
      print('not got dd');
    }

    update();
  }


}