import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:imsmart_admin/core/utils/app_assets.dart';
import 'package:imsmart_admin/core/utils/app_theme.dart';
import 'package:imsmart_admin/core/utils/constants.dart';
import 'package:imsmart_admin/core/utils/page_router.dart';
import 'package:imsmart_admin/core/utils/pallet.dart';
import 'package:imsmart_admin/core/utils/utils.dart';
import 'package:imsmart_admin/core/widget/custom_button.dart';
import 'package:imsmart_admin/core/widget/dialogs.dart';
import 'package:imsmart_admin/core/widget/image_loader.dart';
import 'package:imsmart_admin/core/widget/text_views.dart';
import 'package:imsmart_admin/models/room_property_model.dart';
import 'package:imsmart_admin/pages/home_screens/components/room_items.dart';
import 'package:maps_launcher/maps_launcher.dart';

class RoomProperty extends StatefulWidget {
  final RoomPropertyModel roomProperty;
  final VoidCallback onTap;
  const RoomProperty({
    Key? key,
    required this.roomProperty,
    required this.onTap,
  }) : super(key: key);

  @override
  State<RoomProperty> createState() => _RoomPropertyState();
}

class _RoomPropertyState extends State<RoomProperty> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      // clipBehavior: Clip.none,
      children: [
        Container(
          decoration: const ShapeDecoration(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
          ),
          clipBehavior: Clip.antiAlias,
          child: ImageLoader(
            path: widget.roomProperty.imagePath,
            width: getHeight(context),
            height: setHeight(239.5),
            fit: BoxFit.cover,
          ),
        ),
        Container(
          width: getWidth(context),
          // height: getHeight(context) / 1.29,
          decoration: const BoxDecoration(
            color: Pallet.cream,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: setWidth(20),
                  vertical: setHeight(20),
                ),
                width: getWidth(context),
                decoration: const ShapeDecoration(
                  color: Pallet.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextView(
                      text: "${widget.roomProperty.title}",
                      textStyle: body1TextStyle.copyWith(
                        fontSize: setSp(22),
                        fontWeight: FontWeight.w700,
                        color: Pallet.black,
                      ),
                    ),
                    SizedBox(height: setHeight(8)),
                    Row(children: [
                      RoomItem(
                        imagePath: AppAssets.home,
                        caption: "${widget.roomProperty.roomNumber} rooms",
                      ),
                      SizedBox(width: setWidth(24)),
                      RoomItem(
                        imagePath: AppAssets.bath,
                        caption: "${widget.roomProperty.toilet} toilet",
                      ),
                    ]),
                    SizedBox(height: setHeight(8)),
                    InkWell(
                      onTap: () async {
                        setState(() {
                          isLoading = true;
                        });
                        await _openMapWithAddress(widget.roomProperty.location);
                        setState(() {
                          isLoading = false;
                        });
                      },
                      child: Row(
                        children: [
                          ImageLoader(
                            path: AppAssets.locationOutline,
                            width: 12.38,
                            height: 15.75,
                          ),
                          SizedBox(width: setWidth(8)),
                          TextView(
                            text: widget.roomProperty.location,
                            textStyle: buttonTextStyle.copyWith(
                              fontSize: setSp(12),
                              fontWeight: FontWeight.w400,
                              color: Pallet.semiDarkGrayAccent,
                            ),
                          ),
                          if (isLoading) ...[
                            SizedBox(width: setWidth(10)),
                            SizedBox(
                              width: setWidth(20),
                              height: setWidth(20),
                              child: CircularProgressIndicator(
                                strokeWidth: 2.5,
                                color: Pallet.primaryColor,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    SizedBox(height: setHeight(12)),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextView(
                              text: formatMoney(widget.roomProperty.amount),
                              textStyle: body1TextStyle.copyWith(
                                fontSize: setSp(20),
                                fontWeight: FontWeight.w600,
                                color: Pallet.black,
                              ),
                            ),
                            // TextView(
                            //   text: "${widget.roomProperty.status}",
                            //   textStyle: body1TextStyle.copyWith(
                            //     fontSize: setSp(12),
                            //     fontWeight: FontWeight.w400,
                            //     color: Pallet.grayAccent,
                            //   ),
                            // ),
                          ],
                        ),
                        const Spacer(),
                        CustomSmallButtonWidget(
                          onTap: widget.onTap,
                          //     () {
                          //   PageRouter.gotoWidget(BookRoomScreen(), context);
                          // },
                          buttonText: "View",
                          width: setWidth(130),
                          height: setHeight(50),
                          buttonColor: Pallet.primaryColor,
                          buttonTextStyle: body1TextStyle.copyWith(
                            color: Pallet.white,
                            fontSize: setSp(16),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _openMapWithAddress(String address) async {
    try {
      List<Location> locations = await locationFromAddress(address);

      if (locations.isNotEmpty) {
        double latitude = locations[0].latitude;
        double longitude = locations[0].longitude;

        // String mapUrl =
        //     'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';

        // if (await canLaunchUrlString(mapUrl)) {
        //   await launchUrlString(mapUrl);
        // } else {
        //   return;
        // }

        await MapsLauncher.launchCoordinates(latitude, longitude);
        // await MapsLauncher.launchQuery(address);
      } else {
        AppDialog.showErrorDialog(context,
            message: 'Could not find location for the given address',
            onContinue: () {
          PageRouter.goBack(context);
        });
      }
    } catch (e) {
      AppDialog.showErrorDialog(context, message: 'Error: $e', onContinue: () {
        PageRouter.goBack(context);
      });
    }
  }
}
