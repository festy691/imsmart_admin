import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:imsmart_admin/core/utils/app_assets.dart';
import 'package:imsmart_admin/core/utils/app_theme.dart';
import 'package:imsmart_admin/core/utils/constants.dart';
import 'package:imsmart_admin/core/utils/page_router.dart';
import 'package:imsmart_admin/core/utils/pallet.dart';
import 'package:imsmart_admin/core/utils/utils.dart';
import 'package:imsmart_admin/core/widget/image_loader.dart';
import 'package:imsmart_admin/core/widget/text_views.dart';
import 'package:imsmart_admin/models/book_apartment_model.dart';
import 'package:imsmart_admin/models/room_property_model.dart';
import 'package:imsmart_admin/pages/home_screens/components/receipt_option.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share/share.dart';

class ReceiptScreen extends StatefulWidget {
  final RoomPropertyModel roomPropertyModel;
  final BookApartmentModel bookApartmentModel;
  const ReceiptScreen({
    super.key,
    required this.roomPropertyModel,
    required this.bookApartmentModel,
  });

  @override
  State<ReceiptScreen> createState() => _ReceiptScreenState();
}

class _ReceiptScreenState extends State<ReceiptScreen> {
  int totalDays = 0;

  ScreenshotController screenshotController = ScreenshotController();
  GlobalKey previewContainer = GlobalKey();

  _captureScreen() async {
    final imageFile = await screenshotController.capture();
    Uint8List imageInUnit8List = imageFile!;
    final tempDir = await getTemporaryDirectory();
    File file = await File('${tempDir.path}/receipt.png').create();
    file.writeAsBytesSync(imageInUnit8List);
    Share.shareFiles([file.path]);
  }

  int originalSize = 800;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DateTime selectDateIn =
        DateTime.parse(widget.bookApartmentModel.checkinDate);
    DateTime selectDateOut =
        DateTime.parse(widget.bookApartmentModel.checkoutDate);
    totalDays = (selectDateIn.difference(selectDateOut).inDays).abs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Pallet.primaryColor,
        title: TextView(
          text: "",
          textStyle: body1TextStyle.copyWith(
            fontSize: setSp(20),
            fontWeight: FontWeight.w600,
            color: Pallet.white,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Pallet.primaryColor,
        ),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Screenshot(
                  controller: screenshotController,
                  child: Container(
                    color: Pallet.primaryColor,
                    padding: EdgeInsets.symmetric(horizontal: setWidth(20)),
                    child: Column(
                      children: [
                        SizedBox(height: setHeight(20)),
                        ImageLoader(
                          path: AppAssets.successIcon,
                        ),
                        SizedBox(height: setHeight(30)),
                        TextView(
                          text: "Reservation Success!",
                          textAlign: TextAlign.center,
                          textStyle: captionStyle.copyWith(
                            fontSize: setSp(20),
                            height: 0.10,
                          ),
                        ),
                        SizedBox(height: setHeight(16)),
                        Text(
                          "Please download your receipt and bring a copy of it with a valid ID Card when checking in to your apartment.",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                              fontSize: setSp(14),
                              // height: 0.10,
                              color: Pallet.lightGrey,
                              fontWeight: FontWeight.w400),
                        ),
                        SizedBox(height: setHeight(15)),
                        TextView(
                          text: formatMoney(
                            widget.bookApartmentModel.transactionAmount,
                          ),
                          textAlign: TextAlign.center,
                          textStyle: captionStyle.copyWith(
                            fontSize: setSp(24),
                            fontWeight: FontWeight.w600,
                            fontFamily: "Sans",
                          ),
                        ),
                        SizedBox(height: setHeight(50.11)),
                        ReceiptOption(
                          title: "Ref Number",
                          caption: widget.roomPropertyModel.id,
                        ),
                        SizedBox(height: setHeight(23.32)),
                        ReceiptOption(
                          title: "Payment Time",
                          caption: formatDate(widget.roomPropertyModel.date),
                        ),
                        SizedBox(height: setHeight(23.32)),
                        ReceiptOption(
                          title: "Apartment",
                          caption: widget.roomPropertyModel.title,
                        ),
                        SizedBox(height: setHeight(23.32)),
                        ReceiptOption(
                          title: "Duration",
                          caption:
                              "${formatDate(widget.bookApartmentModel.checkinDate, format: "MMM dd, yyyy")} to ${formatDate(widget.bookApartmentModel.checkoutDate, format: "MMM dd, yyyy")}",
                        ),
                        SizedBox(height: setHeight(26.65)),
                        Divider(
                          color: Pallet.white,
                        ),
                        SizedBox(height: setHeight(26.65)),
                        ReceiptOption(
                          title: "Nights",
                          caption: "$totalDays night(s)",
                        ),
                        SizedBox(height: setHeight(23.32)),
                        ReceiptOption(
                          title: "Apartment Compartment",
                          caption:
                              "${widget.roomPropertyModel.roomNumber} Bedroom(s)",
                        ),
                        SizedBox(height: setHeight(70)),
                        Align(
                          alignment: Alignment.centerRight,
                          child: ImageLoader(
                            path: AppAssets.downloadIcon,
                            width: setWidth(25),
                            onTap: () {
                              _captureScreen();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            ImageLoader(
              path: AppAssets.imSmartLogoTransparent,
              width: setWidth(248),
              height: setHeight(105),
            ),
          ],
        ),
      ),
    );
  }
}
