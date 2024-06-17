// import 'package:firebase_crashlytics/firebase_crashlytics.dart';
// import 'package:imsmart_admin/core/data/session_manager.dart';
// import 'package:imsmart_admin/models/user_model.dart';
//
// /// General error reporter used for logging errors to [FirebaseCrashlytics]
// FirebaseCrashlytics _crashlytics = FirebaseCrashlytics.instance;
//
// class CrashlyticsService {
//   FirebaseCrashlytics get crashlytics => _crashlytics;
//
//   void reportError(error, stackTrace) {
//     try {
//       UserModel user = UserModel.fromJson(SessionManager.instance.usersData);
//       crashlytics.setUserIdentifier('${user.id}');
//       crashlytics.setCustomKey("Name", user.name);
//       crashlytics.setCustomKey("Email", '${user.email}');
//       crashlytics.setCustomKey("Mobile", '${user.phonenumber}');
//       crashlytics.recordError(error, stackTrace);
//     } catch (error) {}
//   }
// }
