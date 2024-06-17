import 'package:flutter/material.dart';

import 'package:imsmart_admin/core/utils/app_assets.dart';
import 'package:imsmart_admin/core/utils/app_theme.dart';
import 'package:imsmart_admin/core/utils/constants.dart';
import 'package:imsmart_admin/core/utils/page_router.dart';
import 'package:imsmart_admin/core/utils/pallet.dart';
import 'package:imsmart_admin/core/widget/custom_button.dart';
import 'package:imsmart_admin/core/widget/image_loader.dart';
import 'package:imsmart_admin/core/widget/text_views.dart';
import 'package:imsmart_admin/models/onboarding_model.dart';
import 'package:imsmart_admin/pages/home_screens/home_screen.dart';
import 'package:imsmart_admin/pages/welcome_screens/onboarding_screens/components/onboarding.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController(initialPage: 0);

  int _activePage = 0;

  onTap() {
    _activePage == (_pageItems.length - 1)
        ? PageRouter.gotoWidget(
            HomeScreen(),
            context,
            clearStack: true,
          )
        : _pageController.nextPage(
            duration: Duration(milliseconds: 500),
            curve: Curves.ease,
          );
    setState(() {});
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  final List<OnBoardingModel> _pageItems = <OnBoardingModel>[
    OnBoardingModel(
      imageAssetPath: AppAssets.onboardingImage1,
      title: "Explore",
      heading: "the luxury",
      headingContd: "World",
      caption: "Discover with IMSMART",
    ),
    OnBoardingModel(
      imageAssetPath: AppAssets.splash2,
      title: "",
      heading: "comfortability",
      headingContd: "+LUXURY",
      caption: "Lodging made easy in your hand",
    ),
    OnBoardingModel(
      imageAssetPath: AppAssets.splash3,
      title: "Best",
      heading: "Apartment for",
      headingContd: "you",
      caption: "",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    int _lastPage = (_pageItems.length - 1);
    return Scaffold(
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          ),
          PageView.builder(
            controller: _pageController,
            allowImplicitScrolling: true,
            onPageChanged: (index) {
              _activePage = index;
              setState(() {});
            },
            itemCount: _pageItems.length,
            itemBuilder: (context, index) => OnBoarding(
              imagePath: _pageItems[index].imageAssetPath,
              title: _pageItems[index].title,
              heading: _pageItems[index].heading,
              headingContd: _pageItems[index].headingContd,
              caption: _pageItems[index].caption,
            ),
          ),
          Positioned(
            bottom: 57,
            right: 0,
            left: 0,
            child: Center(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ...List.generate(
                        _pageItems.length,
                        (index) => Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: setWidth(2)),
                          child: Container(
                            width: _activePage == index ? 29 : 8,
                            height: 8,
                            decoration: ShapeDecoration(
                              color: _activePage == index
                                  ? Pallet.primaryColor
                                  : Pallet.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: setHeight(45)),
                  Center(
                    child: Container(
                      width: 56,
                      height: 56,
                      decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(1000))),
                      child: CustomIconButton(
                        onTap: onTap,
                        buttonColor: Pallet.primaryColor,
                        width: setWidth(56),
                        height: setWidth(56),
                        // iconWidth: setWidth(60),
                        // iconHeight: setWidth(60),
                        icon: AppAssets.arrowForwardIos,
                        borderRadius: setWidth(1000000),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            top: setHeight(63),
            right: 0,
            left: 0,
            child: Center(
              child: Column(
                children: [
                  ImageLoader(
                    path: AppAssets.imSmartLogo,
                    height: 105,
                    width: 248,
                  ),
                  TextView(
                    text: "luxury",
                    textStyle: heading.copyWith(
                      fontSize: 50,
                      height: 0.4,
                      shadows: [
                        Shadow(
                          blurRadius: 6,
                          color: Pallet.black,
                          offset: Offset(1, 1),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          // Positioned(
          //   left: 0,
          //   right: 0,
          //   top: setHeight(94),
          //   child: ImageLoader(
          //     path: AppAssets.imSmartLogo,
          //     height: 105,
          //     width: 248,
          //   ),
          // ),
          // Positioned(
          //   top: 165,
          //   left: 125,
          //   right: 93,
          //   child: TextView(
          //     text: "luxury",
          //     textStyle: heading.copyWith(
          //       fontSize: 50,
          //       shadows: [
          //         Shadow(
          //           blurRadius: 6,
          //           color: Pallet.black,
          //           offset: Offset(1, 1),
          //         ),
          //       ],
          //     ),
          //     textAlign: TextAlign.center,
          //   ),
          // ),
          // Positioned(
          //   bottom: setHeight(205),
          //   right: setWidth(0),
          //   left: setWidth(0),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       ...List.generate(
          //         _pageItems.length,
          //         (index) => Padding(
          //           padding: EdgeInsets.symmetric(horizontal: setWidth(2)),
          //           child: Container(
          //             width: _activePage == index ? 29 : 8,
          //             height: 8,
          //             decoration: ShapeDecoration(
          //               color: _activePage == index
          //                   ? Pallet.primaryColor
          //                   : Pallet.white,
          //               shape: RoundedRectangleBorder(
          //                 borderRadius: BorderRadius.circular(4),
          //               ),
          //             ),
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          // Positioned(
          //   bottom: setHeight(49),
          //   left: 0,
          //   right: 0,
          //   child: Center(
          //     child: CustomIconButton(
          //       onTap: onTap,
          //       buttonColor: Pallet.primaryColor,
          //       width: setWidth(56),
          //       height: setWidth(56),
          //       // iconWidth: setWidth(60),
          //       // iconHeight: setWidth(60),
          //       icon: AppAssets.arrowForwardIos,
          //       borderRadius: setWidth(45),
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}
