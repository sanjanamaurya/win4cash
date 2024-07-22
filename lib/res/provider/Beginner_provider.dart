import 'package:win4cash/model/aboutus_model.dart';
import 'package:win4cash/model/beginner_model.dart';
import 'package:flutter/material.dart';


class BeginnerProvider with ChangeNotifier {
  BeginnerModel? _BeginnerData;

  BeginnerModel? get BeginnerData => _BeginnerData;

  void setbeginner(BeginnerModel begdata) {
    _BeginnerData = begdata;
    notifyListeners();
  }
}