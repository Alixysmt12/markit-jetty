import 'package:markit_jetty/data/api/api_client_login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/app_constants.dart';
import '../api/api_client.dart';
import 'package:get/get.dart';

class AuthRepo {
  final ApiClientLogin apiClient;
  final SharedPreferences sharedPreferences;

  AuthRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response> login(String userName, String password) async {
    return await apiClient.postDataLogin(AppConstants.GET_LOGIN,
        {"userName": userName, "password": password});
  }



}
