import 'package:imsmart_admin/core/my_providers/property_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:imsmart_admin/core/di/injection_container.dart';
import 'package:imsmart_admin/core/my_providers/auth_provider.dart';

class Providers {
  static List<SingleChildWidget> getProviders = [
    ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider(sl())),
    ChangeNotifierProvider<PropertyProvider>(create: (_) => PropertyProvider(sl())),
    // ChangeNotifierProvider<NotificationProvider>(
    //     create: (_) => NotificationProvider(sl())),
  ];
}
