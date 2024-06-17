enum Environment { development, staging, qa, production }

class UrlConfig {
  static Environment environment = Environment.staging;
  //static const String STAGING_URL = "https://2a39-105-112-101-128.eu.ngrok.io/api/v1";
  static const String STAGING_URL =
      "https://imcard-vurk7.ondigitalocean.app/api/v2";
  static const String PRODUCTION_URL =
      "https://imcard-vurk7.ondigitalocean.app/api/v2";

  static final coreBaseUrl =
      environment == Environment.production ? PRODUCTION_URL : STAGING_URL;

  ///Authentication Service
  static const String STAGING_AUTH_URL =
      "https://imcard-vurk7.ondigitalocean.app/api/v2/";
  //static const String STAGING_AUTH_URL = "https://2a39-105-112-101-128.eu.ngrok.io/api/v1/";
  static const String PRODUCTION_AUTH_URL =
      "https://imcard-vurk7.ondigitalocean.app/api/v2/";
  static final String AUTH_URL = environment == Environment.production
      ? PRODUCTION_AUTH_URL
      : STAGING_AUTH_URL;

  static const String payStackPublicKey_Staging =
      'pk_test_977475ec3b04e02c2117e6b6a4be0350195cddd0';
  static const String payStackPublicKey_Prod =
      'pk_live_a33cd03546eb105a8cd57829a575b29cc958308b';
  static final String payStackPublicKey = environment == Environment.production
      ? payStackPublicKey_Prod
      : payStackPublicKey_Staging;

  //Auth Endpoints
  static const String user = 'authenticate';
  static const String login = 'users/login';
  static const String pin = 'users/pin';
  static const String activateUserOtp = 'users/activate';
  static const String requestEmailToken = 'users/requesttoken';
  static const String requestTwoFa = 'users/twofactor/request';
  static const String disableTwoFa = 'users/twofactor/disable';
  static const String verifyTwoFa = 'users/twofactor/verify';
  static const String submitId = 'users/verification/upload';
  static const String verifyTransactionPin = 'transactions/validate-pin';
  static const String signup = 'users';
  static const String forgotPassword = 'users/forgotpassword';
  static const String confirmResetPassword = 'users/resetpassword';
  static const String updatePassword = 'users/updatepassword';
  static const String updatePin = 'users/pin';
  static const String updateProfilePics = 'users/updatepics';
  static const String logout = 'users/logout';

  // Property Endpoints
  static const String properties = 'properties';
  static const String cities = 'properties/location/cities';
  static const String bookings = 'bookings';
  static const String initiatePayment = 'bookings/payment/initiate';
  static const String referral = 'properties/referral';

  // Notification Endpoints
  static const String notifications = 'notifications';

  // Transactions Endpoints
  static const String referralTransactions = 'transactions/referral/all';

  // Payment Method Endpoints
  static const String addAccount = 'accounts';
}
