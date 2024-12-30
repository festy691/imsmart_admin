import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:imsmart_admin/core/utils/app_theme.dart';
import 'package:imsmart_admin/core/utils/pallet.dart';
import 'package:imsmart_admin/core/widget/image_loader.dart';
import 'package:imsmart_admin/core/widget/text_views.dart';
import 'package:imsmart_admin/models/city_model.dart';

class PlaceCard extends StatelessWidget {
  final CityModel city;
  final Function onTap;
  const PlaceCard({super.key, required this.city, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        width: 150.w,
        height: 150.h,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(14.w)),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              bottom: 0,
              left: 0,
              right: 0,
              child: ImageLoader(
                path: city.displayImage,
                width: 150.w,
                height: 150.h,
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextView(
                      text: "${city.title}",
                      maxLines: 1,
                      textStyle: body1TextStyle.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: Pallet.white,
                      ),
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
