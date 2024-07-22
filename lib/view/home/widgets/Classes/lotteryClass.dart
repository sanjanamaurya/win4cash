import 'package:flutter/foundation.dart';

class LotteryModel {
  final String titleText;
  final String subTitleText;
  final String gameText;
  final String? member;
  final String? memberImage;
  final String decorationImage;
  final String? decoImage;
  final String? winAmount;
  final VoidCallback? onTap;
  LotteryModel(
      {required this.titleText,
        required this.subTitleText,
        required this.gameText,
        this.member,
        this.memberImage,
        required this.decorationImage,
        this.decoImage,
        this.winAmount,
        this.onTap});
}