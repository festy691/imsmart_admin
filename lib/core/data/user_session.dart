import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:imsmart_admin/core/data/session_manager.dart';
import 'package:imsmart_admin/core/event_bus/event_bus.dart';
import 'package:imsmart_admin/core/network/url_config.dart';

final Environment environment = Environment.staging;
var _keepAliveTIme = environment == Environment.production ? 300 : 300;
var _inactivityTimeout = Duration(minutes: _keepAliveTIme);
Timer? _keepAliveTimer;

void _saveTime() {
  SessionManager.instance.lastSession = DateTime.now().toString();
}

Future timeOutUserSession() async {
  try {
    DateTime dateTime = DateTime.parse(SessionManager.instance.lastSession);
    var diff = DateTime.now().difference(dateTime);
    if (diff.inMinutes > _keepAliveTIme) logOutUser();
  } catch (e) {}
}

void _keepAlive() {
  initializeTimer();
}

class _KeepAliveObserver extends WidgetsBindingObserver {
  @override
  didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        _saveTime();
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        _saveTime();
        _keepAlive(); // Conservatively set a timer on all three
        break;
    }
  }
}

/// Must be called only when app is visible, and exactly once
void startKeepAlive() async {
  await timeOutUserSession();
  _saveTime();
  WidgetsBinding.instance!.addObserver(_KeepAliveObserver());
}

void initializeTimer() {
  if (_keepAliveTimer != null) _keepAliveTimer?.cancel();
  _keepAliveTimer = Timer(_inactivityTimeout, logOutUser);
}

void updateTime() => _saveTime();

void logOutUser() async {
  eventBus.fire(LogoutEvent());
  _keepAliveTimer?.cancel();
  String? email = await SessionManager.instance.get("email");
  //PageRouter.gotoWidget(LoginScreen(), globalContext!, clearStack: true);
}
