import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
String deviceName = 'mobile';

void getDeviceInfo() async {
  if (Platform.isAndroid) {
    AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;
    deviceName =
        '${androidInfo.manufacturer} ${androidInfo.model} ${androidInfo.version.release}';
  } else {
    IosDeviceInfo iosDeviceInfo = await deviceInfoPlugin.iosInfo;
    deviceName =
        '${iosDeviceInfo.name}/${iosDeviceInfo.systemVersion}/${iosDeviceInfo.utsname.nodename}';
  }
  print(deviceName);
}
