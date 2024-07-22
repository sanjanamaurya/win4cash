// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'package:win4cash/model/user_model.dart';
import 'package:win4cash/res/api_urls.dart';
import 'package:win4cash/res/provider/user_view_provider.dart';
import 'package:win4cash/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';


class WithdrawProvider with ChangeNotifier {

  UserViewProvider userProvider = UserViewProvider();

  bool _regLoading = false;
  bool get regLoading =>_regLoading;
  setRegLoading(bool value){
    _regLoading=value;
    notifyListeners();
  }
  Future Withdraw(context, String accountId, String amount) async {
    UserModel user = await userProvider.getUser();
    String token = user.id.toString();

    setRegLoading(true);
    final response = await http.post(
      Uri.parse(ApiUrl.withdrawl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "user_id":token,
        "account_id":accountId,
        "amount":amount

      }),
    );
    if (response.statusCode == 200) {
      print(response);
      print("responsebet");
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      print(responseData);
      print("responseData");
      setRegLoading(false);
      // final userPref = Provider.of<UserViewProvider>(context, listen: false);
      // userPref.saveUser(UserModel(id: responseData['id'].toString()));
      Navigator.pushReplacementNamed(context,  RoutesName.withdrawScreen);
      return Fluttertoast.showToast(msg: responseData['msg']);
    } else {
      setRegLoading(false);
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      return Fluttertoast.showToast(msg: responseData['msg']);
    }
  }
}