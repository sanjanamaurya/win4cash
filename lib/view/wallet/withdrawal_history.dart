import 'dart:convert';
import 'package:win4cash/generated/assets.dart';
import 'package:win4cash/main.dart';
import 'package:win4cash/model/transction_type_model.dart';
import 'package:win4cash/model/user_model.dart';
import 'package:win4cash/model/withdrawhistory_model.dart';
import 'package:win4cash/res/aap_colors.dart';
import 'package:win4cash/res/api_urls.dart';
import 'package:win4cash/res/components/app_bar.dart';
import 'package:win4cash/res/components/app_btn.dart';
import 'package:win4cash/res/components/text_widget.dart';
import 'package:win4cash/res/helper/api_helper.dart';
import 'package:win4cash/res/provider/user_view_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:win4cash/utils/routes/routes_name.dart';

class WithdrawHistory extends StatefulWidget {
  const WithdrawHistory({super.key});

  @override
  State<WithdrawHistory> createState() => _WithdrawHistoryState();
}

class _WithdrawHistoryState extends State<WithdrawHistory> with SingleTickerProviderStateMixin {

  @override
  void initState() {
    withdrawHistory();
    fetchTransactionTypes();
    super.initState();

  }

  late int selectedCatIndex;

  int ?responseStatuscode;
  int selectedId = 0;
  String typeName = 'All';
  bool isLoading = false;

  BaseApiHelper baseApiHelper = BaseApiHelper();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffolddark,
      appBar: GradientAppBar(
        centerTitle: true,
        leading: const AppBackBtn(),
          title: textWidget(
              text: 'Withdraw History',
            fontWeight: FontWeight.w900,
            fontSize: 20,
            color: AppColors.primaryTextColor,),
          gradient: AppColors.primaryUnselectedGradient),
      body: ScrollConfiguration(
        behavior: const ScrollBehavior().copyWith(overscroll: false),
        child: ListView(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            topLeft: Radius.circular(10),
                          ),
                        ),
                        context: context,
                        builder: (BuildContext context) {
                          return allTransctionType(context);
                        },
                      );
                    },
                    child: Container(
                      height: height * 0.08,
                      width: width * 0.45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        gradient: AppColors.primaryUnselectedGradient,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: width*0.3,
                              child: textWidget(
                                text: typeName,
                                fontWeight: FontWeight.w900,
                                fontSize: 12,
                                color: AppColors.dividerColor,
                              ),
                            ),
                            const Icon(
                              Icons.keyboard_arrow_down,
                              color: AppColors.dividerColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: height * 0.08,
                    width: width * 0.45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      gradient: AppColors.primaryUnselectedGradient,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          textWidget(
                            text: 'Choose the date',
                            fontWeight: FontWeight.w900,
                            fontSize: 12,
                            color: AppColors.dividerColor,
                          ),
                          const Icon(
                            Icons.keyboard_arrow_down,
                            color: AppColors.dividerColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            responseStatuscode== 400 ?
            const Notfounddata(): WithdrawItems.isEmpty? const Center(child: CircularProgressIndicator()):
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                    itemCount: WithdrawItems.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final constText = WithdrawItems[index];
                      return Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: AppColors.primaryUnselectedGradient,
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      height: 30,
                                      width: width * 0.30,
                                      decoration: BoxDecoration(
                                          color:AppColors.methodblue ,
                                          //color: depositItems[index].status=="0"?Colors.orange: depositItems[index].status=="1"?AppColors.DepositButton:Colors.red,
                                          borderRadius: BorderRadius.circular(10)),
                                      child: textWidget(
                                          text: 'Withdraw'  ,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.primaryTextColor
                                      ),
                                    ),
                                    textWidget(text: constText.status==1?"Processing":constText.status==2?"Complete":"Rejected",
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: constText.status==1?AppColors.gradientFirstColor:constText.status==2?Colors.green:AppColors.primaryTextColor
                                    )

                                  ],
                                ),
                              ),
                              const Divider(thickness: 1.5,indent: 10,endIndent: 10,color: AppColors.gradientFirstColor,),
                              const SizedBox(
                                height: 4,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    textWidget(
                                        text: "Balance",
                                        fontSize: width * 0.04,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.primaryTextColor),
                                    textWidget(
                                        text: "₹${constText.amount}",
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.gradientFirstColor),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:  const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    textWidget(
                                        text: "Type",
                                        fontSize: width * 0.04,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.primaryTextColor),
                                    Image.asset(constText.type==2?Assets.imagesUsdtIcon:Assets.imagesFastpayImage, height: height*0.05,)
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    textWidget(
                                        text: "Time",
                                        fontSize: width * 0.04,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.primaryTextColor),
                                    textWidget(
                                        text: DateFormat("dd-MMM-yyyy, hh:mm a").format(DateTime.parse(constText.createdAt.toString())),                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.primaryTextColor

                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    textWidget(
                                        text: "Order number",
                                        fontSize: width * 0.04,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.primaryTextColor),
                                    Row(
                                      children: [
                                        textWidget(
                                            text: constText.orderId.toString(),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color:
                                            AppColors.primaryTextColor),
                                        SizedBox(
                                          width: width * 0.01,
                                        ),
                                        Image.asset(Assets.iconsCopy, color: Colors.grey,height: height * 0.03)                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    })
            ),
          ],
        ),
      ),
    );
  }



  Widget allTransctionType(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(10),
          topLeft: Radius.circular(10),
        ),
        color: AppColors.filledColor,
      ),
      height: MediaQuery.of(context).size.height * 0.35,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: textWidget(
                    text: 'Cancel',
                    fontWeight: FontWeight.w900,
                    fontSize: 16,
                    color:
                    AppColors.dividerColor,
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      withdrawHistory();
                    });
                    Navigator.pop(context);
                  },
                  child: textWidget(
                    text: 'Confirm',
                    fontWeight: FontWeight.w900,
                    fontSize: 16,
                    color: AppColors.gradientFirstColor,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
              shrinkWrap: true,
              itemCount: transctionTypes.length,
              itemBuilder: (BuildContext context, int index) {
                final type = transctionTypes[index];
                return InkWell(
                  onTap: () {
                    setState(() {
                      selectedId = index; // Assuming selectedId is an int
                      typeName = type.name.toString();
                    });
                    if (kDebugMode) {
                      print(selectedId);
                    }
                  },
                  child: Column(
                    children: [
                      Center(
                        child: Text(
                          type.name,
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 16,
                            color: selectedId == index
                                ? Colors.blue
                                : AppColors.primaryTextColor, // Assuming AppColors.primaryTextColor is black
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

        ],
      ),
    );
  }


  List<TransctionTypeModel> transctionTypes = [];
  Future<void> fetchTransactionTypes() async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.get(Uri.parse(ApiUrl.depositWithdrawlStatusList));
      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body)['data'];
        setState(() {
          transctionTypes = responseData
              .map((item) => TransctionTypeModel.fromJson(item))
              .toList();
        });
      } else if (response.statusCode == 401) {
        Navigator.pushNamed(context, RoutesName.loginScreen);
      } else {
        throw Exception('Failed to load transaction types');
      }
    } catch (e) {
      print('Error fetching transaction types: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  UserViewProvider userProvider = UserViewProvider();

  List<WithdrawModel> WithdrawItems = [];

  Future<void> withdrawHistory() async {
    UserModel user = await userProvider.getUser();
    String token = user.id.toString();
    final response = await http.get(Uri.parse('${ApiUrl.withdrawHistory}$token&status=$selectedId'),);
    if (kDebugMode) {
      print(ApiUrl.withdrawHistory+token);
      print('withdrawHistory');
    }

    setState(() {
      responseStatuscode = response.statusCode;
    });

    if (response.statusCode==200) {
      final List<dynamic> responseData = json.decode(response.body)['data'];
      setState(() {

        WithdrawItems = responseData.map((item) => WithdrawModel.fromJson(item)).toList();
        // selectedIndex = items.isNotEmpty ? 0:-1; //
      });

    }
    else if(response.statusCode==400){
      if (kDebugMode) {
        print('Data not found');
      }
    }
    else {
      setState(() {
        WithdrawItems = [];
      });
      throw Exception('Failed to load data');
    }
  }

}

class BetIconModel {
  final String title;
  final String? image;
  BetIconModel({required this.title, this.image});
}

class History{
  String method;
  String balance;
  String type;
  String orderno;
  History(this.method,this.balance,this.type,this.orderno);
}

class Notfounddata extends StatelessWidget {
  const Notfounddata({super.key});

  @override
  Widget build(BuildContext context){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: height*0.05,),
        Image.asset(Assets.imagesNoDataAvailable,height: height*0.21,),
        const Text("No data (:",style: TextStyle(color: Colors.white),)
      ],
    );
  }

}
