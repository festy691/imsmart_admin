// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:imsmart_admin/core/my_providers/notification_provider.dart';
// import 'package:imsmart_admin/core/utils/app_theme.dart';
// import 'package:imsmart_admin/core/utils/constants.dart';
// import 'package:imsmart_admin/core/utils/pallet.dart';
// import 'package:imsmart_admin/core/widget/text_views.dart';
// import 'package:imsmart_admin/models/notification_model.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
// import 'package:pull_to_refresh/pull_to_refresh.dart';
// import 'package:sticky_grouped_list/sticky_grouped_list.dart';
// import 'package:timeago/timeago.dart' as timeago;
//
// class NotificationListWidget extends StatelessWidget {
//   NotificationListWidget({required this.notificationList, Key? key})
//       : super(key: key);
//
//   List<NotificationModel> notificationList;
//
//   late NotificationProvider _provider;
//
//   int daysBetween(DateTime from, DateTime to) {
//     from = DateTime(from.year, from.month, from.day);
//     to = DateTime(to.year, to.month, to.day);
//     return (to.difference(from).inHours / 24).round();
//   }
//
//   _checkToday(DateTime date) {
//     DateTime now = DateTime.now();
//     final difference = daysBetween(date.add(Duration(hours: 1)), now);
//     if (difference == 0) {
//       return "Today";
//     } else if (difference == 1) {
//       return "Yesterday";
//     }
//     return timeago.format(date);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     _provider = Provider.of<NotificationProvider>(context);
//     var format = DateFormat.Hm('en_US');
//
//     return StickyGroupedListView<NotificationModel, DateTime>(
//       //physics: ClampingScrollPhysics(),
//       elements: notificationList,
//       order: StickyGroupedListOrder.DESC,
//       groupBy: (NotificationModel element) {
//         DateTime date = DateTime.parse(element.date);
//         return DateTime(date.year, date.month, date.day);
//       },
//       groupComparator: (DateTime value1, DateTime value2) {
//         return value1.compareTo(value2);
//       },
//       itemComparator: (NotificationModel element1, NotificationModel element2) {
//         DateTime date1 = DateTime.parse(element1.date);
//         DateTime date2 = DateTime.parse(element2.date);
//         return date1.compareTo(date2);
//       },
//       floatingHeader: true,
//       shrinkWrap: true,
//       groupSeparatorBuilder: (NotificationModel element) => Container(
//         height: 50,
//         child: Align(
//           alignment: Alignment.topLeft,
//           child: Padding(
//             padding: EdgeInsets.only(top: setHeight(20)),
//             child: Text(
//               '${_checkToday(DateTime.parse(element.date))}',
//               textAlign: TextAlign.start,
//               style: TextStyle(
//                   fontWeight: FontWeight.w600,
//                   fontSize: ScreenUtil().setSp(14),
//                   color: Pallet.white.withOpacity(0.7)),
//             ),
//           ),
//         ),
//       ),
//       itemBuilder: (_, NotificationModel element) {
//         if (element.read == false) {
//           _provider.readNotification(
//               context: context, notificationId: element.id.toString());
//         }
//         return Container(
//           padding: EdgeInsets.symmetric(horizontal: setWidth(16)),
//           decoration: BoxDecoration(
//               color: !element.read
//                   ? Pallet.white.withOpacity(0.1)
//                   : Pallet.black.withOpacity(0.1),
//               borderRadius: BorderRadius.all(Radius.circular(setWidth(10)))),
//           child: Column(
//             children: [
//               ListTile(
//                 contentPadding: EdgeInsets.symmetric(
//                     horizontal: setWidth(0), vertical: setHeight(10)),
//                 //leading: Icon(element.icon),
//                 title: TextView(
//                   text: element.title,
//                   textStyle: titleStyle.copyWith(
//                       fontSize: setSp(14),
//                       color: element.read
//                           ? Pallet.white.withOpacity(0.6)
//                           : Pallet.white),
//                 ),
//                 subtitle: TextView(
//                   text: element.message,
//                   textStyle: TextStyle(
//                       fontWeight: FontWeight.w400,
//                       fontSize: ScreenUtil().setSp(14),
//                       color: element.read
//                           ? Pallet.white.withOpacity(0.6)
//                           : Pallet.white),
//                 ),
//                 trailing: TextView(
//                   text: '${format.format(DateTime.parse(element.date))}',
//                   textStyle: TextStyle(
//                       fontWeight: FontWeight.w400,
//                       fontSize: ScreenUtil().setSp(12),
//                       color: element.read
//                           ? Pallet.white.withOpacity(0.6)
//                           : Pallet.white),
//                 ),
//               ),
//               Divider(
//                 height: ScreenUtil().setHeight(0.5),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
