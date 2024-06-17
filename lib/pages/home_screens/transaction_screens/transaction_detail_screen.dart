import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:imsmart_admin/core/utils/app_theme.dart';
import 'package:imsmart_admin/core/utils/page_router.dart';
import 'package:imsmart_admin/core/utils/pallet.dart';
import 'package:imsmart_admin/core/utils/utils.dart';
import 'package:imsmart_admin/core/widget/text_views.dart';
import 'package:imsmart_admin/models/transaction_model.dart';
import 'package:imsmart_admin/pages/home_screens/book_room_screen.dart';

class TransactionDetailScreen extends StatelessWidget {
  final TransactionModel transactionModel;
  const TransactionDetailScreen({super.key, required this.transactionModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      height: 600.h,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(24.r), topRight: Radius.circular(24.r)),
        color: Pallet.white,
      ),
      child: ListView(
        children: [
          receiptItemWidget(
            context, title: 'Apartment', desc: transactionModel.property['title'],
            isLink: true,
            onTap: (){
              PageRouter.gotoWidget(BookRoomScreen(propertyId: transactionModel.property['_id']), context);
            }
          ),
          receiptItemWidget(context, title: 'Check-in date', desc: formatDate(transactionModel.checkinDate, format: 'MMM dd, yyyy')),
          receiptItemWidget(context, title: 'Check-out date', desc: formatDate(transactionModel.checkoutDate, format: 'MMM dd, yyyy')),
          receiptItemWidget(context, title: 'Amount paid', desc: formatMoney(transactionModel.transactionAmount)),
          receiptItemWidget(context, title: 'Client name', desc: "${transactionModel.firstName} ${transactionModel.lastName}"),
          receiptItemWidget(context, title: 'Client email', desc: transactionModel.email),
          receiptItemWidget(context, title: 'Client phone', desc: transactionModel.phoneNumber),
          receiptItemWidget(context, title: 'Payment ref', desc: transactionModel.transactionRef ?? ""),
          receiptItemWidget(context, title: 'Payment status', desc: transactionModel.status),
          receiptItemWidget(context, title: 'Date booked', desc: formatDate(transactionModel.date)),
        ],
      ),
    );
  }

  Widget receiptItemWidget(BuildContext context, {required String title, required String desc, bool isLink = false, Function? onTap}) =>
      GestureDetector(
        onTap: ()=> onTap != null ? onTap() : {},
    child: Column(
      children: [
        SizedBox(height: 12.h),

        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: TextView(
                text: title,
                textStyle: captionStyle.copyWith(
                  color: Pallet.grey,
                  fontSize: 14.sp,
                  height: 1.50,
                ),
              ),
            ),
            TextView(
              text: desc,
              textStyle: captionStyle.copyWith(
                color: isLink ? Pallet.blue : Pallet.black,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                height: 1.50,
                decoration: isLink ? TextDecoration.underline : TextDecoration.none
              ),
            ),
          ],
        ),

        SizedBox(height: 12.h),
        const Divider(color: Pallet.lightGrey, thickness: 1,)
      ],
    ),
  );

}
