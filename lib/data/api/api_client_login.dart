import 'package:get/get.dart';

class ApiClientLogin extends GetConnect implements GetxService {

  final String appBaseURL;
  late Map<String, String> _mainHeader;

  ApiClientLogin({required this.appBaseURL}) {
    baseUrl = appBaseURL;
    timeout = Duration(seconds: 30);
    _mainHeader = {
      'Content-type': 'application/json; charset=UTF-8',
      // 'Authorization': 'Bearer $token',
    };
  }

  Future<Response> postDataLogin(String uri, dynamic body) async {
    print("body " + body.toString());
    try {
      Response response = await post(uri, body, headers: _mainHeader);
      print("string " + response.toString());
      return response;
    } catch (e) {
      print(e.toString());
      return Response(statusCode: 1, statusText: e.toString());
    }
  }
}