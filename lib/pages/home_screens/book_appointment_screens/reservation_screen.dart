import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shakemywidget/flutter_shakemywidget.dart';
import 'package:imsmart_admin/core/widget/bottom_sheets.dart';
import 'package:imsmart_admin/pages/home_screens/book_appointment_screens/payment_screen.dart';
import 'package:imsmart_admin/pages/home_screens/components/payment_card.dart'
    as PayCard;

import 'package:imsmart_admin/core/extensions/extended_build_context.dart';
import 'package:imsmart_admin/core/my_providers/property_provider.dart';
import 'package:imsmart_admin/core/network/url_config.dart';
import 'package:imsmart_admin/core/utils/app_assets.dart';
import 'package:imsmart_admin/core/utils/app_theme.dart';
import 'package:imsmart_admin/core/utils/constants.dart';
import 'package:imsmart_admin/core/utils/page_router.dart';
import 'package:imsmart_admin/core/utils/pallet.dart';
import 'package:imsmart_admin/core/widget/custom_button.dart';
import 'package:imsmart_admin/core/widget/dialogs.dart';
import 'package:imsmart_admin/core/widget/image_loader.dart';
import 'package:imsmart_admin/core/widget/text_views.dart';
import 'package:imsmart_admin/models/book_apartment_model.dart';
import 'package:imsmart_admin/models/room_property_model.dart';
import 'package:imsmart_admin/pages/home_screens/components/check_out_payment.dart';
import 'package:imsmart_admin/pages/home_screens/components/checkout.dart';
import 'package:imsmart_admin/pages/home_screens/components/checkout_registration.dart';
import 'package:imsmart_admin/pages/home_screens/components/payment_option_sheet.dart';
import 'package:imsmart_admin/pages/home_screens/book_appointment_screens/pay_with_transfer_screen.dart';
import 'package:imsmart_admin/pages/home_screens/book_appointment_screens/reservation_successful_screen.dart';
import 'package:intl/intl.dart';

class ReservationScreen extends StatefulWidget {
  RoomPropertyModel roomPropertyModel;
  ReservationScreen({
    Key? key,
    required this.roomPropertyModel,
  }) : super(key: key);

  @override
  State<ReservationScreen> createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController expiryDateController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();
  final TextEditingController cardNameController = TextEditingController();
  final TextEditingController referralController = TextEditingController();
  TextEditingController _pickFileController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final fNameKey = GlobalKey<ShakeWidgetState>();
  final lNameKey = GlobalKey<ShakeWidgetState>();
  final emailKey = GlobalKey<ShakeWidgetState>();
  final phoneKey = GlobalKey<ShakeWidgetState>();
  final addressKey = GlobalKey<ShakeWidgetState>();
  final checkInKey = GlobalKey<ShakeWidgetState>();
  final checkOutKey = GlobalKey<ShakeWidgetState>();
  final countryKey = GlobalKey<ShakeWidgetState>();

  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;
  late PropertyProvider _provider;
  bool isCheckInSelected = false;
  bool isCheckOutSelected = false;

  bool hasPay = false;

  BookApartmentModel bookApartmentModel = BookApartmentModel();

  int _activePage = 0;

  DateTime selectDateIn = DateTime.now();
  String checkInDate = "Check in Date";
  Future<void> _selectDateIn(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectDateIn,
        firstDate: DateTime(2023),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectDateIn) {
      DateFormat formatter = DateFormat('yyyy-MM-dd');
      setState(() {
        selectDateIn = picked;
        checkInDate = formatter.format(selectDateIn);
        isCheckInSelected = true;
      });
    }
  }

  DateTime selectDateOut = DateTime.now();
  String checkOutDate = "Check out Date";
  Future<void> _selectDateOut(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectDateIn,
        firstDate: selectDateIn,
        lastDate: DateTime(2101));
    if (picked != null && picked != selectDateOut) {
      DateFormat formatter = DateFormat('yyyy-MM-dd');
      setState(() {
        selectDateOut = picked;
        checkOutDate = formatter.format(selectDateOut);
        isCheckOutSelected = true;
      });
    }
  }

  final payStackPlugin = PaystackPlugin();

  int totalDays = 0;

  List<int> _pageNumber = <int>[1, 2, 3];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _provider = context.provideOnce<PropertyProvider>();
    payStackPlugin.initialize(publicKey: UrlConfig.payStackPublicKey);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        backgroundColor: Pallet.lightCream,
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
            text: "Reservations",
            textStyle: body1TextStyle.copyWith(
              fontSize: setSp(20),
              fontWeight: FontWeight.w600,
              color: Pallet.white,
            ),
          ),
        ),
        body: Column(
          children: [
            SizedBox(height: 48.h),
            SizedBox(
              width: getWidth(context),
              height: 20,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Container(
                        width: 120.w,
                        height: 2.h,
                        decoration: ShapeDecoration(
                            color: Pallet.lightGrey,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r),
                            )),
                      ),
                    ),
                  ),
                  Positioned(
                    top: -18,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ...List.generate(
                            _pageNumber.length,
                            (index) => Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: setWidth(12)),
                              child: Container(
                                width: 36.w,
                                height: 36.w,
                                decoration: ShapeDecoration(
                                  color: _activePage == index
                                      ? Pallet.primaryColor
                                      : Pallet.lightGrey,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100.r),
                                  ),
                                ),
                                child: Center(
                                  child: TextView(
                                    text: "${_pageNumber[index]}",
                                    textStyle: body1TextStyle.copyWith(
                                      fontSize: setSp(18),
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 16.h),

            Expanded(
              child: PageView(
                physics: NeverScrollableScrollPhysics(),
                controller: _pageController,
                onPageChanged: (index) {
                  _activePage = index;
                  setState(() {});
                },
                children: [
                  ListView(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    children: [
                      CheckOutRegistration(
                        firstNameController: firstNameController,
                        lastNameController: lastNameController,
                        emailController: emailController,
                        addressController: addressController,
                        checkInDate: checkInDate,
                        checkOutDate: checkOutDate,
                        countryController: countryController,
                        referralController: referralController,
                        phoneNumberController: phoneNumberController,
                        onCheckInDateTap: () => _selectDateIn(context),
                        onCheckOutDateTap: () => _selectDateOut(context),
                        isCheckInDateSelected: isCheckInSelected,
                        isCheckOutDateSelected: isCheckOutSelected,
                        firstNameKey: fNameKey,
                        lastNameKey: lNameKey,
                        emailKey: emailKey,
                        phoneNumberKey: phoneKey,
                        addressKey: addressKey,
                        checkInDateKey: checkInKey,
                        checkOutDateKey: checkOutKey,
                        countryKey: countryKey,
                      ),
                    ],
                  ),

                  ListView(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    children: [
                      Checkout(
                        roomPropertyModel: widget.roomPropertyModel,
                        bookApartmentModel: bookApartmentModel,
                      ),
                    ],
                  ),

                  ListView(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    children: [
                      CheckOutPayment(
                        formKey: _formKey,
                        autoValidateMode: _autoValidateMode,
                        cardNumberController: cardNumberController,
                        expiryDateController: expiryDateController,
                        cvvController: cvvController,
                        cardNameController: cardNameController,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if(_activePage != 0)TextButton(
                    onPressed: (){
                      goToPreviousPageView();
                    },
                    child: TextView(
                      text: "Back",
                      textStyle: buttonTextStyle.copyWith(color: Pallet.blue, fontSize: 14.sp, decoration: TextDecoration.underline),
                    ),
                  ),

                  SizedBox(),

                  CustomButtonWidget(
                    buttonText: _activePage == 0
                        ? "Continue"
                        : _activePage == 1
                        ? "Continue"
                        : "Complete",
                    width: 0.3.sw,
                    height: 46.h,
                    buttonColor: Pallet.primaryColor,
                    buttonTextStyle: body1TextStyle.copyWith(
                      color: Pallet.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                    ),
                    onTap: () {
                      bool _isNotFilled = isButtonDisabled();
                      if (_isNotFilled) return;
                      onTap(context);
                    },
                  ),
                ],
              ),
            ),

            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }

  goToPreviousPageView() {
    if (_activePage == 0) return;

    _pageController.previousPage(
      duration: Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }

  onTap(BuildContext context) async {
    if (_activePage == 1) {
      //openPaymentSheet();
      // _pageController.nextPage(
      //   duration: Duration(milliseconds: 500),
      //   curve: Curves.ease,
      // );

      var result = await _provider.initPayment(context: context, email: emailController.text, amount: (bookApartmentModel.transactionAmount * 100).ceil());
      if(result.error) return;
      PageRouter.gotoWidget(PaymentScreen(bookApartmentModel: bookApartmentModel), context);
    } else if (_activePage == 0) {
      bookApartmentModel.property = widget.roomPropertyModel.id;
      //Implement this when you add the date and time picker, it should be date
      //Example 2024-01-03
      bookApartmentModel.checkinDate = checkInDate;
      bookApartmentModel.checkoutDate = checkOutDate;
      bookApartmentModel.firstName = firstNameController.text;
      bookApartmentModel.lastName = lastNameController.text;
      bookApartmentModel.email = emailController.text;
      bookApartmentModel.address = addressController.text;
      bookApartmentModel.country = countryController.text;
      bookApartmentModel.phoneNumber = phoneNumberController.text;
      bookApartmentModel.referralCode = referralController.text;
      totalDays = (selectDateOut.difference(selectDateIn).inDays).abs();
      num amount = widget.roomPropertyModel.amount;
      num cautionFee = widget.roomPropertyModel.cautionFee;
      bookApartmentModel.transactionAmount = (totalDays * amount) + cautionFee;

      var status = await _provider.checkAvailability(
          context: context, bookApartmentModel: bookApartmentModel);
      if (status.error) return;
      if(referralController.text.isNotEmpty && _provider.referralModel != null){
        num amount = widget.roomPropertyModel.amount;
        num discount = widget.roomPropertyModel.amount * (_provider.referralModel?.discount / 100);
        num cautionFee = widget.roomPropertyModel.cautionFee;
        bookApartmentModel.discountAmount = discount;
        bookApartmentModel.transactionAmount = (totalDays * amount) - discount + cautionFee;
      }
      _pageController.nextPage(
        duration: Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    } else {
      /*if (hasPay) {
        _goToSuccess();
      } else {
        startChargingCard();
      }*/
    }
    setState(() {});
  }

  bool isButtonDisabled() {
    if(firstNameController.text.isEmpty){
      fNameKey.currentState?.shake();
      return true;
    }
    if(lastNameController.text.isEmpty){
      lNameKey.currentState?.shake();
      return true;
    }
    if(emailController.text.isEmpty){
      emailKey.currentState?.shake();
      return true;
    }
    if(phoneNumberController.text.isEmpty){
      phoneKey.currentState?.shake();
      return true;
    }
    if(addressController.text.isEmpty){
      addressKey.currentState?.shake();
      return true;
    }
    if(checkInDate.isEmpty){
      checkInKey.currentState?.shake();
      return true;
    }
    if(checkOutDate.isEmpty){
      checkOutKey.currentState?.shake();
      return true;
    }
    if(countryController.text.isEmpty){
      countryKey.currentState?.shake();
      return true;
    }
    return false;
  }

  String _getReference() {
    String platform;
    if (Platform.isIOS) {
      platform = 'iOS';
    } else {
      platform = 'Android';
    }
    return 'ChargedFrom${platform}_${DateTime.now().millisecondsSinceEpoch}';
  }

  PaymentCard _getCardFromUI() {
    return PaymentCard(
      number: PayCard.CardUtils.getCleanedNumber(cardNumberController.text),
      cvc: PayCard.CardUtils.getCleanedNumber(cvvController.text),
      expiryMonth: PayCard.CardUtils.getExpiryDate(
          expiryDateController.text.toString())[0],
      expiryYear: PayCard.CardUtils.getExpiryDate(
          expiryDateController.text.toString())[1],
    );
  }

  void _validateInputs() {
    final FormState form = _formKey.currentState!;
    if (!form.validate()) {
      setState(() {
        _autoValidateMode =
            AutovalidateMode.always; // Start validating on every change.
      });
      AppDialog.showErrorDialog(context,
          message: 'Please fix the errors in red before submitting.',
          onContinue: () {
        PageRouter.goBack(context);
      });
    } else {
      context.closeKeyboard();
      form.save();
      startChargingCard();
      // Encrypt and send send payment details to payment gateway
      // onTap();
    }
  }

  void openPaymentSheet() {
    BottomSheets.showSheet(
      context,
      child: PaymentOptionSheet(
        onTapWithTransfer: () {
          PageRouter.gotoWidget(
            PayWithTransferScreen(
              onCompleted: (receipt) {
                bookApartmentModel.isTransfer = true;
                bookApartmentModel.receipt = receipt;
                _goToSuccess();
              },
            ),
            context,
          );
        },
        onTapWithCard: () {
          _pageController.nextPage(
            duration: Duration(milliseconds: 500),
            curve: Curves.ease,
          );
          PageRouter.goBack(context);
        },
      ),
    );
  }

  startChargingCard() {
    num amount = widget.roomPropertyModel.amount;
    num cautionFee = widget.roomPropertyModel.cautionFee;
    Charge charge = Charge();
    charge.card = _getCardFromUI();
    charge
      ..amount = (((totalDays * amount) + cautionFee) * 100).ceil()
      ..email = '${bookApartmentModel.email}'
      ..reference = _getReference()
      ..putCustomField('Charged From', 'IMSmart');
    _chargeCard(charge);
  }

  _chargeCard(Charge charge) async {
    CheckoutResponse response = await payStackPlugin.checkout(
      context,
      method: CheckoutMethod.card,
      charge: charge,
      fullscreen: false,
      logo: ImageLoader(
        // TODO
        path: AppAssets.visa,
      ),
    );

    final reference = response.reference;
    // Checking if the transaction is successful
    if (response.status) {
      hasPay = true;
      print(response);
      num amount = widget.roomPropertyModel.amount;
      num cautionFee = widget.roomPropertyModel.cautionFee;
      bookApartmentModel.transactionAmount = (totalDays * amount) + cautionFee;
      bookApartmentModel.transactionRef = reference;
      _goToSuccess();
    }
    // The transaction failed. Checking if we should verify the transaction
    if (response.verify) {
      // _verifyOnServer(reference);
    } else {
      // _updateStatus(reference, response.message);
    }
  }

  _goToSuccess() async {
    var result = await _provider.bookApartment(
        context: context, bookApartmentModel: bookApartmentModel);
    if (result.error) return;
    PageRouter.gotoWidget(
        ReservationSuccessfulScreen(
          roomPropertyModel: widget.roomPropertyModel,
          bookApartmentModel: bookApartmentModel,
        ),
        context,
        clearStack: true);
  }
}
