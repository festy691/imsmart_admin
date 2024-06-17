import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:imsmart_admin/core/extensions/extended_build_context.dart';
import 'package:imsmart_admin/core/my_providers/property_provider.dart';
import 'package:imsmart_admin/core/utils/app_assets.dart';
import 'package:imsmart_admin/core/utils/app_theme.dart';
import 'package:imsmart_admin/core/utils/constants.dart';
import 'package:imsmart_admin/core/utils/page_router.dart';
import 'package:imsmart_admin/core/utils/pallet.dart';
import 'package:imsmart_admin/core/widget/custom_button.dart';
import 'package:imsmart_admin/core/widget/image_loader.dart';
import 'package:imsmart_admin/models/room_property_model.dart';
import 'package:imsmart_admin/pages/home_screens/book_appointment_screens/active_bookings_screen.dart';
import 'package:imsmart_admin/pages/home_screens/components/room_section.dart';
import 'package:imsmart_admin/pages/home_screens/book_appointment_screens/reservation_screen.dart';
import 'package:photo_view/photo_view.dart';

class PreviewRoomScreen extends StatefulWidget {
  final RoomPropertyModel roomProperty;
  String imagePath;
  int index;
  PreviewRoomScreen({
    Key? key,
    required this.roomProperty,
    required this.imagePath,
    required this.index,
  }) : super(key: key);

  @override
  State<PreviewRoomScreen> createState() => _PreviewRoomScreenState();
}

class _PreviewRoomScreenState extends State<PreviewRoomScreen> {
  late PageController _pageController;
  ScrollController _listViewScrollController = ScrollController();
  int _activeImage = 0;

  @override
  void initState() {
    _activeImage = widget.index;
    _pageController = PageController(initialPage: _activeImage);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _listViewScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int totalRoomImages = widget.roomProperty.roomImages.length;
    return Scaffold(
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: getWidth(context),
            height: getHeight(context),
            child: PageView.builder(
              scrollDirection: Axis.horizontal,
              controller: _pageController,
              itemBuilder: (context, index) {
                return Container(
                  child: PhotoView(
                    imageProvider: NetworkImage(widget.imagePath),
                    backgroundDecoration: BoxDecoration(
                      color: Pallet.bgColor,
                    ),
                  ),
                );
                //   ImageLoader(
                //   path: widget.imagePath,
                //   fit: BoxFit.cover,
                // );
              },
              itemCount: totalRoomImages,
              onPageChanged: (index) {
                double scrollPosition = index * setWidth(252);
                double screenCenter = getWidth(context) / 2;
                double centerPosition =
                    scrollPosition - screenCenter + setWidth(252) / 2;
                _activeImage = index;
                widget.imagePath = widget.roomProperty.roomImages[index];
                _listViewScrollController.animateTo(
                  centerPosition,
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
                setState(() {});
              },
            ),
          ),

          Positioned(
            top: 70.h,
            left: 20.w,
            child: ImageLoader(
              path: AppAssets.arrowBack,
              dColor: Pallet.black,
              width: 24.w,
              fit: BoxFit.fitWidth,
              onTap: () {
                PageRouter.goBack(context);
              },
            ),
          ),

          Positioned(
            bottom: 64,
            right: 0,
            left: 0,
            child: SizedBox(
              height: setHeight(115),
              child: ListView.builder(
                // padding: EdgeInsets.only(left: setWidth(19)),
                scrollDirection: Axis.horizontal,
                controller: _listViewScrollController,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(
                        right: index == (totalRoomImages - 1)
                            ? setWidth(0)
                            : setWidth(19)),
                    child: RoomSection(
                      imagePath: widget.roomProperty.roomImages[index],
                      isSelected: _activeImage == index,
                      onTap: () {
                        _activeImage = index;
                        widget.imagePath =
                            widget.roomProperty.roomImages[index];
                        _pageController.animateToPage(
                          index,
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        );
                      },
                    ),
                  );
                },
                itemCount: totalRoomImages,
                shrinkWrap: true,
              ),
            ),
          ),
          /*Positioned(
            bottom: setHeight(24),
            right: setWidth(12),
            left: setWidth(12),
            child: Center(
              child: CustomButtonWidget(
                onTap: () async {
                  var result = await context
                      .provideOnce<PropertyProvider>()
                      .loadAllBookings(
                          context: context,
                          propertyId: widget.roomProperty.id,
                          load: true);
                  if (result.error) return;
                  PageRouter.gotoWidget(
                      ActiveBookingScreen(
                        roomPropertyModel: widget.roomProperty,
                      ),
                      context);
                },
                buttonText: "Book Now",
                width: getWidth(context),
                height: setHeight(53),
                buttonColor: Pallet.primaryColor,
                buttonTextStyle: body1TextStyle.copyWith(
                  color: Pallet.white,
                  fontSize: setSp(22),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),*/
        ],
      ),
    );
  }
}
