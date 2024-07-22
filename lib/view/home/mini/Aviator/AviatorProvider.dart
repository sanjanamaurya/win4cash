import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:win4cash/model/user_model.dart';
import 'package:win4cash/model/user_profile_model.dart';
import 'package:win4cash/res/api_urls.dart';
import 'package:win4cash/res/provider/user_view_provider.dart';


// var wallet;
class AviatorWallet with ChangeNotifier {
  double _fixedbalance=0;
  double _balance=0;
  double get fixed => _fixedbalance;
  double get balance => _balance;



  void updateBal(double value) {
    _balance = _fixedbalance-value;
    notifyListeners();
  }


  wallet() async {
    //get id
    UserViewProvider userProvider = UserViewProvider();

    UserModel user = await userProvider.getUser();
    String token = user.id.toString();
print(token);
print("token");

    try {
      final response = await http.get(Uri.parse(ApiUrl.profile + token))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        print("chala");
        final jsonMap = json.decode(response.body);
        _fixedbalance=double.parse(jsonMap['total_wallet'].toString());
        _balance=_fixedbalance;
        print(_fixedbalance);
        print('eeeeeeeeeeeee');
        return UserProfile.fromJson(jsonMap);

      } else if (response.statusCode == 401) {
        // Unauthorized, return null or throw error
        return null;
      } else {
        // Other error, throw an exception
        throw Exception('Failed to load user data');
      }
    } on SocketException {
      throw Exception('No Internet connection');
    }
  }
}