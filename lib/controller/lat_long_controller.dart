import 'package:get/get.dart';
import 'package:markit_jetty/data/repository/lat_long_repo.dart';
import 'package:markit_jetty/models/lat_long_field_map.dart';

class LatLongController extends GetxController implements GetxService{

  final LatLongRepo latLongRepo;

  LatLongController({required this.latLongRepo});

  List<GoogleLatLongField> _latLongList = [];

  List<GoogleLatLongField> get latLongList => _latLongList;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<void> mGetLatLong(String projectId,String visitMonth,String pass,String pending) async {
    print("Get Lat Long");
    _isLoading = true;
    update();

    Response response = await latLongRepo.mLatLong(projectId,visitMonth,pass,pending);

    if (response.statusCode == 200) {
      print("QA Fail");
      print(response.body);

      _latLongList = [];

      _latLongList = List.from(response.body)
          .map((e) => GoogleLatLongField.fromJson(e))
          .toList();

      print("Lat Long Size");
      print(_latLongList);

      update();
    } else {
      print('QA Fail');
    }
    _isLoading = false;
    update();
  }
}