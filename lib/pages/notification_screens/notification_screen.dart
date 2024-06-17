// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// 
// import 'package:imsmart_admin/core/extensions/extended_build_context.dart';
// import 'package:imsmart_admin/core/my_providers/notification_provider.dart';
// import 'package:imsmart_admin/core/utils/app_assets.dart';
// import 'package:imsmart_admin/core/utils/constants.dart';
// import 'package:imsmart_admin/core/utils/page_router.dart';
// import 'package:imsmart_admin/core/widget/background_widget.dart';
// import 'package:imsmart_admin/core/widget/empty_screen.dart';
// import 'package:imsmart_admin/core/widget/image_loader.dart';
// import 'package:imsmart_admin/core/widget/text_views.dart';
// import 'package:imsmart_admin/models/notification_model.dart';
// import 'package:imsmart_admin/pages/notification_screens/widgets/notification_list_widget.dart';
// import 'package:provider/provider.dart';
// import 'package:pull_to_refresh/pull_to_refresh.dart';
//
// class NotificationScreen extends StatefulWidget {
//   const NotificationScreen({Key? key}) : super(key: key);
//
//   @override
//   State<NotificationScreen> createState() => _NotificationScreenState();
// }
//
// class _NotificationScreenState extends State<NotificationScreen> {
//   late NotificationProvider _provider;
//
//   int page = 1;
//
//   int pageSize = 20;
//
//   List<NotificationModel> _notificationList = [];
//
//   @override
//   void initState() {
//     _provider = context.provideOnce<NotificationProvider>();
//     super.initState();
//   }
//
//   loadNotification({required BuildContext context}) async {
//     var response = await _provider.loadAllNotifications(
//       context: context,
//     );
//   }
//
//   RefreshController _refreshController = RefreshController(
//     initialRefresh: true,
//   );
//
//   void _onRefresh() async {
//     page = 1;
//     await loadNotification(context: context);
//     _refreshController.loadComplete();
//
//     _refreshController.refreshToIdle();
//   }
//
//   void _onLoading() async {
//     await loadNotification(context: context);
//     _refreshController.loadComplete();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     NotificationProvider _provider = Provider.of<NotificationProvider>(context);
//     List<NotificationModel> _notificationList = _provider.allNotifications;
//     return BackgroundWidget(
//       hasAppBar: false,
//       body: SafeArea(
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: setWidth(20)),
//           child: Column(
//             children: [
//               SizedBox(height: setHeight(28)),
//               Row(
//                 children: [
//                   ImageLoader(
//                     path: AppAssets.arrowBack,
//                     width: setWidth(32),
//                     height: setHeight(24),
//                     onTap: () {
//                       PageRouter.goBack(context);
//                     },
//                   ),
//                 ],
//               ),
//               SizedBox(height: setHeight(32)),
//               Expanded(
//                 child: SmartRefresher(
//                   enablePullDown: true,
//                   enablePullUp: true,
//                   header: WaterDropHeader(),
//                   footer: CustomFooter(
//                     builder: (context, mode) {
//                       Widget body;
//                       if (mode == LoadStatus.idle) {
//                         body = TextView(text: "pull up load");
//                       } else if (mode == LoadStatus.loading) {
//                         body = CupertinoActivityIndicator();
//                       } else if (mode == LoadStatus.failed) {
//                         body = TextView(text: "Load Failed!Click retry!");
//                       } else if (mode == LoadStatus.canLoading) {
//                         body = TextView(text: "release to load more");
//                       } else {
//                         body = TextView(text: "No more Data");
//                       }
//                       return Container(
//                         height: 55.0,
//                         child: Center(child: body),
//                       );
//                     },
//                   ),
//                   controller: _refreshController,
//                   onRefresh: _onRefresh,
//                   onLoading: _onLoading,
//                   child: _notificationList.length > 0
//                       ? NotificationListWidget(
//                           notificationList: _notificationList,
//                         )
//                       : EmptyScreen(
//                           title: 'You don\'t have any notification',
//                         ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
