import 'dart:io';

// import 'package:firebase_crashlytics/firebase_crashlytics.dart';
// import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fluttertoast/fluttertoast.dart';

void launchURL(String url) async {
  if (await canLaunch(url))
    await launch(url);
  else
    throw 'Could not launch $url';
}

int daysBetween(DateTime from, DateTime to) {
  from = DateTime(from.year, from.month, from.day);
  to = DateTime(to.year, to.month, to.day);
  return (to.difference(from).inHours / 24).round();
}

String formatMoney(dynamic amount, {int? decimalDigits, String name = "NGN"}) {
  return NumberFormat.simpleCurrency(
          locale: Platform.localeName, name: name, decimalDigits: decimalDigits)
      .format(amount);
}

String getTransactionType(int type) {
  if (type == 1)
    return "Wallet to wallet";
  else if (type == 2)
    return "Wallet to group";
  else if (type == 3)
    return "Group to wallet";
  else if (type == 4)
    return "Bank to wallet";
  else if (type == 5)
    return "Wallet to bank";
  else
    return "Transfer fee";
}

String getTransactionStatus(int status) {
  if (status == 1)
    return "pending";
  else if (status == 2)
    return "processing";
  else if (status == 3)
    return "completed";
  else if (status == 4)
    return "failed";
  else if (status == 5)
    return "canceled";
  else
    return "unknown";
}

String formatDate(String date, {String? format, Duration? duration}) {
  DateTime dateTime = DateTime.parse(date);
  date = dateTime.toIso8601String();
  if (!date.contains("-")) {
    return formatDate(
        DateTime.fromMillisecondsSinceEpoch(int.parse(date)).toIso8601String());
  } else if (date.contains("T")) {
    var dateTime = DateTime.parse(date);
    if (duration != null) {
      dateTime = dateTime.add(duration);
    }
    return DateFormat(format ?? 'MMM dd, yyyy HH:mm').format(dateTime);
  } else {
    return date;
  }
}

String formatStringDate(String date) {
  String day = date.split("-").first;
  String month = date.split("-").skip(1).first;
  String year = date.split("-").skip(2).first;

  if (day.split("").length == 4) return date.split("T").first;

  return "${getYear(int.parse(year))}-${getMonth(month)}-$day";
}

String getMonth(String month) {
  switch (month.toLowerCase()) {
    case "dec":
      return "12";
    case "nov":
      return "11";
    case "oct":
      return "10";
    case "sep":
      return "9";
    case "aug":
      return "8";
    case "jul":
      return "7";
    case "jun":
      return "6";
    case "may":
      return "5";
    case "apr":
      return "4";
    case "mar":
      return "3";
    case "feb":
      return "2";
    case "jan":
      return "1";
    default:
      return month;
  }
}

int getYear(int year) {
  if (year > 23 && year < 1000) {
    return year + 1900;
  } else if (year < 23 && year < 1000) {
    return year + 2000;
  } else {
    return year;
  }
}

copyText(BuildContext context, String text) async {
  await Clipboard.setData(ClipboardData(text: text));
  Fluttertoast.showToast(
      msg: "Copied",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      fontSize: 16.0);
}

String getFirstName(String name) {
  if (name.split(" ").isNotEmpty) {
    String text = name.split(" ").first;
    print("Last name: $text");
    return text;
  }
  return "";
}

String getLastName(String name) {
  if (name.split(" ").skip(1).isNotEmpty) {
    String text = name.split(" ").skip(1).first;
    print("First name: $text");
    return text;
  }
  return "";
}

String getMiddleName(String name) {
  if (name.split(" ").skip(2).isNotEmpty) {
    String text = name.split(" ").skip(2).first;
    print("Middle name: $text");
    return text;
  }
  return "";
}

onShareText(String text) async {
  try {
    await Share.share(text);
  } catch (e, s) {
    // await FirebaseCrashlytics.instance.recordError(e, s, reason: 'Share error');
  }
}

String handlePlatformException(PlatformException e) {
  // You can handle specific error codes
  switch (e.code) {
    case 'PERMISSION_DENIED':
    // Handle permission denied error
      return 'Permission denied: ${e.message}';
    case 'NETWORK_ERROR':
    // Handle network error
      return 'Network error: ${e.message}';
    default:
    // Handle other types of errors
      return 'An unknown error occurred: ${e.message}';
  }
}

String formNum(String inputString) {
  if(inputString.isEmpty){
    return inputString;
  }
  String text1 = inputString;
  if (text1.split(".").length > 2){
    text1 = customReplace(text1,".",2,"");
    return text1;
  }
  else if (text1.split(".").length == 2){
    num n1 = num.parse(text1.split(".").first.replaceAll(",", ""));
    String decimalPlace = text1.split(".").skip(1).first;
    if(decimalPlace.split("").length > 2){
      decimalPlace = decimalPlace.split("").elementAt(0) + decimalPlace.split("").elementAt(1);
    }
    String text2 = NumberFormat.decimalPattern().format(n1) + "." + decimalPlace;
    return text2;
  }
  String text3 = inputString.replaceAll(',', '');
  text1 = text3;
  return NumberFormat.decimalPattern().format(
    num.parse(text1),
  );
}

String customReplace(String text,String searchText, int replaceOn, String replaceText){
  String data = text.split(".").first + "." + text.split(".").skip(1).first;
  return data;
}

// Future<String> getDeviceID () async {
//   try{
//     //String? deviceId = await PlatformDeviceId.getDeviceId;
//     FirebaseMessaging messaging = FirebaseMessaging.instance;
//     String? deviceId = await messaging.getToken();
//     return deviceId == null ? "" : deviceId;
//   } catch (e){
//     print(e.toString());
//     return "";
//   }
// }
//
// Future<String> createDynamicLink({bool short = false, required String groupCode}) async {
//   FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;
//   final String dynamicLink = 'https://imcard_admin_app.group.link/join?code=$groupCode';
//   final DynamicLinkParameters parameters = DynamicLinkParameters(
//     uriPrefix: 'https://imcard_admin_app.page.link',
//     link: Uri.parse(dynamicLink),
//     androidParameters: AndroidParameters(
//       packageName: 'com.im.tech.imcard',
//       minimumVersion: 0,
//     ),
//     iosParameters: IOSParameters(
//         bundleId: 'com.im.tech.imcard',
//         minimumVersion: '0',
//         appStoreId: '1631162366'
//     ),
//   );
//
//   Uri url;
//   if (short) {
//     final ShortDynamicLink shortLink =
//     //await parameters.buildShortLink();
//     await dynamicLinks.buildShortLink(parameters);
//     url = shortLink.shortUrl;
//   } else {
//     //url = await parameters.buildUrl();
//     url = await dynamicLinks.buildLink(parameters);
//   }
//   return url.toString();
// }
//
// Future<String> createInviteLink({bool short = false, required String tag}) async {
//   FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;
//   final String dynamicLink = 'https://imtech.app.link/referral?refferal=$tag';
//   final DynamicLinkParameters parameters = DynamicLinkParameters(
//     uriPrefix: 'https://imtech.page.link',
//     link: Uri.parse(dynamicLink),
//     androidParameters: AndroidParameters(
//       packageName: 'com.im.tech.imcard',
//       minimumVersion: 0,
//     ),
//     iosParameters: IOSParameters(
//         bundleId: 'com.im.tech.imcard',
//         minimumVersion: '0',
//         appStoreId: '1631162366'
//     ),
//   );
//
//   Uri url;
//   if (short) {
//     final ShortDynamicLink shortLink =
//     //await parameters.buildShortLink();
//     await dynamicLinks.buildShortLink(parameters);
//     url = shortLink.shortUrl;
//   } else {
//     //url = await parameters.buildUrl();
//     url = await dynamicLinks.buildLink(parameters);
//   }
//   return url.toString();
// }
