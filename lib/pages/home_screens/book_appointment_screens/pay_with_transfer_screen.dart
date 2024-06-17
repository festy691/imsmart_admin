import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:imsmart_admin/core/utils/app_assets.dart';
import 'package:imsmart_admin/core/utils/app_theme.dart';
import 'package:imsmart_admin/core/utils/constants.dart';
import 'package:imsmart_admin/core/utils/page_router.dart';
import 'package:imsmart_admin/core/utils/pallet.dart';
import 'package:imsmart_admin/core/utils/payment_card_utils.dart';
import 'package:imsmart_admin/core/widget/custom_button.dart';
import 'package:imsmart_admin/core/widget/dialogs.dart';
import 'package:imsmart_admin/core/widget/edit_form_widget.dart';
import 'package:imsmart_admin/core/widget/image_loader.dart';
import 'package:imsmart_admin/core/widget/text_views.dart';
import 'package:imsmart_admin/core/widget/upload_widget.dart';
import 'package:imsmart_admin/pages/home_screens/components/account_details_card.dart';

typedef OnCompleted = Function(String receipt);

class PayWithTransferScreen extends StatefulWidget {
  OnCompleted onCompleted;
  PayWithTransferScreen({super.key, required this.onCompleted});

  @override
  State<PayWithTransferScreen> createState() => _PayWithTransferScreenState();
}

class _PayWithTransferScreenState extends State<PayWithTransferScreen> {
  String accountNumber = "0123456789";
  TextEditingController pickFileController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Pallet.primaryColor,
        leading: ImageLoader(
          path: AppAssets.arrowBack,
          dColor: Pallet.white,
          width: 24.w,
          fit: BoxFit.fitWidth,
          onTap: () {
            PageRouter.goBack(context);
          },
        ),
        title: TextView(
          text: "Bookings",
          textStyle: body1TextStyle.copyWith(
            fontSize: setSp(20),
            fontWeight: FontWeight.w600,
            color: Pallet.white,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: setWidth(20)),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    SizedBox(height: setHeight(30)),

                    TextView(
                      text: "Bank name",
                      textStyle: body1TextStyle.copyWith(
                        fontSize: setSp(14),
                        fontWeight: FontWeight.w400,
                        color: Pallet.black,
                      ),
                    ),

                    SizedBox(height: setHeight(10)),

                    TextView(
                      text: "Wema Bank",
                      textStyle: body1TextStyle.copyWith(
                        fontSize: setSp(20),
                        fontWeight: FontWeight.w600,
                        color: Pallet.black,
                      ),
                    ),

                    SizedBox(height: setHeight(30)),

                    TextView(
                      text: "Account name",
                      textStyle: body1TextStyle.copyWith(
                        fontSize: setSp(14),
                        fontWeight: FontWeight.w400,
                        color: Pallet.black,
                      ),
                    ),

                    SizedBox(height: setHeight(10)),

                    TextView(
                      text: "IM Smart Luxury",
                      textStyle: body1TextStyle.copyWith(
                        fontSize: setSp(20),
                        fontWeight: FontWeight.w600,
                        color: Pallet.black,
                      ),
                    ),

                    SizedBox(height: setHeight(30)),

                    TextView(
                      text: "Account number",
                      textStyle: body1TextStyle.copyWith(
                        fontSize: setSp(14),
                        fontWeight: FontWeight.w400,
                        color: Pallet.black,
                      ),
                    ),

                    SizedBox(height: setHeight(10)),

                    Row(
                      children: [
                        TextView(
                          text: accountNumber,
                          textStyle: body1TextStyle.copyWith(
                            fontSize: setSp(20),
                            fontWeight: FontWeight.w600,
                            color: Pallet.black,
                          ),
                        ),

                        SizedBox(height: setWidth(12)),

                        InkWell(
                          onTap: () {
                            Clipboard.setData(ClipboardData(text: accountNumber));
                            AppDialog.showInfoDialog(context,
                                message: "Account number copied", onContinue: () {
                                  PageRouter.goBack(context);
                                });
                          },
                          child: Icon(
                            Icons.copy_rounded,
                            color: Pallet.grey,
                          ),
                        ),

                      ],
                    ),

                    SizedBox(height: setHeight(32)),

                    TextView(
                      text: "After making this transfer, please upload receipt",
                      textStyle: body1TextStyle.copyWith(
                        fontSize: setSp(14),
                        fontWeight: FontWeight.w400,
                        color: Pallet.black,
                      ),
                    ),

                    UploadWidget(
                      onUpload: (image) {
                        pickFileController.text = image;
                        if (mounted) {
                          setState(() {});
                        }
                      },
                      controller: pickFileController,
                    ),
                    SizedBox(height: setHeight(24)),
                  ],
                ),
              ),

              CustomButtonWidget(
                disabled: pickFileController.text.isEmpty,
                buttonText: "Proceed",
                width: getWidth(context),
                height: setHeight(56),
                buttonColor: Pallet.primaryColor,
                buttonTextStyle: body1TextStyle.copyWith(
                  color: Pallet.white,
                  fontSize: setSp(18),
                  fontWeight: FontWeight.w600,
                ),
                onTap: () {
                  widget.onCompleted(pickFileController.text);
                },
              ),

              SizedBox(height: setHeight(24)),
            ],
          ),
        ),
      ),
    );
    ;
  }
}
