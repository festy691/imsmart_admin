import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:imsmart_admin/core/utils/app_theme.dart';
import 'package:imsmart_admin/core/utils/pallet.dart';
import 'package:imsmart_admin/core/utils/utils.dart';
import 'package:imsmart_admin/core/widget/image_loader.dart';
import 'package:imsmart_admin/core/widget/text_views.dart';
import 'package:imsmart_admin/models/room_property_model.dart';

class ApartmentCard extends StatelessWidget {
  final RoomPropertyModel propertyModel;
  final Function onTap;
  const ApartmentCard(
      {super.key, required this.propertyModel, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        width: 150.w,
        height: 220.h,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(14.w)),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              bottom: 0,
              left: 0,
              right: 0,
              child: ImageLoader(
                path: propertyModel.imagePath,
                width: 150.w,
                height: 220.h,
                fit: BoxFit.fill,
                isCurvedEdge: true,
                //curve: 14.w,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: Pallet.black.withOpacity(0.4),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(14.w),
                    bottomRight: Radius.circular(14.w),
                  ),
                  // circular(14.w)
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextView(
                      text: "${propertyModel.title}",
                      maxLines: 1,
                      textStyle: body1TextStyle.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: Pallet.white,
                      ),
                    ),
                    TextView(
                      text: "${propertyModel.location}",
                      maxLines: 2,
                      textStyle: body1TextStyle.copyWith(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w400,
                        color: Pallet.white,
                      ),
                    ),
                    Row(
                      children: [
                        TextView(
                          text:
                              "${formatMoney(propertyModel.amount, decimalDigits: 0)}",
                          textStyle: body1TextStyle.copyWith(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: Pallet.white,
                          ),
                        ),
                        const Spacer(),
                        Icon(
                          Icons.star,
                          color: Pallet.gold,
                          size: 14.w,
                        ),
                        TextView(
                          text: "${propertyModel.totalRating}",
                          textStyle: body1TextStyle.copyWith(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: Pallet.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
