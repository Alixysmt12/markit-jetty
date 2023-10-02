import 'package:get/get.dart';

import '../data/repository/auth_repo.dart';
import '../models/response_model.dart';

class AuthController extends GetxController implements GetxService {

  final AuthRepo authRepo;

  AuthController({required this.authRepo});

  bool _isLoading = false;

  bool get isLoading => _isLoading;



  Future<ResponseModel> login(String email,String password) async {
    print("Get token");
    //print(authRepo.getUserToken().toString());
    _isLoading = true;
    update();
    Response response = await authRepo.login(email,password);

    late ResponseModel responseModel;
    if(response.statusCode == 200){
      print("Backend token");
      //authRepo.saveUserToken(response.body["token"]);
      print(response.body);
      //responseModel = ResponseModel(true, response.body["token"]);
      response.body["token"];
      //responseModel = ResponseModel(response.body["token"],response.body["projects"],response.body["status"]);

      //responseModel = ResponseModel(token: response.body["token"], projects: response.body["projects"], status: response.body["status"]);
     // responseModel = ResponseModel(token: response.body["token"], projects: List.from(response.body["projects"]).map((e) => Projects.fromJson(e)).toList(), status: response.body["status"]);

      responseModel = ResponseModel(token: response.body["token"],status: response.body["status"]);
    }else{
      //responseModel = ResponseModel();
      //responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoading = false;
    update();
    return responseModel;

  }
}