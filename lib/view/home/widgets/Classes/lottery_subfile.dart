import 'package:flutter/foundation.dart';

class PopularLottery {
  final String image;
  final String name;
  final VoidCallback? onTap;
  PopularLottery({required this.image,required this.name, this.onTap});
}