import 'package:win4cash/model/wallet_model.dart';
import 'package:flutter/material.dart';


class WalletProvider with ChangeNotifier {

  WalletModel? _walletList;

  WalletModel? get walletlist => _walletList;

  void setWalletList(WalletModel walletss) {
    _walletList = walletss;
    notifyListeners();
  }
}
