import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:imsmart_admin/core/data/user_session.dart';
import 'package:imsmart_admin/core/di/injection_container.dart';
import 'package:imsmart_admin/core/network/url_config.dart';
import 'package:imsmart_admin/core/provider/get_provider.dart';
import 'package:imsmart_admin/core/utils/device_info.dart';
import 'package:imsmart_admin/pages/welcome_screens/splash_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //initialize singletons
  await init(
  environment:
  kReleaseMode ? Environment.production : Environment.production);
  //kReleaseMode ? Environment.staging : Environment.staging);

  // FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  // FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  getDeviceInfo();

  //await FirebaseCrashlytics.instance.recordError("test error", StackTrace.fromString("Failed"), reason: 'Contacts provider');
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then(
        (_) => runApp(const MyApp()),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  void _handleUserInteraction([_]) {
    initializeTimer();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);

    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // if (state == AppLifecycleState.resumed) {
    //   _timerLink = new Timer(
    //     const Duration(milliseconds: 1000),
    //     () {
    //       _dynamicLinkService.retrieveDynamicLink(context);
    //     },
    //   );
    // }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    // if (_timerLink != null) {
    //   _timerLink.cancel();
    // }
    super.dispose();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Listener(
      behavior: HitTestBehavior.translucent,
      onPointerDown: _handleUserInteraction,
      onPointerMove: _handleUserInteraction,
      onPointerUp: _handleUserInteraction,
      child: MultiProvider(
        providers: Providers.getProviders,
        child: ScreenUtilInit(
          designSize: Size(414, 896),
          builder: (context, widget) => GetMaterialApp(
            title: 'IMSmart',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: SplashScreen(),
            routes: {},
          ),
        ),
      ),
    );
  }
}
