import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:imsmart_admin/core/data/session_manager.dart';
import 'package:imsmart_admin/core/services/auth_service.dart';
import 'package:imsmart_admin/core/utils/blink_dialog.dart';
import 'package:imsmart_admin/core/utils/page_router.dart';
import 'package:imsmart_admin/core/widget/dialogs.dart';
import 'package:imsmart_admin/models/api_response.dart';
import 'package:imsmart_admin/models/user_model.dart';

class AuthProvider with ChangeNotifier {
  AuthService _authService;
  AuthProvider(AuthService authService) : _authService = authService;

  final _loadingKey = GlobalKey<State>();
  UserModel? currentUser;

  initializeData() {
    currentUser = UserModel();
  }

  bool _isAthenticating = false;
  bool _isUploading = false;
  UserModel _user = UserModel();
  bool _hasDoneKYC = false;

  bool get authState {
    return _isAthenticating;
  }

  bool get uploadState {
    return _isUploading;
  }

  bool get kyc {
    return _hasDoneKYC;
  }

  UserModel get getMe {
    return _user;
  }

  void setUser(UserModel user) {
    _user = user;
    notifyListeners();
  }

  Future<APIResponse> loginUser(
      {required BuildContext context,
        required String email,
        required String password,
        bool saveDetails = false}) async {
    try {
      LoadingDialog.showLoading(context, _loadingKey);

      APIResponse result =
      await _authService.loginUser(email: email, password: password);
      if (!result.error) {
        SessionManager.instance.isLoggedIn = true;
        SessionManager.instance.authToken = result.data['token'];

        SessionManager.instance.save("email", email);
        SessionManager.instance.save(email, password);

        await getUser(context: context);
      }

      LoadingDialog.hideLoading(_loadingKey);
      if (result.error)
        AppDialog.showErrorDialog(
          context,
          message: result.message.toString(),
          onContinue: () {
            PageRouter.goBack(context);
          },
        );

      return result;
    } catch (e, s) {
      LoadingDialog.hideLoading(_loadingKey);
      AppDialog.showErrorDialog(context, message: e.toString(), onContinue: () {
        PageRouter.goBack(context);
      });
      await FirebaseCrashlytics.instance
          .recordError(e, s, reason: 'User provider');
      return APIResponse(error: true, message: e.toString());
    }
  }

  Future<APIResponse> verifyTwoFa(
      {required BuildContext context, required String token}) async {
    try {
      LoadingDialog.showLoading(context, _loadingKey);

      APIResponse result = await _authService.verifyTwoFa(code: token);

      LoadingDialog.hideLoading(_loadingKey);
      if (result.error)
        AppDialog.showErrorDialog(context, message: result.message.toString(),
            onContinue: () {
              PageRouter.goBack(context);
            });

      return result;
    } catch (e, s) {
      LoadingDialog.hideLoading(_loadingKey);
      AppDialog.showErrorDialog(context, message: e.toString(), onContinue: () {
        PageRouter.goBack(context);
      });
      await FirebaseCrashlytics.instance
          .recordError(e, s, reason: 'User provider');
      return APIResponse(error: true, message: e.toString());
    }
  }

  Future<APIResponse> getUser(
      {required BuildContext context, bool load = false}) async {
    try {
      if (load) {
        LoadingDialog.showLoading(context, _loadingKey);
      }
      APIResponse result = await _authService.getUser();
      if (!result.error) {
        UserModel _user = UserModel.fromJson(result.data);
        setUser(_user);
        SessionManager.instance.usersData = result.data;
        SessionManager.instance.isUserSave = true;
      }
      if (load) {
        LoadingDialog.hideLoading(_loadingKey);
      }
      return result;
    } catch (e, s) {
      if (load) {
        LoadingDialog.hideLoading(_loadingKey);
      }
      await FirebaseCrashlytics.instance
          .recordError(e, s, reason: 'User provider');
      return APIResponse(error: true, message: e.toString());
    }
  }
}
