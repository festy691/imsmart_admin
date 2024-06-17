import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:imsmart_admin/core/utils/app_assets.dart';
import 'package:imsmart_admin/core/utils/app_theme.dart';
import 'package:imsmart_admin/core/utils/constants.dart';
import 'package:imsmart_admin/core/utils/input_formatter.dart';
import 'package:imsmart_admin/core/utils/pallet.dart';
import 'package:imsmart_admin/core/utils/payment_card_utils.dart';
import 'package:imsmart_admin/core/utils/validators.dart';
import 'package:imsmart_admin/core/widget/edit_form_widget.dart';
import 'package:imsmart_admin/core/widget/image_loader.dart';
import 'package:imsmart_admin/core/widget/text_views.dart';
import 'package:imsmart_admin/models/payment_card_model.dart';

class CheckOutPayment extends StatefulWidget {
  final TextEditingController cardNumberController;
  final TextEditingController expiryDateController;
  final TextEditingController cvvController;
  final TextEditingController cardNameController;
  final GlobalKey<FormState> formKey;
  final AutovalidateMode autoValidateMode;

  const CheckOutPayment(
      {Key? key,
      required this.cardNumberController,
      required this.expiryDateController,
      required this.cvvController,
      required this.cardNameController,
      required this.formKey,
      required this.autoValidateMode})
      : super(key: key);

  @override
  State<CheckOutPayment> createState() => _CheckOutPaymentState();
}

class _CheckOutPaymentState extends State<CheckOutPayment> {
  PaymentCardModel _paymentCardModel = PaymentCardModel();

  @override
  void initState() {
    _paymentCardModel.type = CardType.Others;
    widget.cardNumberController.addListener(_getCardTypeFrmNumber);
    super.initState();
  }

  void _getCardTypeFrmNumber() {
    String input =
        PaymentCardUtils.getCleanedNumber(widget.cardNumberController.text);
    CardType cardType = PaymentCardUtils.getCardTypeFrmNumber(input);
    setState(() {
      this._paymentCardModel.type = cardType;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: setHeight(51)),
        Stack(
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: setWidth(22),
                vertical: setHeight(22),
              ),
              decoration: ShapeDecoration(
                gradient: LinearGradient(
                  begin: Alignment(0.00, -1.00),
                  end: Alignment(0, 1),
                  colors: [Color(0xFF9A9A9A), Color(0xFF59595A)],
                ),
                // color: Pallet.darkGray,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
              clipBehavior: Clip.antiAlias,
              child: Form(
                key: widget.formKey,
                autovalidateMode: widget.autoValidateMode,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        ImageLoader(
                          path: AppAssets.atm,
                        ),
                        Spacer(),
                        PaymentCardUtils.getCardIcon(_paymentCardModel.type) ??
                            Icon(
                              Icons.credit_card,
                              size: 40.0.w,
                              color: Pallet.cream,
                            ),
                      ],
                    ),

                    SizedBox(height: 48.h),

                    TextView(
                      text: widget.cardNumberController.text.isNotEmpty
                          ? widget.cardNumberController.text
                          : "Card Number",
                      textStyle: body4TextStyle,
                    ),

                    SizedBox(height: 10.h),

                    Row(
                      children: [
                        TextView(
                          text: widget.cardNameController.text.isNotEmpty
                              ? widget.cardNameController.text
                              : "Card Name",
                          textStyle: body4TextStyle,
                        ),

                        const Spacer(),

                        TextView(
                          text: widget.expiryDateController.text.isNotEmpty
                              ? widget.expiryDateController.text
                              : "MM/YY",
                          textStyle: body4TextStyle,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: -60,
              left: -100,
              child: Container(
                width: 315.w,
                height: 315.h,
                decoration: ShapeDecoration(
                  color: Pallet.lightGrey.withOpacity(0.1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(500.r),
                  ),
                ),
              ),
            ),
          ],
        ),

        SizedBox(height: 32.h),

        EditFormField(
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(30),
            CardNumberInputFormatter(),
          ],
          hint: "Card Number",
          controller: widget.cardNumberController,
          keyboardType: TextInputType.number,
          onChanged: (text) {
            if (mounted) {
              _paymentCardModel.number =
                  PaymentCardUtils.getCleanedNumber(text);
              setState(() {});
            }
          },
        ),

        SizedBox(height: 20.h),

        Row(
          children: [
            Expanded(
              child: EditFormField(
                hint: "Expiry",
                controller: widget.expiryDateController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(4),
                  CardMonthInputFormatter(),
                ],
                onChanged: (text) {
                  if (mounted) {
                    setState(() {
                      List<int> expiryDate =
                          PaymentCardUtils.getExpiryDate(text);
                      _paymentCardModel.month = expiryDate[0];
                      _paymentCardModel.year = expiryDate[1];
                    });
                  }
                },
              ),
            ),

            SizedBox(height: 20.h),

            Expanded(
              child: EditFormField(
                hint: "CVV",
                controller: widget.cvvController,
                keyboardType: TextInputType.number,
                validator: PaymentCardUtils.validateCVV,
                onChanged: (text) {
                  if (mounted) {
                    setState(() {
                      _paymentCardModel.cvv = int.parse(text!);
                    });
                  }
                },
              ),
            ),
          ],
        ),

        SizedBox(height: 20.h),

        EditFormField(
          hint: "Name",
          controller: widget.cardNameController,
          keyboardType: TextInputType.text,
          validator: Validators.validateString(),
          onChanged: (text) {
            if (mounted) {
              setState(() {});
            }
          },
        ),

        SizedBox(height: 20.h),

      ],
    );
  }
}
