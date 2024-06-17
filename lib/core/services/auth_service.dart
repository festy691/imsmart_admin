import 'package:imsmart_admin/core/network/network_service.dart';
import 'package:imsmart_admin/core/network/url_config.dart';
import 'package:imsmart_admin/models/api_response.dart';

class AuthService {
  NetworkService _networkService;
  AuthService({required NetworkService networkService})
      : _networkService = networkService;

  void updateNetworkService() =>
      _networkService = NetworkService(baseUrl: UrlConfig.coreBaseUrl);

  Future<APIResponse> getUser() async {
    try {
      final response = await _networkService.call(
          UrlConfig.AUTH_URL + UrlConfig.user, RequestMethod.get);
      return APIResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<APIResponse> loginUser({required String email, required String password}) async {
    try {

      //String deviceId = await getDeviceID();

      Map<String, dynamic> map = Map();
      map['email'] = email;
      map['password'] = password;
      //map['firebaseToken'] = deviceId;
      final response = await _networkService.call(
          UrlConfig.AUTH_URL + UrlConfig.login, RequestMethod.post,
          data: map);
      return APIResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<APIResponse> verifyTwoFa({required String code}) async {
    try {
      Map<String, dynamic> map = Map();
      map['token'] = code;

      final response = await _networkService.call(
          UrlConfig.AUTH_URL + UrlConfig.verifyTwoFa, RequestMethod.post, data: map);
      return APIResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

}