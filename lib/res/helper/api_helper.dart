// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:win4cash/model/Slider_model.dart';
import 'package:win4cash/model/aboutus_model.dart';
import 'package:win4cash/model/addaccount_view_model.dart';
import 'package:win4cash/model/beginner_model.dart';
import 'package:win4cash/model/coin_model.dart';
import 'package:win4cash/model/colorprediction_model.dart';
import 'package:win4cash/model/deposit_model.dart';
import 'package:win4cash/model/howtoplay_model.dart';
import 'package:win4cash/model/mlm_model.dart';
import 'package:win4cash/model/notification_model.dart';
import 'package:win4cash/model/promotion_count_model.dart';
import 'package:win4cash/model/termsconditionModel.dart';
import 'package:win4cash/model/user_model.dart';
import 'package:win4cash/model/user_profile_model.dart';
import 'package:win4cash/model/wallet_model.dart';
import 'package:win4cash/model/withdrawhistory_model.dart';
import 'package:win4cash/res/api_urls.dart';
import 'package:win4cash/res/provider/mlm_provider.dart';
import 'package:win4cash/res/provider/user_view_provider.dart';
import 'package:http/http.dart' as http;
import 'package:win4cash/utils/routes/routes_name.dart';

class BaseApiHelper {
  /// get profile
  UserViewProvider userProvider = UserViewProvider();

  Future<UserProfile> fetchProfileData() async {
    // Get user ID
    UserModel user = await userProvider.getUser();
    String token = user.id.toString();

    try {
      final response = await http.get(Uri.parse(ApiUrl.profile + token))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final jsonMap = json.decode(response.body);

        return UserProfile.fromJson(jsonMap);
      }
      // else if (response.statusCode == 401) {
      //  return Navigator.pushNamed(context, RoutesName.loginScreen);
      // }
      else {
        // Other error, throw an exception
        throw Exception('Failed to load user data');
      }
    } on SocketException {
      throw Exception('No Internet connection');
    }
  }




  ///slider
  Future<List<SliderModel>> fetchSliderData() async {
    try {
      final response = await http
          .get(Uri.parse(ApiUrl.banner))
          .timeout(const Duration(seconds: 10));
      print(ApiUrl.banner);
      print("ApiUrl.banner");
      print(response);
      print("response");

      // final Map<String, dynamic> data = json.decode(response.body);

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body)['data'];
        print(jsonList);
        print("jsonList");

        List<SliderModel> sliderList =
            jsonList.map((jsonMap) => SliderModel.fromJson(jsonMap)).toList();
        return sliderList;
      } else {
        throw Exception('Failed to load slider data');
      }
    } on SocketException {
      throw Exception('No Internet connection');
    }
  }


  /// promotioncount

  Future<PromotionCountModel?> fetchPromtionCount() async {
    //get id
    UserModel user = await userProvider.getUser();
    String token = user.id.toString();

    try {
      final response = await http
          .get(
            Uri.parse(ApiUrl.promotionCount + token),
          )
          .timeout(const Duration(seconds: 10));
      print(ApiUrl.promotionCount + token);
      print("ApiUrl.promotionCount + token");
      print(response);
      print("response");

      if (response.statusCode == 200) {
        final jsonMap = json.decode(response.body);
        print(jsonMap);
        print("jsonMap");

        return PromotionCountModel.fromJson(jsonMap);
      } else {
        throw Exception('Failed to load user data');
      }
    } on SocketException {
      throw Exception('No Internet connection');
    }
  }

  ///deposithistory

  Future<List<DepositModel>?> fetchDepositHistoryData() async {
    UserModel user = await userProvider.getUser();
    String token = user.id.toString();

    try {
      final response = await http.get(Uri.parse(ApiUrl.depositHistory+token)).timeout(const Duration(seconds: 10));
      print(ApiUrl.depositHistory + token);
      print("ApiUrl.depositHistory");
      print(response);
      print("response deposit");

      // final Map<String, dynamic> data = json.decode(response.body)['data'];

      if (response.statusCode == 200) {
        final jsonList = json.decode(response.body);
        if (jsonList['status'] == "200") {
          final List<dynamic> data = json.decode(response.body)['data'];
          List<DepositModel> depositList = data.map((jsonMap) => DepositModel.fromJson(jsonMap)).toList();
          return depositList;
        } else {
          print("else");
          return null;
        }
      }
      // else if(response.statusCode == 400){
      //   final jsonList = json.decode(response.body)['data'];
      //   print(jsonList);
      //   print("jsonList null");
      //
      //   if (jsonList != null) {
      //     List<DepositModel> depositList = jsonList.map((jsonMap) => DepositModel.fromJson(jsonMap)).toList();
      //     return depositList;
      //   } else {
      //     return [];
      //   }
      // }
      else {
        throw Exception('Failed to load data');
      }
    } on SocketException {
      throw Exception('No Internet connection');
    }
  }

  ///withdrawHistory

  Future<List<WithdrawModel>?> fetchWithdrawHistoryData() async {
    UserModel user = await userProvider.getUser();
    String token = user.id.toString();

    try {
      final response = await http.get(Uri.parse(ApiUrl.withdrawHistory)).timeout(const Duration(seconds: 10));
      print(ApiUrl.withdrawHistory+token);
      print("ApiUrl.withdrawHistory");
      print(response);
      print("response withdraw");

      // final Map<String, dynamic> data = json.decode(response.body)['data'];

      if (response.statusCode == 200) {
        final jsonList = json.decode(response.body);
        if (jsonList['status'] == "200") {
          final List<dynamic> data = json.decode(response.body)['data'];
          List<WithdrawModel> withdrawlist = data.map((jsonMap) => WithdrawModel.fromJson(jsonMap)).toList();
          return withdrawlist;
        } else {
          print("else");
          return null;
        }
      }
      else {
        throw Exception('Failed to load data');
      }
    } on SocketException {
      throw Exception('No Internet connection');
    }
  }

  ///about us
  Future<AboutusModel?> fetchaboutusData() async {
    try {
      final response = await http.get(Uri.parse(ApiUrl.aboutus)).timeout(const Duration(seconds: 10));
      print(ApiUrl.aboutus);
      print("response");

      if (response.statusCode == 200) {
        final jsonMap = json.decode(response.body)['data'];
        print(jsonMap);
        print("jsonMap");

        return AboutusModel.fromJson(jsonMap);
      } else {
        throw Exception('Failed to load user data');
      }
    } on SocketException {
      throw Exception('No Internet connection');
    }
  }

  ///termscondition

  Future<TcModel?> fetchdataTC() async {
    try {
      final response = await http.get(Uri.parse(ApiUrl.termscon)).timeout(const Duration(seconds: 10));
      print(ApiUrl.aboutus);
      print("response");

      if (response.statusCode == 200) {
        final jsonMap = json.decode(response.body)['data'][0];
        print(jsonMap);
        print("jsonMap");

        return TcModel.fromJson(jsonMap);
      } else {
        throw Exception('Failed to load user data');
      }
    } on SocketException {
      throw Exception('No Internet connection');
    }
  }

  ///privacy policy

  Future<TcModel?> fetchdataPP() async {
    try {
      final response = await http.get(Uri.parse(ApiUrl.privacypolicy)).timeout(const Duration(seconds: 10));
      print(ApiUrl.privacypolicy);
      print("response privacypolicy");

      if (response.statusCode == 200) {
        final jsonMap = json.decode(response.body)['data'];
        print(jsonMap);
        print("jsonMap");

        return TcModel.fromJson(jsonMap);
      } else {
        throw Exception('Failed to load user data');
      }
    } on SocketException {
      throw Exception('No Internet connection');
    }
  }

  ///contact us

  Future<TcModel?> fetchdataCU() async {
    try {
      final response = await http.get(Uri.parse(ApiUrl.contact)).timeout(const Duration(seconds: 10));
      print(ApiUrl.contact);
      print("response contact");

      if (response.statusCode == 200) {
        final jsonMap = json.decode(response.body)['data'][0];
        print(jsonMap);
        print("jsonMap");

        return TcModel.fromJson(jsonMap);
      } else {
        throw Exception('Failed to load user data');
      }
    } on SocketException {
      throw Exception('No Internet connection');
    }
  }





  Future<WalletModel?> fetchWalletData() async {
    //get id
    UserModel user = await userProvider.getUser();
    String token = user.id.toString();

    try {
      final response = await http.get(Uri.parse(ApiUrl.walletdash+token),).timeout(const Duration(seconds: 10));
      print(ApiUrl.walletdash + token);
      print("response walletdash");

      if (response.statusCode == 200) {
        final jsonMap = json.decode(response.body)['data'][0];
        print(jsonMap);
        print("jsonMap");

        return WalletModel.fromJson(jsonMap);
      } else {
        throw Exception('Failed to load user data');
      }
    } on SocketException {
      throw Exception('No Internet connection');
    }
  }





  ///how to play

  Future<HowtoplayModel?> fetchHowtoplayData() async {
    UserModel user = await userProvider.getUser();
    String token = user.id.toString();
    try {
      final response = await http.get(Uri.parse('${ApiUrl.HowtoplayApi}2')).timeout(const Duration(seconds: 10));
      print(ApiUrl.HowtoplayApi);
      print("response HowtoplayApi");

      if (response.statusCode == 200) {
        final jsonMap = json.decode(response.body)['data'][0];
        print(jsonMap);
        print("jsonMap");

        return HowtoplayModel.fromJson(jsonMap);
      } else {
        throw Exception('Failed to load user data');
      }
    } on SocketException {
      throw Exception('No Internet connection');
    }
  }

  ///beginnerguide

  Future<BeginnerModel?> fetchBeginnerData() async {
    try {
      final response = await http.get(Uri.parse(ApiUrl.beginnerapi)).timeout(const Duration(seconds: 10));
      print(ApiUrl.beginnerapi);
      print("response");

      if (response.statusCode == 200) {
        final jsonMap = json.decode(response.body)['data'][0];
        print(jsonMap);
        print("jsonMap");

        return BeginnerModel.fromJson(jsonMap);
      } else {
        throw Exception('Failed to load user data');
      }
    } on SocketException {
      throw Exception('No Internet connection');
    }
  }


  ///notification

  Future<NotificationModel?> fetchNotificationData() async {
    try {
      final response = await http.get(Uri.parse(ApiUrl.notificationapi)).timeout(const Duration(seconds: 10));
      print(ApiUrl.notificationapi);
      print("response NotificationModel");

      if (response.statusCode == 200) {
        final jsonMap = json.decode(response.body)['data'];
        print(jsonMap);
        print("jsonMap");

        return NotificationModel.fromJson(jsonMap);
      } else {
        throw Exception('Failed to load user data');
      }
    } on SocketException {
      throw Exception('No Internet connection');
    }
  }

  ///coins

  Future<List<CoinModel>?> fetchCoinsData() async {

    // UserModel user = await userProvider.getUser();
    // String token = user.id.toString();

    try {
      final response = await http.get(Uri.parse(ApiUrl.coinsapi)).timeout(const Duration(seconds: 10));
      print(ApiUrl.coinsapi);
      print("ApiUrl.coinsapi");
      print(response);
      print("response ApiUrl.coinsapi");

      // final Map<String, dynamic> data = json.decode(response.body)['data'];

      if (response.statusCode == 200) {
        final jsonList = json.decode(response.body);
        if (jsonList['status'] == "200") {
          final List<dynamic> data = json.decode(response.body)['data'];
          List<CoinModel> coinlist = data.map((jsonMap) => CoinModel.fromJson(jsonMap)).toList();
          return coinlist;
        } else {
          print("else");
          return null;
        }
      }
      else {
        throw Exception('Failed to load data');
      }
    } on SocketException {
      throw Exception('No Internet connection');
    }
  }


  ///color prediction




}

