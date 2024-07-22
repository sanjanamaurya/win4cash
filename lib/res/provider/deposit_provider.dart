import 'package:win4cash/model/deposit_model.dart';
import 'package:flutter/material.dart';


class DepositProvider with ChangeNotifier {
  List<DepositModel> _depositList = [];

  List<DepositModel> get depositlist => _depositList;

  void setDepositList(List<DepositModel> deposits) {
    _depositList = deposits;
    notifyListeners();
  }
}
