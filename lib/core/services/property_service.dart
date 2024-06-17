import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:imsmart_admin/core/network/network_service.dart';
import 'package:imsmart_admin/core/network/url_config.dart';
import 'package:imsmart_admin/core/utils/blink_dialog.dart';
import 'package:imsmart_admin/models/api_response.dart';
import 'package:imsmart_admin/models/book_apartment_model.dart';
import 'package:imsmart_admin/models/room_property_model.dart';

class PropertyService {
  NetworkService _networkService;
  PropertyService({required NetworkService networkService})
      : _networkService = networkService;

  void updateNetworkService() =>
      _networkService = NetworkService(baseUrl: UrlConfig.coreBaseUrl);

  Future<APIResponse> initiatePayment({required String email, required int amount}) async {
    try {
      var bodyData = {
        "email": email,
        "amount": amount
      };
      final response = await _networkService.call(
          UrlConfig.AUTH_URL + UrlConfig.initiatePayment, RequestMethod.post, data: bodyData);
      return APIResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<APIResponse> getProperties({String? cityId, required int page, required int limit}) async {
    try {
      final response = await _networkService.call(
          UrlConfig.AUTH_URL + UrlConfig.properties + "?city=$cityId&page=$page&limit=$limit", RequestMethod.get);
      return APIResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<APIResponse> getSingleProperty({required String propertyId}) async {
    try {
      final response = await _networkService.call(
          UrlConfig.AUTH_URL + UrlConfig.properties + "/$propertyId", RequestMethod.get);
      return APIResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<APIResponse> getCities({required int page, required int limit}) async {
    try {
      final response = await _networkService.call(
          UrlConfig.AUTH_URL + UrlConfig.cities + "?page=$page&limit=$limit", RequestMethod.get);
      return APIResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<APIResponse> getSingleCity({required String cityId}) async {
    try {
      final response = await _networkService.call(
          UrlConfig.AUTH_URL + UrlConfig.cities + "/$cityId", RequestMethod.get);
      return APIResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<APIResponse> checkReferralCode({required String referralCode}) async {
    try {
      final response = await _networkService.call(
          UrlConfig.AUTH_URL + UrlConfig.referral + "/$referralCode", RequestMethod.get);
      return APIResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<APIResponse> getBookings({required String propertyId}) async {
    try {
      final response = await _networkService.call(
          UrlConfig.AUTH_URL + UrlConfig.bookings + "/schedules/$propertyId", RequestMethod.get);
      return APIResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<APIResponse> bookProperty({required BookApartmentModel bookModel}) async {
    try {
      final response = await _networkService.call(
          UrlConfig.AUTH_URL + UrlConfig.bookings, RequestMethod.post,
          data: bookModel.toJson());
      return APIResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<APIResponse> updateProperty({required String propertyId, required RoomPropertyModel propertyModel}) async {
    try {
      final response = await _networkService.call(
          "${UrlConfig.AUTH_URL}${UrlConfig.properties}/$propertyId", RequestMethod.put,
          data: propertyModel.toJson());
      return APIResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<APIResponse> checkPropertyAvailability({required BookApartmentModel bookModel}) async {
    try {
      final response = await _networkService.call(
          UrlConfig.AUTH_URL + UrlConfig.bookings + "/availability", RequestMethod.post,
          data: bookModel.toJson());
      return APIResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<APIResponse> getTransactions({required int page, required int limit}) async {
    try {
      final response = await _networkService.call(
          '${UrlConfig.AUTH_URL}${UrlConfig.bookings}?page=$page&limit=$limit', RequestMethod.get,);
      return APIResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<APIResponse> uploadImage(File file,
      {required String imageType}) async {
    Map<String, dynamic> map = {};
    print(file.path.split("/").last);
    map['image'] = MultipartFile.fromBytes(file.readAsBytesSync(),
        filename: file.path.split("/").last);

    try {
      final response = await _networkService.call(
        '${UrlConfig.AUTH_URL}/images',
        RequestMethod.post,
        data: FormData.fromMap(map),
      );
      return APIResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

}
