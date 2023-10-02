import 'package:get/get.dart';

import '../../utils/app_constants.dart';

class ApiClient extends GetConnect implements GetxService {
  late String token;
  final String appBaseURL;

  //final String http;
  //final String ip;
  //final String port;
  //final String version;
  //final String loginPort;

  late Map<String, String> _mainHeader;



  ApiClient({required this.appBaseURL}) {
    baseUrl = appBaseURL;
    timeout = Duration(seconds: 30);
    token = AppConstants.TOKEN;
    _mainHeader = {
      'Content-type': 'application/json; charset=UTF-8',
      // 'Authorization': 'Bearer $token',
    };
  }

/*  ApiClient({required this.http,required this.ip,required this.port,required this.version}) {
    baseUrl = http+ip+port+version;
    timeout = Duration(seconds: 30);
    token = AppConstants.TOKEN;
    _mainHeader = {
      'Content-type': 'application/json; charset=UTF-8',
      // 'Authorization': 'Bearer $token',
    };
  }*/

  final queryParameters = {
    'userId': '51',
    'companyId': '1',
  };

  Future<Response> getProjectData(String uri) async {
    try {
      Response response = await get(uri);
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> getWaveData(String uri) async {
    try {
      Response response = await get(uri);
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }
  Future<Response> getRegionLevelManagementData(String uri) async {
    try {
      Response response = await get(uri);
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }



  Future<Response> getWaveDataOneOff(String uri) async {
    try {
      Response response = await get(uri);
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> getOneOff(String uri) async {
    try {
      Response response = await get(uri);
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }


  Future<Response> getBatchData(String uri) async {
    try {
      Response response = await get(uri);
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> getTracking(String uri) async {
    try {
      Response response = await get(uri);
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> getAppProjectDD(String uri) async {
    try {
      Response response = await get(uri);
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> getDiagnostic(String uri) async {
    try {
      Response response = await get(uri);
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }



  Future<Response> postTotalAchievement(String uri, dynamic body) async {
    print("body " + body.toString());
    try {
      Response response = await post(uri, body, headers: _mainHeader);
      print("string Ali" + response.toString());
      return response;
    } catch (e) {
      print(e.toString());
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> postHeirarchyData(String uri, dynamic body) async {
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

  Future<Response> postStatusByUserFieldDate(String uri, dynamic body) async {
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


  Future<Response> postStatusByUserId(String uri, dynamic body) async {
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

  Future<Response> postSyncWise(String uri, dynamic body) async {
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


  Future<Response> postFieldAchievementLogin(String uri, dynamic body,) async {
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


  Future<Response> postQAAchievementLogin(String uri, dynamic body,) async {
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


  Future<Response> postStatusQAAchievementLogin(String uri, dynamic body,) async {
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

  Future<Response> postQAPass(String uri, dynamic body,) async {
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

  Future<Response> postQAFail(String uri, dynamic body,) async {
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

  Future<Response> postOverAll(String uri, dynamic body,) async {
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

  Future<Response> postRegion(String uri, dynamic body,) async {
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

  Future<Response> postFirstDay(String uri, dynamic body,) async {
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
