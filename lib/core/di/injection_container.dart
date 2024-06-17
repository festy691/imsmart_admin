import 'package:get_it/get_it.dart';
import 'package:imsmart_admin/core/data/session_manager.dart';
import 'package:imsmart_admin/core/my_providers/auth_provider.dart';
import 'package:imsmart_admin/core/my_providers/property_provider.dart';
import 'package:imsmart_admin/core/network/network_service.dart';
import 'package:imsmart_admin/core/network/url_config.dart';
import 'package:imsmart_admin/core/services/auth_service.dart';
import 'package:imsmart_admin/core/services/notification_service.dart';
import 'package:imsmart_admin/core/services/property_service.dart';

final sl = GetIt.instance;

Future<void> init({required Environment environment}) async {
  UrlConfig.environment = environment;
  await initCore();
  initProviders();
  await initServices();
  initBloc();
}

Future<void> initCore() async {
  final sessionManager = SessionManager();
  await sessionManager.init();
  sl.registerLazySingleton<SessionManager>(() => sessionManager);
}

void initProviders() {
  sl.registerFactory(() => AuthProvider(sl()));
  sl.registerFactory(() => PropertyProvider(sl()));
}

void initBloc() {
  /*sl.registerLazySingleton<SignUpBloc>(() => SignUpBloc(sl()));*/
}

Future<void> initServices() async {
  sl.registerFactory<NetworkService>(
      () => NetworkService(baseUrl: UrlConfig.coreBaseUrl));
  sl.registerLazySingleton<AuthService>(
      () => AuthService(networkService: sl()));
  sl.registerLazySingleton<PropertyService>(
      () => PropertyService(networkService: sl()));
  sl.registerLazySingleton<NotificationService>(
      () => NotificationService(networkService: sl()));
  // sl.registerLazySingleton<AnalyticsService>(() => AnalyticsService());
  // sl.registerLazySingleton<CrashlyticsService>(() => CrashlyticsService());
}
