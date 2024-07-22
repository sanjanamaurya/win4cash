import 'dart:convert';
import 'package:win4cash/res/provider/profile_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:win4cash/generated/assets.dart';
import 'package:win4cash/main.dart';
import 'package:win4cash/model/user_model.dart';
import 'package:win4cash/res/aap_colors.dart';
import 'package:win4cash/res/api_urls.dart';
import 'package:win4cash/res/components/app_bar.dart';
import 'package:win4cash/res/components/app_btn.dart';
import 'package:win4cash/res/components/clipboard.dart';
import 'package:win4cash/res/provider/user_view_provider.dart';
import 'package:http/http.dart' as http;
import 'package:win4cash/view/account/service_center/custmor_service.dart';
import 'package:win4cash/view/promotion/commission_detail.dart';
import 'package:win4cash/view/promotion/invitation_rules.dart';
import 'package:win4cash/view/promotion/new_subordinate.dart';
import 'package:win4cash/view/promotion/subordinate_data.dart';

class PromotionScreenNew extends StatefulWidget {
  const PromotionScreenNew({super.key});

  @override
  State<PromotionScreenNew> createState() => _PromotionScreenNewState();
}

class _PromotionScreenNewState extends State<PromotionScreenNew> {
  @override
  void initState() {
    attendanceHistory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> items = [
      {
        'text': 'Copy Invitation Code',
        'icon': Assets.iconsCopycode,
        'Subtext': invitationCode.toString(),
        'onTap': () {
          copyToClipboard(invitationCode.toString(), context);
        },
      },
      {
        'text': 'Subordinate data',
        'icon': Assets.iconsTeamport,
        'Subtext': '',
        'onTap': () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SubOrdinateDataScreen(
                        responseData: responseData,
                      )));
        },
      },
      {
        'text': 'Commission detail',
        'icon': Assets.iconsCommission,
        'Subtext': '',
        'onTap': () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const CommissionDetails()));
        },
      },
      {
        'text': 'Invitation rules',
        'icon': Assets.iconsInvitereg,
        'Subtext': '',
        'onTap': () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const InvitationRules()));
        },
      },
      {
        'text': 'Agent line customer service',
        'icon': Assets.iconsCustomer,
        'Subtext': '',
        'onTap': () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const CustomerCareService()));
        },
      },
      //  {'text': 'Rebate ratio', 'icon': Assets.iconsRebateRatio, 'Subtext': '',  'onTap': () {},},
    ];
    return Scaffold(
      backgroundColor: AppColors.scaffolddark,
      appBar: GradientAppBar(
          title: const Text(
            'Agency',
            style: TextStyle(
                fontWeight: FontWeight.w900, fontSize: 25, color: Colors.white),
          ),
          actions: [
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const NewSubordinate()));
              },
              child: Center(
                child: Image.asset(
                  Assets.iconsFilternew,
                  height: 30,
                ),
              ),
            ),
          ],
          centerTitle: true,
          gradient: AppColors.primaryUnselectedGradient),
      body: ListView(
        children: [
          Stack(
            children: [
              Column(
                children: [
                  Container(
                    height: height * 0.48,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        gradient: AppColors.primaryGradient),
                    child: Column(
                      children: [
                        SizedBox(
                          height: height * 0.06,
                        ),
                        Text(
                          yesterdayTotalCommission.toString(),
                          style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primaryTextColor),
                        ),
                        Container(
                          height: height * 0.06,
                          width: width * 0.8,
                          decoration: BoxDecoration(
                              color: AppColors.constColor,
                              borderRadius: BorderRadius.circular(20)),
                          child: const Center(
                            child: Text(
                              "Yesterday's total commission",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.primaryTextColor),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        const Text(
                          "Upgrade the level to increase level income",
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primaryTextColor),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height * 0.26,
                  ),
                  kIsWeb == true
                      ? AppBtn(
                          gradient: AppColors.primaryGradient,
                          hideBorder: true,
                          title: 'INVITATION LINK',
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          onTap: () async {
                            String referralUrl = context
                                .read<ProfileProvider>()
                                .referralCodeUrl
                                .toString();
                            Share.share(
                                'Its my referral Code : *$invitationCode* link to join: $referralUrl  , Download app Now :${context.read<ProfileProvider>().apkLink}',
                                subject: 'Join Now !!');
                          },
                        )
                      : AppBtn(
                          titleColor: AppColors.primaryTextColor,
                          gradient: AppColors.primaryGradient,
                          hideBorder: true,
                          title: 'INVITATION LINK',
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          onTap: () async {
                            print('rfrfrfrfrf');
                            await FlutterShare.share(
                                title: 'Referral Code :',
                                text:
                                    "Join our gaming platform to win exciting prizes. Here is my Referral Code : $invitationCode",
                                // 'Join Now & Get ₹50 and Exiting Prizes. here is my Referral Code : ${userData.referralCode}',
                                linkUrl: context
                                    .read<ProfileProvider>()
                                    .referralCodeUrl,
                                chooserTitle: 'Referral Code : ');
                          },
                        ),
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: items.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                            onTap: () {
                              items[index]['onTap']();
                              print('rfrfrfrfrf');
                              print(items[index]['onTap']);
                            },
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                              child: Container(
                                height: height * 0.12,
                                width: width * 0.9,
                                decoration: BoxDecoration(
                                    color: AppColors.FirstColor,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                        height: 40,
                                        width: 40,
                                        child: Image(
                                          image: AssetImage(
                                            items[index]['icon'].toString(),
                                          ),
                                        )),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      items[index]['text'].toString(),
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w800,
                                          color: Colors.white),
                                    ),
                                    const Spacer(),
                                    Text(
                                      items[index]['Subtext'].toString(),
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w800,
                                          color: Colors.white),
                                    ),
                                    const Icon(
                                      Icons.arrow_forward_ios,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: width * 0.02,
                                    )
                                  ],
                                ),
                              ),
                            ));
                      }),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Container(
                    height: height * 0.32,
                    width: width * 0.925,
                    decoration: BoxDecoration(
                        color: AppColors.FirstColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                Assets.iconsMoneyicon,
                                scale: 1.5,
                              ),
                              SizedBox(
                                width: width * 0.02,
                              ),
                              const Text(
                                'promotion data',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              addSecondTextColumn(totalSubordinate.toString(),
                                  'Direct Subordinate', '', Colors.white),
                              Container(
                                height: 50,
                                width: 1,
                                color: Colors.white,
                              ),
                              addSecondTextColumn(totalCommission.toString(),
                                  'Total Commission', '', Colors.white),
                            ],
                          ),
                          addSecondTextColumn(
                              totalSubordinateInTeam.toString(),
                              'Total number of',
                              'Subordinates in the team',
                              Colors.white)
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.08,
                  ),
                ],
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.only(top: height * 0.25),
                  child: Container(
                    height: height * 0.45,
                    width: width * 0.9,
                    decoration: BoxDecoration(
                        color: AppColors.FirstColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        Container(
                          height: height * 0.08,
                          width: width * 0.9,
                          decoration: const BoxDecoration(
                              color: AppColors.secondaryContainerTextColor,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const SizedBox(
                                width: 8,
                              ),
                              Image.asset(
                                Assets.iconsAgFirst,
                                scale: 2,
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              const Text(
                                "Direct Subordinate",
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.primaryTextColor),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Container(
                                height: height * 0.08,
                                width: 2,
                                color: Colors.white,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Image.asset(
                                Assets.iconsAgSecond,
                                scale: 2,
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              const Text(
                                "Team  Subordinate",
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.primaryTextColor),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                addTextColumn(numberOfRegister.toString(),
                                    'Number of Register', Colors.white),
                                addTextColumn(depositNumber.toString(),
                                    'Deposit Number', Colors.green),
                                addTextColumn(depositAmount.toString(),
                                    'Deposit amount', Colors.deepOrange),
                                addTextColumn(
                                    numberOfFirstDeposit.toString(),
                                    'Number of People making\n            first deposit',
                                    Colors.white),
                              ],
                            ),
                            Column(
                              children: [
                                addTextColumn(subNumberOfRegister.toString(),
                                    'Number of Register', Colors.white),
                                addTextColumn(subDepositNumber.toString(),
                                    'Deposit Number', Colors.green),
                                addTextColumn(subDepositAmount.toString(),
                                    'Deposit amount', Colors.deepOrange),
                                addTextColumn(
                                    subNumberOfFirstDeposit.toString(),
                                    'Number of People making\n            first deposit',
                                    Colors.white),
                              ],
                            ),
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
      ),
    );
  }

  addTextColumn(String number, String subtext, Color textColor) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Column(
        children: [
          Text(
            number,
            style: TextStyle(
                fontSize: 15, fontWeight: FontWeight.w700, color: textColor),
          ),
          Text(
            subtext,
            style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: AppColors.dividerColor),
          ),
        ],
      ),
    );
  }

  addSecondTextColumn(
      String number, String subtext, String subtextOne, Color textColor) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Column(
        children: [
          Text(
            number,
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w700, color: textColor),
          ),
          Text(
            subtext,
            style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: AppColors.dividerColor),
          ),
          Text(
            subtextOne,
            style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: AppColors.dividerColor),
          ),
        ],
      ),
    );
  }

  String numberOfRegister = '0';
  String depositNumber = '0';
  String depositAmount = '0';
  String? numberOfFirstDeposit = '0';
  String? subNumberOfRegister = '0';
  String? subDepositNumber = '0';
  String? subDepositAmount = '0';
  String? subNumberOfFirstDeposit = '0';
  String? totalCommission = '0';
  String? invitationCode = '0';
  String? yesterdayTotalCommission = '0';
  String? totalSubordinate = '0';
  String? totalSubordinateInTeam = '0';
  int? responseStatuscode;

  Map<String, dynamic> responseData = {};
  UserViewProvider userProvider = UserViewProvider();
  Future<void> attendanceHistory() async {
    UserModel user = await userProvider.getUser();
    String token = user.id.toString();
    final response = await http.get(
      Uri.parse(ApiUrl.promotionScreen + token),
    );
    if (kDebugMode) {
      print(ApiUrl.promotionScreen + token);
      print('attendanceHistory');
    }
    setState(() {
      responseStatuscode = response.statusCode;
    });
    if (response.statusCode == 200) {
      responseData = json.decode(response.body);
      setState(() {
        numberOfRegister = responseData['noUserDirect'].toString();
        depositNumber = responseData['numofpayindirect'].toString();
        depositAmount = responseData['payinAmountDirect'].toString();
        numberOfFirstDeposit = responseData['noOfFristPayinDirect'].toString();
        subNumberOfRegister = responseData['noUserTeam'].toString();
        subDepositNumber = responseData['numofpayteam'].toString();
        subDepositAmount = responseData['payinAmountTeam'].toString();
        subNumberOfFirstDeposit = responseData['noOfFristPayinTeam'].toString();
        totalCommission = responseData['totalcommission'].toString();
        invitationCode = responseData['user_refer_code'].toString();
        yesterdayTotalCommission =
            responseData['yesterday_totalcommission'].toString();
        totalSubordinate = responseData['direct_user_count'].toString();
        totalSubordinateInTeam = responseData['total_register_team'].toString();
      });
      print('numberOfRegister: $numberOfRegister'); // Print to verify value
    } else if (response.statusCode == 400) {
      if (kDebugMode) {
        print('Data not found');
      }
    } else {
      setState(() {
        // attendenceItems = [];
      });
      throw Exception('Failed to load data');
    }
  }
}

class AllTierData {
  final int userId;
  final String username;
  final dynamic turnover;
  final dynamic commission;
  final dynamic uid;
  final dynamic depositAmount;
  final String type;

  AllTierData({
    required this.userId,
    required this.username,
    required this.turnover,
    required this.commission,
    required this.uid,
    required this.depositAmount,
    required this.type,
  });
}
