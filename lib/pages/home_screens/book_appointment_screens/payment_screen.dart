import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:imsmart_admin/core/extensions/extended_build_context.dart';
import 'package:imsmart_admin/core/my_providers/property_provider.dart';
import 'package:imsmart_admin/core/utils/app_assets.dart';
import 'package:imsmart_admin/core/utils/app_theme.dart';
import 'package:imsmart_admin/core/utils/constants.dart';
import 'package:imsmart_admin/core/utils/page_router.dart';
import 'package:imsmart_admin/core/utils/pallet.dart';
import 'package:imsmart_admin/core/widget/dialogs.dart';
import 'package:imsmart_admin/core/widget/image_loader.dart';
import 'package:imsmart_admin/core/widget/text_views.dart';
import 'package:imsmart_admin/models/book_apartment_model.dart';
import 'package:imsmart_admin/pages/home_screens/book_appointment_screens/reservation_successful_screen.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentScreen extends StatefulWidget {
  final BookApartmentModel bookApartmentModel;
  const PaymentScreen({super.key, required this.bookApartmentModel});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  late PropertyProvider provider;
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    provider = context.provideOnce<PropertyProvider>();
    super.initState();
  }

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
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: WebView(
              initialUrl: provider.paymentInitModel?.authUrl,
              javascriptMode: JavascriptMode.unrestricted,
              userAgent: 'Flutter;Webview',
              onPageFinished: (finish) {
                isLoading = false;
                if(mounted)setState(() {});
              },
              navigationDelegate: (navigation) {
                //Listen for callback URL
                if (navigation.url.contains("https://hello.pstk.xyz/callback")) {
                  //PageRouter.goBack(context); //close webview
                  _goToSuccess();
                }
                if (navigation.url.contains("https://your-cancel-url.com")) {
                  //handle webview removal //close webview
                  //Run the cancel payment function if you have one
                  AppDialog.showErrorDialog(context,
                    message: 'Transaction failed!!!',
                    onContinue: () {
                      PageRouter.goBack(context);
                      PageRouter.goBack(context);
                    }
                  );
                }
                return NavigationDecision.navigate;
              },
            ),
          ),

          if(isLoading) Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: Center(
              child: ImageLoader(
                path: AppAssets.loaderLottie,
                width: 120.w,
                height: 120.h,
              ),
            ),
          ),
        ],
      ),
    );
  }

  _goToSuccess() async {
    BookApartmentModel bookApartmentModel = widget.bookApartmentModel;
    bookApartmentModel.transactionRef = provider.paymentInitModel?.reference;
    var result = await provider.bookApartment(
        context: context, bookApartmentModel: bookApartmentModel);
    if (result.error) return;
    PageRouter.gotoWidget(
        ReservationSuccessfulScreen(
          roomPropertyModel: provider.propertyModel!,
          bookApartmentModel: bookApartmentModel,
        ),
        context,
        clearStack: true);
  }
}
