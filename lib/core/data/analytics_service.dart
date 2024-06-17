// import 'package:firebase_analytics/firebase_analytics.dart';
// import 'package:imsmart_admin/core/data/session_manager.dart';
// import 'package:imsmart_admin/models/user_model.dart';
//
// /// Google Firebase Analytics Service Provider
// FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
// FirebaseAnalyticsObserver observer =
//     FirebaseAnalyticsObserver(analytics: _analytics);
//
// class AnalyticsService {
//   ///get instance of FirebaseAnalytics [analytics]
//   FirebaseAnalytics get analytics => _analytics;
//
//   AnalyticsService() {
//     try {
//       UserModel user = UserModel.fromJson(SessionManager.instance.usersData);
//       _analytics.setUserId(id: user.id);
//       _analytics.setUserProperty(name: "Name", value: user.name);
//       _analytics.setUserProperty(name: "Email", value: user.email);
//       _analytics.setUserProperty(name: "Mobile", value: user.phonenumber);
//     } catch (err) {}
//   }
//
//   ///Log analytics event with name of the event [name] and event data [parameters]
//   void logEvent(
//       {required String name, required Map<String, dynamic> parameters}) {
//     try {
//       UserModel user = UserModel.fromJson(SessionManager.instance.usersData);
//       parameters.addAll({"email": user.email, "Name": user.name});
//       _analytics.logEvent(name: name, parameters: parameters);
//     } catch (err) {
//       print(err);
//     }
//   }
// }
