
import 'package:flutter/material.dart';

import 'package:win4cash/res/aap_colors.dart';
import 'package:win4cash/res/components/app_bar.dart';
import 'package:win4cash/res/components/text_widget.dart';
import 'package:win4cash/view/account/all_bet_history/wingoallhistory.dart';

class MyHistoryDetails extends StatefulWidget {
  const MyHistoryDetails({super.key});

  @override
  State<MyHistoryDetails> createState() => _MyHistoryDetailsState();
}

class _MyHistoryDetailsState extends State<MyHistoryDetails> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffolddark,
      appBar: GradientAppBar(
          leading: Padding(
            padding: const EdgeInsets.fromLTRB(15, 5, 5, 5),
            child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back_ios_new_sharp,
                  color: Colors.white,
                )),
          ),
          centerTitle: true,
          title: textWidget(
            text: 'Win Go',
            fontWeight: FontWeight.w900,
            fontSize: 20,
            color: AppColors.primaryTextColor,),
          gradient: AppColors.primaryUnselectedGradient),
      body: const WingoAllHistory(),
    );
  }
}

