import 'package:get/get.dart';
import 'package:markit_jetty/data/repository/region_level_wave_repo.dart';
import 'package:markit_jetty/models/region_level_wave_model.dart';

class RegionLevelWaveController extends GetxController implements GetxService {
  final RegionLevelWaveRepo regionLevelWaveRepo;

  RegionLevelWaveController({required this.regionLevelWaveRepo});

  List<RegionLevelWaveManagementModel> _waveList = [];

  List<RegionLevelWaveManagementModel> get waveList => _waveList;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<void> getRegionLevelWave(String id, String quotaStatus,
      String projectClassificationTypeId) async {
    //Future<void> getProjectList() async {
    Response response = await regionLevelWaveRepo.getRegionLevelWave(id);
    late RegionLevelWaveManagementModel regionLevel;
    //Response response = await projectRepo.getProject();
    update();
    if (response.statusCode == 200) {
      print('got Region Level Wave');
      print(response.body);

      _waveList = [];


      if(response.body != null  && response.bodyString != "{}" && response.body != 0 && response.body["regionRefData"] != null) {
        regionLevel = RegionLevelWaveManagementModel(
            id: response.body["id"],
            unMerge: response.body["unMerge"],
            merge: response.body["merge"],
            regionRefData: List.from(response.body["regionRefData"])
                .map((e) => RegionRefData.fromJson(e))
                .toList(),
            createdAt: response.body["createdAt"],
            updatedAt: response.body["updatedAt"],
            projectId: response.body["projectId"],
            regionsGroupingId: response.body["regionsGroupingId"]);
        /*_waveList = List.from(response.body)
          .map((e) => RegionLevelWaveManagementModel.fromJson(e))
          .toList();
*/

        //_isLoaded = true;
        _waveList.add(regionLevel);
        print("inside level");
        print(regionLevel);
      }
      update();
    } else {
      print('not got Region Level Wave');
    }

    update();
  }


}
