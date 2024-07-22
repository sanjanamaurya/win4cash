import 'package:flutter/material.dart';
import 'package:win4cash/res/aap_colors.dart';
import 'package:win4cash/res/components/app_bar.dart';
import 'package:win4cash/res/components/text_widget.dart';

import 'package:win4cash/view/account/all_bet_history/trx_all_history.dart';

class TRXMyHistoryDetails extends StatefulWidget {
  const TRXMyHistoryDetails({super.key});

  @override
  State<TRXMyHistoryDetails> createState() => _TRXMyHistoryDetailsState();
}

class _TRXMyHistoryDetailsState extends State<TRXMyHistoryDetails> {




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
            text: 'Trx Win Go',
            fontWeight: FontWeight.w900,
            fontSize: 20,
            color: AppColors.primaryTextColor,),
          gradient: AppColors.primaryUnselectedGradient),
      body: const TrxAllHistory(),
    );
  }

}

