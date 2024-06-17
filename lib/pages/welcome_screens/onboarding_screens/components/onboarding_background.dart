import 'package:flutter/material.dart';
import 'package:imsmart_admin/core/utils/pallet.dart';

class OnBoardingBackground extends StatelessWidget {
  final String image;
  final Widget child;
  const OnBoardingBackground(
      {Key? key, required this.image, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(image),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          // bottom: -10,
          child: Container(
            // height: 654,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment(0.00, -1.00),
                end: Alignment(0, 1),
                colors: [
                  Pallet.black.withOpacity(0),
                  Pallet.black.withOpacity(0),
                  Pallet.deepBlue,
                  Pallet.semiDeepBlue,
                ],
              ),
            ),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          child: child,
        )
      ],
    );
  }
}
