
import 'package:dio/dio.dart';

/// [Interceptor] extension for setting token header
/// and other required properties for all requests
class AppInterceptor extends Interceptor {
  String authToken;
  AppInterceptor(this.authToken);

  /// sets the auth token and Apptoken
  /// Apptoken is an identify for each app
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    if (authToken.isNotEmpty) {
      options.headers.addAll({
        "auth-token": authToken,
      });
    }
    return super.onRequest(options, handler);
  }

  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    if (response.statusCode! >= 200 &&
        response.statusCode! < 400) {
      response.statusCode = 200;
    } else if(response.statusCode == 401) {
      // eventBus.fire(LogoutEvent(""));
    }
    return super.onResponse(response, handler);
  }
}
