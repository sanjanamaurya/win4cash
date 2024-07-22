import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:win4cash/generated/assets.dart';
import 'package:win4cash/main.dart';
import 'package:win4cash/model/user_model.dart';
import 'package:win4cash/res/aap_colors.dart';
import 'package:win4cash/res/api_urls.dart';
import 'package:win4cash/res/components/app_bar.dart';
import 'package:win4cash/res/components/app_btn.dart';
import 'package:win4cash/res/components/text_widget.dart';
import 'package:win4cash/res/helper/api_helper.dart';
import 'package:win4cash/res/provider/profile_provider.dart';
import 'package:win4cash/res/provider/user_view_provider.dart';
import 'package:win4cash/utils/routes/routes_name.dart';
import 'package:win4cash/utils/utils.dart';
import 'package:win4cash/view/wallet/deposit_history.dart';
import 'package:win4cash/view/wallet/deposit_screen.dart';
import 'package:win4cash/view/wallet/withdraw_screen.dart';
import 'package:win4cash/view/wallet/withdrawal_history.dart';
import 'package:http/http.dart' as http;

class WalletScreenNew extends StatefulWidget {
  const WalletScreenNew({super.key});

  @override
  State<WalletScreenNew> createState() => _WalletScreenNewState();
}

class _WalletScreenNewState extends State<WalletScreenNew> {
  @override
  Widget build(BuildContext context) {
    final userData = context.watch<ProfileProvider>();

    return Scaffold(
      backgroundColor: AppColors.scaffolddark,
      appBar: const GradientAppBar(
          title: Text(
            'Wallet',
            style: TextStyle(
                fontWeight: FontWeight.w900, fontSize: 25, color: Colors.white),
          ),
          centerTitle: true,
          gradient: AppColors.primaryGradient),
      body: userData!=null?
      ListView(
        children: [
          Stack(
            children: [
              Container(
                height: height * 0.25,
                width: width,
                decoration:
                    const BoxDecoration(gradient: AppColors.primaryGradient),
                child: Column(
                  children: [
                    Image.asset(
                      Assets.iconsProWallet,
                      height: 70,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.currency_rupee,
                            size: 30, color: AppColors.primaryTextColor),
                        textWidget(
                          text:context.watch<ProfileProvider>().totalWallet.toStringAsFixed(2),
                          // userData.totalWallet
                          //     .toStringAsFixed(2),
                          // double.parse(walletdetails.wallet.toString()).toStringAsFixed(2),
                          fontWeight: FontWeight.w900,
                          fontSize: 28,
                          color: AppColors.primaryTextColor,
                        ),
                        // InkWell(
                        //     onTap: (){
                        //       walletfetch();
                        //     },
                        //     child: Image.asset(Assets.iconsTotalBal,color: AppColors.browntextprimary,height: height*0.03,)),
                      ],
                    ),
                    textWidget(
                        text: 'Total Balance',
                        color: AppColors.primaryTextColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w700),
                  ],
                ),
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.only(top: height * 0.22,bottom: 30),
                  child: Container(
                    height: height * 0.62,
                    width: width * 0.9,
                    decoration: BoxDecoration(
                        color: AppColors.FirstColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            percentage(
                              //main wallet/totalbalance*0.01

                                (userData.mainWallet/(userData.totalWallet*0.01)).toStringAsFixed(2),
                                userData.mainWallet
                                    .toStringAsFixed(2),
                                'Main wallet'),
                            percentage(
                              //thirdpartywallet/totalbalance*0.01
                                (userData.thirdPartyWallet/(userData.totalWallet*0.01)).toStringAsFixed(2),
                                userData.thirdPartyWallet
                                    .toStringAsFixed(2),
                                '3rd party wallet'),
                          ],
                        ),
                        SizedBox(height:height*0.05 ,),
                        AppBtn(
                          height:height*0.07 ,
                            title: 'Main wallet transfer',
                            fontSize: 17,
                            onTap: () {
                              mainWalletTransfer();
                            },
                            hideBorder: true,
                            gradient: AppColors.loginSecondryGrad),
                        SizedBox(height:height*0.05 ,),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            groups(Assets.iconsProDeposit,'Deposit', () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>DepositScreen()));
                            },),
                            groups(Assets.iconsProWithdraw,'Withdrawl', () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>WithdrawScreen()));

                            },),
                            groups(Assets.iconsRechargeHistory,'Deposit\n history', () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>DepositHistory()));
                            },),
                            groups(Assets.iconsWithdrawHistory,'Withdrawl\n     history', () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>WithdrawHistory()));

                            },),

                          ],
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ):const Center(child: CircularProgressIndicator())
    );

  }

  @override
  void initState() {

    // TODO: implement initState
    super.initState();
  }

  BaseApiHelper baseApiHelper = BaseApiHelper();

  UserViewProvider userProvider = UserViewProvider();
  mainWalletTransfer() async {
    UserModel user = await userProvider.getUser();
    String token = user.id.toString();
    final response = await http.post(
      Uri.parse(ApiUrl.mainWalletTransfer),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "id": token,
      }),
    );
    var data = jsonDecode(response.body);
    print(data);
    if (data["status"] == 200) {
      context.read<ProfileProvider>().fetchProfileData();
      return Utils.flushBarSuccessMessage(data['message'], context, Colors.black);
    } else if (data["status"] == 401) {
      Utils.flushBarErrorMessage(data['message'], context, Colors.black);
    } else {
      Utils.flushBarErrorMessage(data['message'], context, Colors.black);
    }
  }


   groups(String img,String title,VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Column(
                      children: [
                        Container(
                            height:height*0.08,
                          width: width*0.16,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            gradient: AppColors.boxGradient
                          ),
                          child: Center(
                            child: Image.asset( img,
                              height: 40,),
                          ),
                          //color: Colors.white,
                        ),
                        SizedBox(height: 8,),
                        textWidget(
                            text: title,
                            color: AppColors.primaryTextColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      ],
                    ),
    );
  }
  Widget percentage(String percentData, String amount, String title) {
    double percentage = double.parse(percentData) / 100;

    return Column(
      children: [
        SizedBox(
          height: 15,
        ),
        CircularPercentIndicator(
          animation: true,
          animationDuration: 1200,
          lineWidth: 10.0,
          startAngle:8.0,
          radius: 120,
          circularStrokeCap: CircularStrokeCap.round,
          backgroundColor: AppColors.primaryTextColor.withOpacity(0.2),
          linearGradient:AppColors.loginSecondryGrad,
          percent: percentage,
          center: CircleAvatar(
            radius: 50,
            backgroundColor: AppColors.percentageColor,
            child: textWidget(
              text: '$percentData%',
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: AppColors.gradientFirstColor,
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.currency_rupee,
              size: 16,
              color: AppColors.primaryTextColor,
            ),
            textWidget(
              text: amount,
              fontWeight: FontWeight.w900,
              fontSize: 16,
              color: AppColors.primaryTextColor,
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        textWidget(
          text: title,
          fontWeight: FontWeight.w600,
          fontSize: 16,
          color: AppColors.gradientFirstColor,
        ),
      ],
    );
  }
}
