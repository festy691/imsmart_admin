import 'package:imsmart_admin/core/network/network_service.dart';
import 'package:imsmart_admin/core/network/url_config.dart';
import 'package:imsmart_admin/models/api_response.dart';

class NotificationService {
  NetworkService _networkService;
  NotificationService({required NetworkService networkService})
      : _networkService = networkService;

  void updateNetworkService() =>
      _networkService = NetworkService(baseUrl: UrlConfig.coreBaseUrl);

  Future<APIResponse> getNotifications({required String userId}) async {
    try {
      final response = await _networkService.call(
          UrlConfig.AUTH_URL + UrlConfig.notifications + "?user=$userId", RequestMethod.get);
      return APIResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<APIResponse> readNotification({required String notificationId}) async {
    try {
      final response = await _networkService.call(
          UrlConfig.AUTH_URL + UrlConfig.notifications + "/$notificationId", RequestMethod.put,
          data: {});
      return APIResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
