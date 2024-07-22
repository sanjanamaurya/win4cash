import 'dart:convert';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:win4cash/generated/assets.dart';
import 'package:win4cash/main.dart';
import 'package:win4cash/res/aap_colors.dart';
import 'package:win4cash/res/api_urls.dart';
import 'package:http/http.dart' as http;

class GameAnuncement extends StatefulWidget {
  const GameAnuncement({super.key});

  @override
  State<GameAnuncement> createState() => _GameAnuncementState();
}

class _GameAnuncementState extends State<GameAnuncement> {
  @override
  void initState() {
    invitationRuleApi();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Container(
      height: height * 0.07,
      margin: const EdgeInsets.only(
          right: 10, left: 10, top: 5, bottom: 5),
      decoration: BoxDecoration(
          color: AppColors.filledColor,
          borderRadius: BorderRadius.circular(20)),
      child: Row(
        children: [
          Image.asset(
            Assets.iconsMicphone,
            height: 30,
          ),
          SizedBox(width: width * 0.01),
          _rotate(),
          Image.asset(
            Assets.iconsNotification,
            height: 30,
          ),
        ],
      ),
    )  ;
  }


  Widget _rotate() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        DefaultTextStyle(
          style: const TextStyle(fontSize: 12, color: Colors.white),
          child: Container(
            width: width * 0.75,
            child: AnimatedTextKit(
              repeatForever: true,
              isRepeatingAnimation: true,
              animatedTexts: invitationRuleList.isEmpty
                  ? [RotateAnimatedText("")]
                  : invitationRuleList
                  .map((rule) => RotateAnimatedText(rule))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }

  List<String> invitationRuleList = [];
  Future<void> invitationRuleApi() async {
    final response = await http.get(
      Uri.parse('${ApiUrl.allRules}6'),
    );
    if (kDebugMode) {
      print('${ApiUrl.allRules}6');
      print('allRules');
    }

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body)['data'];

      setState(() {
        invitationRuleList =
            json.decode(responseData[0]['list']).cast<String>();
      });
    } else if (response.statusCode == 400) {
      if (kDebugMode) {
        print('Data not found');
      }
    } else {
      setState(() {
        invitationRuleList = [];
      });
      throw Exception('Failed to load data');
    }
  }
}
