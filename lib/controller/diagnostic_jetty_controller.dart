import 'package:get/get.dart';
import 'package:markit_jetty/data/repository/diagnostic_jetty.dart';
import 'package:markit_jetty/models/diagnostic_model.dart';

class DiagnosticJettyController extends GetxController implements GetxService {
  final DiagnosticRepo diagnosticRepo;

  DiagnosticJettyController({required this.diagnosticRepo});

  List<DiagnosticModel> _diagnosticModel = [];

  List<DiagnosticModel> get diagnosticModel => _diagnosticModel;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<void> getDiagnostic(String startDate, String endDate,
      String pageNumber, String actionName) async {
    Response response = await diagnosticRepo.diagnosticRepo(
        startDate, endDate, pageNumber, actionName);
    update();
    if (response.statusCode == 200) {
      print('got dd');
      print(response.body);

      _diagnosticModel = [];
      _diagnosticModel =
          List.from(response.body).map((e) => DiagnosticModel.fromJson(e)).toList();

      print(_diagnosticModel);

      //_isLoaded = true;
      update();
    } else {
      print('not got dd');
    }

    update();
  }
}
