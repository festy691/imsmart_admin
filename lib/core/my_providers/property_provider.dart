import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:imsmart_admin/core/services/property_service.dart';
import 'package:imsmart_admin/core/utils/blink_dialog.dart';
import 'package:imsmart_admin/core/utils/page_router.dart';
import 'package:imsmart_admin/core/widget/dialogs.dart';
import 'package:imsmart_admin/models/api_response.dart';
import 'package:imsmart_admin/models/book_apartment_model.dart';
import 'package:imsmart_admin/models/city_model.dart';
import 'package:imsmart_admin/models/payment_init_model.dart';
import 'package:imsmart_admin/models/referral_model.dart';
import 'package:imsmart_admin/models/room_property_model.dart';
import 'package:imsmart_admin/models/transaction_model.dart';

class PropertyProvider with ChangeNotifier {
  PropertyService _propertyService;
  PropertyProvider(PropertyService propertyService)
      : _propertyService = propertyService;

  final _loadingKey = GlobalKey<State>();

  List<RoomPropertyModel> apartments = [];
  List<RoomPropertyModel> topRated = [];
  RoomPropertyModel? propertyModel;
  List<CityModel> cities = [];
  CityModel? city;
  List<BookApartmentModel> bookings = [];

  List<TransactionModel> transactions = [];

  PaymentInitModel? paymentInitModel;
  ReferralModel? referralModel;

  void setApartmentList(List<RoomPropertyModel> list) {
    apartments = list;
    notifyListeners();
  }

  void setTopList(List<RoomPropertyModel> list) {
    topRated = list;
    notifyListeners();
  }

  void setCityList(List<CityModel> list) {
    cities = list;
    notifyListeners();
  }

  void setBookingList(List<BookApartmentModel> list) {
    bookings = list;
    notifyListeners();
  }

  void setTransactionList(List<TransactionModel> list) {
    transactions = list;
    notifyListeners();
  }

  Future<APIResponse> loadTransactions({
      required BuildContext context,
      bool load = false,
      int page = 1,
      int limit = 20,
      }) async {
    try {
      if (load) {
        LoadingDialog.showLoading(context, _loadingKey);
      }
      APIResponse result = await _propertyService.getTransactions(page: page, limit: limit);
      if (!result.error) {
        List<TransactionModel> _list = [];
        for (var c in result.data["docs"]) {
          TransactionModel model = TransactionModel.fromJson(c);
          _list.add(model);
        }
        if(page > 1){
          transactions.addAll(_list);
          setTransactionList(transactions);
        } else {
          setTransactionList(_list);
        }
      }
      if (load) {
        LoadingDialog.hideLoading(_loadingKey);
      }
      return result;
    } catch (e, s) {
      if (load) {
        LoadingDialog.hideLoading(_loadingKey);
      }
      return APIResponse(error: true, message: e.toString());
    }
  }

  Future<APIResponse> loadAllApartments(
      {required BuildContext context,
      bool load = false,
      int page = 1,
      int limit = 20,
      String cityId = ""
      }) async {
    try {
      if (load) {
        LoadingDialog.showLoading(context, _loadingKey);
      }
      APIResponse result =
          await _propertyService.getProperties(cityId: cityId, page: page, limit: limit);
      if (!result.error) {
        List<RoomPropertyModel> _list = [];
        for (var c in result.data["docs"]) {
          RoomPropertyModel model = RoomPropertyModel.fromJson(c);
          _list.add(model);
        }
        setApartmentList(_list);
      }
      if (load) {
        LoadingDialog.hideLoading(_loadingKey);
      }
      return result;
    } catch (e, s) {
      if (load) {
        LoadingDialog.hideLoading(_loadingKey);
      }
      return APIResponse(error: true, message: e.toString());
    }
  }

  Future<APIResponse> loadTopApartments(
      {required BuildContext context,
      bool load = false,
      int page = 1,
      int limit = 10,
      }) async {
    try {
      if (load) {
        LoadingDialog.showLoading(context, _loadingKey);
      }
      APIResponse result =
          await _propertyService.getProperties(cityId: "", page: page, limit: limit);
      if (!result.error) {
        List<RoomPropertyModel> _list = [];
        for (var c in result.data["docs"]) {
          RoomPropertyModel model = RoomPropertyModel.fromJson(c);
          _list.add(model);
        }
        setTopList(_list);
      }
      if (load) {
        LoadingDialog.hideLoading(_loadingKey);
      }
      return result;
    } catch (e, s) {
      if (load) {
        LoadingDialog.hideLoading(_loadingKey);
      }
      return APIResponse(error: true, message: e.toString());
    }
  }

  Future<APIResponse> loadAllCities(
      {required BuildContext context,
      bool load = false,
      int page = 1,
      int limit = 20,
      }) async {
    try {
      if (load) {
        LoadingDialog.showLoading(context, _loadingKey);
      }
      APIResponse result =
          await _propertyService.getCities(page: page, limit: limit);
      if (!result.error) {
        List<CityModel> _list = [];
        for (var c in result.data["docs"]) {
          CityModel model = CityModel.fromJson(c);
          _list.add(model);
        }
        setCityList(_list);
      }
      if (load) {
        LoadingDialog.hideLoading(_loadingKey);
      }
      return result;
    } catch (e, s) {
      if (load) {
        LoadingDialog.hideLoading(_loadingKey);
      }
      return APIResponse(error: true, message: e.toString());
    }
  }

  Future<APIResponse> loadSingleApartment(
      {required BuildContext context,
      bool load = false,
      required String propertyId
      }) async {
    try {
      if (load) {
        LoadingDialog.showLoading(context, _loadingKey);
      }
      APIResponse result =
          await _propertyService.getSingleProperty(propertyId: propertyId);
      if (!result.error) {
        RoomPropertyModel model = RoomPropertyModel.fromJson(result.data);
        propertyModel = model;
        notifyListeners();
      }
      if (load) {
        LoadingDialog.hideLoading(_loadingKey);
      }
      return result;
    } catch (e, s) {
      if (load) {
        LoadingDialog.hideLoading(_loadingKey);
      }
      return APIResponse(error: true, message: e.toString());
    }
  }

  Future<APIResponse> loadSingleCity(
      {required BuildContext context,
      bool load = false,
      required String cityId
      }) async {
    try {
      if (load) {
        LoadingDialog.showLoading(context, _loadingKey);
      }
      APIResponse result =
          await _propertyService.getSingleCity(cityId: cityId);
      if (!result.error) {
        CityModel model = CityModel.fromJson(result.data);
        city = model;
        notifyListeners();
      }
      if (load) {
        LoadingDialog.hideLoading(_loadingKey);
      }
      return result;
    } catch (e, s) {
      if (load) {
        LoadingDialog.hideLoading(_loadingKey);
      }
      return APIResponse(error: true, message: e.toString());
    }
  }

  Future<APIResponse> checkReferral(
      {required BuildContext context,
      bool load = false,
      required String referralCode
      }) async {
    try {
      if (load) {
        LoadingDialog.showLoading(context, _loadingKey);
      }
      APIResponse result =
          await _propertyService.checkReferralCode(referralCode: referralCode);
      if (!result.error) {
        ReferralModel model = ReferralModel.fromJson(result.data);
        referralModel = model;
        notifyListeners();
      }
      if (load) {
        LoadingDialog.hideLoading(_loadingKey);
      }
      return result;
    } catch (e, s) {
      if (load) {
        LoadingDialog.hideLoading(_loadingKey);
      }
      return APIResponse(error: true, message: e.toString());
    }
  }

  Future<APIResponse> loadAllBookings(
      {required BuildContext context,
      bool load = false,
      required String propertyId}) async {
    try {
      if (load) {
        LoadingDialog.showLoading(context, _loadingKey);
      }
      APIResponse result =
          await _propertyService.getBookings(propertyId: propertyId);
      if (!result.error) {
        List<BookApartmentModel> _list = [];
        for (var c in result.data) {
          BookApartmentModel model = BookApartmentModel.fromJson(c);
          _list.add(model);
        }
        setBookingList(_list);
      }
      if (load) {
        LoadingDialog.hideLoading(_loadingKey);
      }
      return result;
    } catch (e, s) {
      if (load) {
        LoadingDialog.hideLoading(_loadingKey);
      }
      return APIResponse(error: true, message: e.toString());
    }
  }

  Future<APIResponse> initPayment({
    required BuildContext context,
    required String email,
    required int amount
  }) async {
    try {
      LoadingDialog.showLoading(context, _loadingKey);
      APIResponse result = await _propertyService.initiatePayment(email: email, amount: amount);
      if(!result.error){
        paymentInitModel = PaymentInitModel.fromJson(result.data);
        notifyListeners();
      }
      LoadingDialog.hideLoading(_loadingKey);
      return result;
    } catch (e, stackTrace) {
      LoadingDialog.hideLoading(_loadingKey);
      AppDialog.showErrorDialog(context, message: e.toString(), onContinue: () {
        PageRouter.goBack(context);
      });
      return APIResponse(error: true, message: e.toString());
    }
  }

  Future<APIResponse> checkAvailability({
    required BuildContext context,
    required BookApartmentModel bookApartmentModel,
  }) async {
    try {
      LoadingDialog.showLoading(context, _loadingKey);
      APIResponse result = await _propertyService.checkPropertyAvailability(
          bookModel: bookApartmentModel);
      if(!result.error && bookApartmentModel.referralCode.toString().isNotEmpty){
        await checkReferral(context: context, referralCode: bookApartmentModel.referralCode);
      }
      LoadingDialog.hideLoading(_loadingKey);
      return result;
    } catch (e, stackTrace) {
      LoadingDialog.hideLoading(_loadingKey);
      AppDialog.showErrorDialog(context, message: e.toString(), onContinue: () {
        PageRouter.goBack(context);
      });
      return APIResponse(error: true, message: e.toString());
    }
  }

  Future<APIResponse> updateProperty({
    required BuildContext context,
    required String propertyId,
    required RoomPropertyModel propertyModel,
  }) async {
    try {
      LoadingDialog.showLoading(context, _loadingKey);
      APIResponse result =
          await _propertyService.updateProperty(propertyId: propertyId, propertyModel: propertyModel);
      LoadingDialog.hideLoading(_loadingKey);
      return result;
    } catch (e, stackTrace) {
      LoadingDialog.hideLoading(_loadingKey);
      AppDialog.showErrorDialog(context, message: e.toString(), onContinue: () {
        PageRouter.goBack(context);
      });
      return APIResponse(error: true, message: e.toString());
    }
  }

  Future<APIResponse> bookApartment({
    required BuildContext context,
    required BookApartmentModel bookApartmentModel,
  }) async {
    try {
      LoadingDialog.showLoading(context, _loadingKey);
      APIResponse result =
          await _propertyService.bookProperty(bookModel: bookApartmentModel);
      LoadingDialog.hideLoading(_loadingKey);
      return result;
    } catch (e, stackTrace) {
      LoadingDialog.hideLoading(_loadingKey);
      AppDialog.showErrorDialog(context, message: e.toString(), onContinue: () {
        PageRouter.goBack(context);
      });
      return APIResponse(error: true, message: e.toString());
    }
  }

  Future<APIResponse> uploadImage(
      {required BuildContext context,
      required File file,
      String imageType = "receipt"}) async {
    try {
      LoadingDialog.showLoading(context, _loadingKey, 'Uploading...');
      final response =
          await _propertyService.uploadImage(file, imageType: imageType);
      LoadingDialog.hideLoading(_loadingKey);
      return response;
    } catch (e, stackTrace) {
      LoadingDialog.hideLoading(_loadingKey);
      AppDialog.showErrorDialog(context, message: e.toString(), onContinue: () {
        PageRouter.goBack(context);
      });
      return APIResponse(error: true, message: e.toString());
    }
  }

  Future<void> processPayment(
    BuildContext context, {
    required String cardNumber,
    required String expiryDate,
    required String cvc,
    required String name,
    required int amount,
    required String email,
    required PaystackPlugin paystackPlugin,
  }) async {
    String reference = 'user_${name.toLowerCase().replaceAll('', '_')}';

    Charge charge = Charge()
      ..amount = amount
      ..email = email
      ..reference = reference
      ..card = PaymentCard(
        number: cardNumber,
        cvc: cvc,
        expiryMonth: int.parse(expiryDate.split('/')[0]),
        expiryYear: int.parse(expiryDate.split('/')[1]),
      );

    CheckoutResponse response = await paystackPlugin.checkout(
      context,
      charge: charge,
      method: CheckoutMethod.card,
    );

    if (response.status == true) {}
  }
}
