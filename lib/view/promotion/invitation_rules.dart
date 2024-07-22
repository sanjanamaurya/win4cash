import 'package:flutter/material.dart';
import 'package:win4cash/generated/assets.dart';
import 'package:win4cash/main.dart';
import 'package:win4cash/res/aap_colors.dart';
import 'package:win4cash/res/app_constant.dart';
import 'package:win4cash/res/components/app_bar.dart';
import 'package:win4cash/res/components/app_btn.dart';
import 'package:win4cash/res/components/text_widget.dart';

class InvitationRules extends StatefulWidget {
  const InvitationRules({super.key});

  @override
  State<InvitationRules> createState() => _InvitationRulesState();
}
class _InvitationRulesState extends State<InvitationRules> {

  List<LevelList> itemsLevel = [
    LevelList(l1: 'L0', l2: '0', l3: '0', l4: '0'),
    LevelList(l1: 'L1', l2: '5', l3: '500k', l4: '100k'),
    LevelList(l1: 'L2', l2: '10', l3: '1,000k', l4: '200k'),
    LevelList(l1: 'L3', l2: '15', l3: '2.50M', l4: '500k'),
    LevelList(l1: 'L4', l2: '20', l3: '3.50M', l4: '700k'),
    LevelList(l1: 'L5', l2: '25', l3: '5M', l4: '1,000k'),
    LevelList(l1: 'L6', l2: '30', l3: '10M', l4: '2M'),
    LevelList(l1: 'L7', l2: '100', l3: '100M', l4: '20M'),
    LevelList(l1: 'L8', l2: '500', l3: '500M', l4: '100M'),
    LevelList(l1: 'L9', l2: '1000', l3: '1,000M', l4: '200M'),
    LevelList(l1: 'L10', l2: '5000', l3: '1,500M', l4: '300M'),
  ];
  List<LevelList1> itemsLevel1 = [
    LevelList1(l1: 'There are 6 subordinate levels in inviting friends, if A invites B, then B is a level 1 subordinate of A. If B invites C, then C is a level 1 subordinate of B and also a level 2 subordinate of A. If C invites D, then D is a level 1 subordinate of C, at the same time a level 2 subordinate of B and also a level 3 subordinate of A.'),
    LevelList1(l1: 'When inviting friends to register, you must send the invitation link provided or enter the invitation code manually so that your friends become your level 1 subordinates.'),
    LevelList1(l1: "The invitee registers via the invite's invitation code and completes the deposit, shortly after that the commission will be received immediately"),
    LevelList1(l1: "The calculation of yesterday's commission starts every morning at 01:00. After the commission calculation is completed, the commission is rewarded to the wallet and can be viewed through the commission collection record."),
    LevelList1(l1: "Commission rates vary depending on your agency level on that day\nNumber of Teams: How many downline deposits you have to date.\nTeam Deposits: The total number of deposits made by your downline in one day.\nTeam Deposit: Your downline deposits within one day. "),
    LevelList1(l1: 'The commission percentage depends on the membership level. The higher the membership level, the higher the bonus percentage. Different game types also have different payout percentages. '),
    LevelList1(l1: 'TOP20 commission rankings will be randomly awarded with  a separate bonus'),
    LevelList1(l1: 'The final interpretation of this activity belongs to ${AppConstants.appName}'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffolddark,
      appBar: GradientAppBar(
          title: textWidget(
              text: 'Invitation rules',
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.w700),
          leading: const AppBackBtn(),
          centerTitle: true,
          gradient: AppColors.primaryUnselectedGradient),
      body: ListView(
        children: [
          SizedBox(
            height: height * 0.02,
          ),
          Center(
              child: textWidget(
                  text: '【Privacy Agreement】 program',
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: AppColors.gradientFirstColor)),
          SizedBox(
            height: height * 0.01,
          ),
          Center(
              child: textWidget(
                  text: 'This activity is valid for a long time',
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  color: AppColors.btnColor)),
          SizedBox(
            height: height * 0.02,
          ),
          ListView.builder(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: itemsLevel1.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: index == 4
                      ? Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      color: AppColors.gradientSecondColor,
                                      border: Border.all(
                                          color:
                                          AppColors.secondaryContainerTextColor,
                                          width: 2),
                                      //  gradient: AppColors.primaryUnselectedGradient,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(8,30,8,20),
                                        child: textWidget(
                                            text:itemsLevel1[index].l1.toString(),
                                            fontSize: 15,
                                            color: AppColors.primaryTextColor,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Container(
                                        height: height * 0.07,
                                        width: width,
                                        color: AppColors.secondaryContainerTextColor,
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                          children: [
                                            textWidget(
                                                text: 'Rebate level',
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12,
                                                color: Colors.white),
                                            textWidget(
                                                text: 'Team Number',
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12,
                                                color: Colors.white),
                                            textWidget(
                                                text: 'Team Betting',
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12,
                                                color: Colors.white),
                                            textWidget(
                                                text: 'Team Deposit',
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12,
                                                color: Colors.white),
                                          ],
                                        ),
                                      ),
                                      ListView.builder(
                                          physics: const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: itemsLevel.length,
                                          itemBuilder: (context, index) {
                                            return Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Container(
                                                  clipBehavior: Clip.none,
                                                  padding: const EdgeInsets.all(05),
                                                  height: height * 0.06,
                                                  width: width * 0.237,
                                                  decoration: const BoxDecoration(
                                                    border: Border(
                                                      bottom: BorderSide(
                                                          width: 1.5,
                                                          color: AppColors.secondaryContainerTextColor),
                                                    ),
                                                  ),
                                                  child: Container(
                                                    clipBehavior: Clip.none,
                                                    decoration: const BoxDecoration(
                                                        image: DecorationImage(
                                                            image: AssetImage(Assets
                                                                .iconsKingrules))),
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(top: 8.0,left: 22),
                                                      child: Center(
                                                        child: textWidget(
                                                            text: itemsLevel[index]
                                                                .l1
                                                                .toString(),
                                                            fontSize: 12,
                                                            fontWeight: FontWeight.w500,
                                                            color: Colors.white),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  alignment: Alignment.center,
                                                  height: height * 0.06,
                                                  width: width * 0.235,
                                                  decoration: const BoxDecoration(
                                                    border: Border(
                                                      bottom: BorderSide(
                                                          width: 1.5,
                                                          color: AppColors.secondaryContainerTextColor),
                                                      left: BorderSide(
                                                          width: 1.5,
                                                          color: AppColors.secondaryContainerTextColor),
                                                    ),
                                                  ),
                                                  child: textWidget(
                                                      text: itemsLevel[index]
                                                          .l2
                                                          .toString(),
                                                      fontWeight: FontWeight.w500,
                                                      color: AppColors.primaryTextColor,
                                                      fontSize: 16),
                                                ),
                                                Container(
                                                  alignment: Alignment.center,
                                                  height: height * 0.06,
                                                  width: width * 0.237,
                                                  decoration: const BoxDecoration(
                                                    border: Border(
                                                      bottom: BorderSide(
                                                          width: 1.5,
                                                          color: AppColors.secondaryContainerTextColor),
                                                      left: BorderSide(
                                                          width: 1.5,
                                                          color: AppColors.secondaryContainerTextColor),
                                                    ),                                                      ),
                                                  child: textWidget(
                                                      text: itemsLevel[index]
                                                          .l3
                                                          .toString(),
                                                      fontWeight: FontWeight.w500,
                                                      color: AppColors.primaryTextColor,
                                                      fontSize: 16),
                                                ),
                                                Container(
                                                  alignment: Alignment.center,
                                                  height: height * 0.06,
                                                  width: width * 0.235,
                                                  decoration: const BoxDecoration(
                                                    border: Border(
                                                      bottom: BorderSide(
                                                          width: 1.5,
                                                          color: AppColors.secondaryContainerTextColor),
                                                      left: BorderSide(
                                                          width: 1.5,
                                                          color: AppColors.secondaryContainerTextColor),
                                                    ),
                                                  ),
                                                  child: textWidget(
                                                      text: itemsLevel[index]
                                                          .l4
                                                          .toString(),
                                                      fontWeight: FontWeight.w500,
                                                      color: AppColors.primaryTextColor,
                                                      fontSize: 16),
                                                ),
                                              ],
                                            );
                                          }),

                                    ],
                                  ),
                                ),

                              ],
                            ),

                            Positioned(
                              top: -12,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 15),
                                child: Container(
                                  height: height * 0.06,
                                  width: width * 0.96,
                                  decoration: const BoxDecoration(
                                      image: DecorationImage(
                                          image:
                                          AssetImage(Assets.iconsRulehead2),
                                          fit: BoxFit.fill)),
                                  child: Center(
                                    child: Padding(
                                      padding:
                                      const EdgeInsets.only(bottom: 15.0),
                                      child: Text(
                                        '0${index + 1}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w900,
                                            fontSize: 18,
                                            color: AppColors.primaryTextColor),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),


                          ],
                        )
                      : Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                  color: AppColors.gradientSecondColor,
                                  border: Border.all(
                                      color:
                                          AppColors.secondaryContainerTextColor,
                                      width: 2),
                                  //  gradient: AppColors.primaryUnselectedGradient,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(8,30,8,20),
                                child: textWidget(
                                    text:itemsLevel1[index].l1.toString(),
                                    fontSize: 15,
                                    color: AppColors.primaryTextColor,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            Positioned(
                              top: -12,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 15),
                                child: Container(
                                  height: height * 0.06,
                                  width: width * 0.96,
                                  decoration: const BoxDecoration(
                                      image: DecorationImage(
                                          image:
                                              AssetImage(Assets.iconsRulehead2),
                                          fit: BoxFit.fill)),
                                  child: Center(
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 15.0),
                                      child: Text(
                                        '0${index + 1}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w900,
                                            fontSize: 18,
                                            color: AppColors.primaryTextColor),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                );
              })
        ],
      ),
    );
  }
}

class LevelList {
  String? l1;
  String? l2;
  String? l3;
  String? l4;

  LevelList({
    this.l1,
    this.l2,
    this.l3,
    this.l4,
  });
}
class LevelList1 {
  String? l1;


  LevelList1({
    this.l1,
  });
}
