// ignore_for_file: depend_on_referenced_packages, library_private_types_in_public_api, non_constant_identifier_names, use_build_context_synchronously, camel_case_types

import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:win4cash/main.dart';
import 'package:win4cash/model/result_game_history.dart';
import 'package:win4cash/res/app_constant.dart';
import 'package:win4cash/view/account/service_center/custmor_service.dart';
import 'package:win4cash/view/auth/constant_wallet.dart';
import 'package:win4cash/view/home/lottery/5d/tranglePainter/slot_machine/slot_machine.dart';
import 'package:win4cash/view/home/lottery/5d/trangle_painter.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:win4cash/generated/assets.dart';
import 'package:win4cash/model/bettingHistory_Model.dart';
import 'package:win4cash/model/user_model.dart';
import 'package:win4cash/res/aap_colors.dart';
import 'package:win4cash/res/api_urls.dart';
import 'package:win4cash/res/components/app_bar.dart';
import 'package:win4cash/res/components/app_btn.dart';
import 'package:win4cash/res/components/text_widget.dart';
import 'package:win4cash/res/helper/api_helper.dart';
import 'package:win4cash/res/provider/user_view_provider.dart';
import 'package:win4cash/view/home/lottery/5d/commonbottomsheet5d.dart';
import 'package:win4cash/view/home/lottery/5d/dummygrid5D.dart';
import 'package:win4cash/utils/how_to_play.dart';
import 'package:win4cash/view/home/widgets/game_anuncement.dart';

class Big {
  String type;
  String amount;
  Big(this.type, this.amount);
}

class Digitselect {
  String digit;
  String setdigit;
  Digitselect(this.digit, this.setdigit);
}

class Screen5d extends StatefulWidget {
  const Screen5d({super.key});

  @override
  _Screen5dState createState() => _Screen5dState();
}

class _Screen5dState extends State<Screen5d>
    with SingleTickerProviderStateMixin {
  late int selectedCatIndex;

  @override
  void initState() {
    startCountdown();

    gameHistoryResult();
    gameHistoryResult1();
    BettingHistory();
    super.initState();
    selectedCatIndex = 0;
  }

  int selectedContainerIndex = -1;

  List<String> imageAssets = [
    '5',
    '2',
    '3',
    '8',
    '9',
    '7',
    '6',
    '4',
    '1',
    '0',
  ];
  List<Winlist> list = [
    Winlist(1, "5D Lotre", "1 Min", 60),
    Winlist(2, "5D Lotre", "3 Min", 180),
    Winlist(3, "5D Lotre", "5 Min", 300),
    Winlist(4, "5D Lotre", "10 Min", 600),
  ];

  List<AlfaBate> alphabetlist = [
    AlfaBate(
      1,
      "A",
    ),
    AlfaBate(
      2,
      "B",
    ),
    AlfaBate(
      3,
      "C",
    ),
    AlfaBate(
      4,
      "D",
    ),
    AlfaBate(
      5,
      "E",
    ),
    AlfaBate(
      6,
      "SUM",
    ),
  ];

  int countdownSeconds = 60;
  int gameseconds = 60;
  String gametitle = '5D Lotre';
  String subtitle = '1 Min';
  Timer? countdownTimer;

  Future<void> startCountdown() async {
    DateTime now = DateTime.now().toUtc();
    int minutes = now.minute;
    int minsec = minutes * 60;
    int initialSeconds = 60;
    if (gameseconds == 60) {
      initialSeconds = gameseconds - now.second;
    } else if (gameseconds == 180) {
      for (var i = 0; i < 20; i++) {
        if (minsec >= 180) {
          minsec = minsec - 180;
        } else {
          initialSeconds = gameseconds - minsec - now.second;
        }
        if (kDebugMode) {
          print(initialSeconds);
        }
      }
    } else if (gameseconds == 300) {
      for (var i = 0; i < 12; i++) {
        if (minsec >= 300) {
          minsec = minsec - 300;
        } else {
          initialSeconds = gameseconds -
              minsec -
              now.second; // Calculate initial remaining seconds
        }
      }
    } else if (gameseconds == 600) {
      for (var i = 0; i < 6; i++) {
        if (minsec >= 600) {
          minsec = minsec - 600;
        } else {
          initialSeconds = gameseconds -
              minsec -
              now.second; // Calculate initial remaining seconds
        }
      }
    }
    setState(() {
      countdownSeconds = initialSeconds;
    });
    countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      gameconcept(countdownSeconds);
      updateUI(timer);
    });
  }

  void updateUI(Timer timer) {
    setState(() {
      if (countdownSeconds == 5) {
      } else if (countdownSeconds == 0) {
        countdownSeconds = gameseconds;

        BettingHistory();
        game_winPopup();

      } else if (countdownSeconds == 59) {

      }
      countdownSeconds = (countdownSeconds - 1);
    });
  }

  int? responseStatuscode;







  @override
  void dispose() {
    countdownSeconds.toString();
    // TODO: implement dispose
    super.dispose();
  }

  List<Digitselect> digitlist = [
    Digitselect("0", "9"),
    Digitselect("1", "9"),
    Digitselect("2", "9"),
    Digitselect("3", "9"),
    Digitselect("4", "9"),
    Digitselect("5", "9"),
    Digitselect("6", "9"),
    Digitselect("7", "9"),
    Digitselect("8", "9"),
    Digitselect("9", "9"),
  ];
  List<String> Lotreresultalpha = ["A", "B", "C", "D", "E"];

  List<Big> SizeTypelist = [
    Big("Big", ""),
    Big("Small", ""),
    Big("Even", ""),
    Big("Odd", ""),
  ];

  int? showalphabet = 1;

  String? selectedAlphabet;
  String? selectedSizeType;
  String? selectedNumberType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.scaffolddark,
        resizeToAvoidBottomInset: true,
        appBar: GradientAppBar(
          leading: const AppBackBtn(),
          title: Image.asset(
            Assets.imagesAppBarSecond,
            height: 40,
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CustomerCareService()
                          //const ()
                          ));
                },
                child: SizedBox(
                  height: 30,
                  width: 30,
                  child: Image.asset(
                    Assets.iconsKefu,
                    scale: 1.8,
                  ),
                ),
              ),
            )
          ],
          centerTitle: true,
          gradient: AppColors.primaryUnselectedGradient,
        ),
        body: SingleChildScrollView(
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Column(
                children: [
                  const SizedBox(height: 20),
                  const ConstantWallet(),
                  const GameAnuncement(),
                  Container(
                    height: height * 0.18,
                    margin: const EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(
                      color: AppColors.FirstColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(list.length, (index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedCatIndex = index;
                              subtitle = list[index].subtitle;
                              gameseconds = list[index].time;
                              gameid = list[index].gameid;
                            });
                            countdownTimer!.cancel();
                            startCountdown();
                            offsetResult = 0;
                            // gameHistoryResult();
                            BettingHistory();
                          },
                          child: Container(
                            height: height * 0.28,
                            width: width * 0.23,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1.5,
                                  color: selectedCatIndex == index
                                      ? Colors.grey.withOpacity(0.2)
                                      : Colors.transparent),
                              gradient: selectedCatIndex == index
                                  ? AppColors.boxGradient
                                  : const LinearGradient(
                                      colors: [
                                        Colors.transparent,
                                        Colors.transparent
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              children: [
                                selectedCatIndex == index
                                    ? Image.asset(Assets.iconsTimeColor,
                                        height: 70)
                                    : Image.asset(Assets.iconsTime, height: 70),
                                textWidget(
                                    text: list[index].title,
                                    color: selectedCatIndex == index
                                        ? AppColors.primaryTextColor
                                        : AppColors.gradientFirstColor,
                                    fontSize: 14),
                                textWidget(
                                    text: list[index].subtitle,
                                    color: selectedCatIndex == index
                                        ? AppColors.primaryTextColor
                                        : AppColors.gradientFirstColor,
                                    fontSize: 14),
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: height * 0.17,
                    width: width * 0.93,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.FirstColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        textWidget(
                            text: "Lottery\n\nResult",
                            fontSize: 12,
                            color: Colors.white),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                    children: List.generate(
                                  5,
                                  (index) => Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Container(
                                      width: 39,
                                      height: 50,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: AppColors.gradientFirstColor,
                                          shape: BoxShape.circle,
                                          border:
                                              Border.all(color: Colors.black)),
                                      child: textWidget(
                                          text: "1",
                                          fontSize: 12,
                                          fontWeight: FontWeight.w800,
                                          color: Colors.white),
                                    ),
                                  ),
                                )),
                                textWidget(
                                    text: "=",
                                    fontSize: 12,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white),
                                CircleAvatar(
                                  radius: 20,
                                  backgroundColor: AppColors.gradientFirstColor,
                                  child: textWidget(
                                      text: "10",
                                      fontSize: 12,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white),
                                )
                              ],
                            ),
                            Row(
                                children: List.generate(
                              Lotreresultalpha.length,
                              (index) => Container(
                                width: 43,
                                height: 20,
                                alignment: Alignment.center,
                                child: textWidget(
                                    text: Lotreresultalpha[index],
                                    fontSize: 12,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white),
                              ),
                            )),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                      width: width * 0.93,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.FirstColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Period',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.btnColor),
                              ),
                              InkWell(
                                onTap: () {
                                  showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (BuildContext context)
                                  {
                                    return const HowToPlay(type:AppConstants.fiveDGameRule);
                                  });
                                      // Navigator.push(context, MaterialPageRoute(builder: (context)=>const HowtoplayScreen()));
                                },
                                child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4),
                                    height: 26,
                                    width: width * 0.3,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        border: Border.all(
                                            color:
                                                AppColors.gradientFirstColor)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          Assets.iconsHowtoplay,
                                          height: 16,
                                        ),
                                        const Text(
                                          ' How to Play',
                                          style: TextStyle(
                                              color:
                                                  AppColors.gradientFirstColor),
                                        ),
                                      ],
                                    )),
                              ),
                              const Spacer(),
                              const Text(
                                'Draw Time',
                                style: TextStyle(
                                    color: AppColors.gradientFirstColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                period.toString(),
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.gradientFirstColor),
                              ),
                              const Spacer(),
                              buildTime1(countdownSeconds)
                            ],
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          Container(
                            decoration: const BoxDecoration(
                                color: AppColors.FirstColor),
                            child: Column(
                              children: [
                                SlotMachineView(),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          create == false
                              ? Column(
                                  children: [
                                    buildAlphabetRow(),
                                    Container(
                                      height: 2,
                                      color: AppColors.gridColor,
                                    ),
                                    SizedBox(
                                      height: height * 0.02,
                                    ),
                                    buildBottomSheetTrigger(context, height),
                                  ],
                                )
                              : Stack(
                                  children: [
                                    const Dummygrid5D(),
                                    Container(
                                      height: 250,
                                      color: Colors.black26,
                                      child: buildTime5sec(countdownSeconds),
                                    ),
                                  ],
                                ),
                        ],
                      )),
                  const SizedBox(height: 15),
                  Result5d()

                ],
              ),
            ],
          ),
        ));
  }

  late SlotMachineNumberController _numberController;
  bool _isSlotMachineRunning = false;

  Widget SlotMachineView() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                  width: 10, color: const Color(0xFF4675D2))),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(width: 4, color: Colors.black12)),
            child: SlotMachineNumber(
              rollItems: List.generate(
                10,
                (index) => RollItemNumber(
                  index: index,
                ),
              ),
              onCreated: (controller) {
                _numberController = controller;
              },
              onFinished: (resultIndexes) {
                if (kDebugMode) {
                  print('Result: $resultIndexes');
                }
              },
            ),
          ),
        ),
        Positioned(
          left: 0,
          top: 0,
          child: Container(
            height: 150,
            width: 300,
         color: Colors.transparent,
          ),
        ),
        Positioned(
          right: 0,
          top: 86.0, // 50% of 64.0 height (to center vertically)
          child: Transform.translate(
            offset: const Offset(
                0, -32.0), // Translate by -50% of 64.0 height
            child: CustomPaint(
              size: const Size(
                  30.53, 16.0), // Width and height of the triangle
              painter: TrianglePainter(),
            ),
          ),
        ),
        Positioned(
          left: 0,
          top: 86.0, // 50% of 64.0 height (to center vertically)
          child: Transform.translate(
            offset: const Offset(
                0, -32.0), // Translate by -50% of 64.0 height
            child: CustomPaint(
              size: const Size(
                  30.53, 16.0), // Width and height of the triangle
              painter: TrianglePainter2(),
            ),
          ),
        ),
        Positioned(
          right: -8,
          top: 47.0,
          child: Container(
            height: 30,
            width: 15,
            decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.2),
                borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(5),
                    topRight: Radius.circular(5))),
          ),
        ),
        Positioned(
          left: -8,
          top: 47.0,
          child: Container(
            height: 30,
            width: 15,
            decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.2),
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(5),
                    topLeft: Radius.circular(5))),
          ),
        )
      ],
    );
  }

  void _handleSlotMachineTap() {
    if (!_isSlotMachineRunning) {
      final input = '${GameResults}2345';
      if (input.isNotEmpty) {
        final selectedNumber = int.tryParse(input);
        if (selectedNumber != null &&
            selectedNumber >= 00000 &&
            selectedNumber <= 99999) {
          setState(() {
            _isSlotMachineRunning = true;
            _numberController.start(hitRollItemIndex: selectedNumber);

            for (int i = 0; i < 5; i++) {
              final digit = (selectedNumber ~/ pow(10, 4 - i)) % 10;
              Future.delayed(Duration(seconds: 1 + i), () {
                _numberController.stop(reelIndex: i, resultIndex: digit);
                if (i == 4) {
                  setState(() {
                    _isSlotMachineRunning = false;
                  });
                }
              });
            }
          });
        } else {
          _showInvalidNumberDialog();
        }
      } else {
        _showInvalidNumberDialog();
      }
    }
  }

  void _showInvalidNumberDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Invalid Number"),
          content: const Text("Please enter a number between 00000 and 99999."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  Widget buildAlphabetRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(
        alphabetlist.length,
        (index) => InkWell(
          onTap: () {
            setState(() {
              showalphabet = alphabetlist[index].Alfaid;
            });
            print(showalphabet);
            print('wdvfrtgb');
          },
          child: Container(
            height: 40,
            width: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: showalphabet == alphabetlist[index].Alfaid
                  ? AppColors.gradientFirstColor
                  : AppColors.secondaryContainerTextColor,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(15),
                topLeft: Radius.circular(15),
              ),
            ),
            child: textWidget(
              text: alphabetlist[index].title,
              fontSize: 16,
              fontWeight: FontWeight.w900,
              color: showalphabet == alphabetlist[index].Alfaid
                  ? AppColors.primaryTextColor
                  : Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget ChartAlphabetRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(
        5,
        (index) => InkWell(
          onTap: () {
            setState(() {
              showalphabet = alphabetlist[index].Alfaid;
            });
            print(showalphabet);
            print('swjdfsijfi');
          },
          child: Container(
            height: 40,
            width: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: showalphabet == alphabetlist[index].Alfaid
                  ? AppColors.gradientFirstColor
                  : AppColors.secondaryContainerTextColor,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(15),
                topLeft: Radius.circular(15),
              ),
            ),
            child: textWidget(
              text: alphabetlist[index].title,
              fontSize: 16,
              fontWeight: FontWeight.w900,
              color: showalphabet == alphabetlist[index].Alfaid
                  ? AppColors.primaryTextColor
                  : Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildBottomSheetTrigger(BuildContext context, double height) {
    return InkWell(
      onTap: () {
        print('Triggering Bottom Sheet');
        showModalBottomSheet(
          isScrollControlled: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(28),
              topLeft: Radius.circular(28),
            ),
          ),
          context: context,
          builder: (context) {
            print('Inside Bottom Sheet Builder');
            print('Alphabet List: $alphabetlist');
            return CommonBottomSheet5D(
              gameid: gameid,
            );
          },
        );
      },
      child: Column(
        children: [
          buildSizeTypeRow(),
          SizedBox(
            height: height * 0.01,
          ),
          if (showalphabet != 6) buildDigitGrid(height),
        ],
      ),
    );
  }

  Widget buildSizeTypeRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(
        SizeTypelist.length,
        (index) => Padding(
          padding: const EdgeInsets.all(2.0),
          child: Container(
            height: 40,
            width: 70,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.secondaryContainerTextColor,
              borderRadius: BorderRadius.circular(6),
            ),
            child: textWidget(
              text: SizeTypelist[index].type,
              fontSize: 14,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildDigitGrid(double height) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 15.0,
      ),
      shrinkWrap: true,
      itemCount: digitlist.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: height * 0.05,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.gradientFirstColor),
              ),
              child: textWidget(
                text: digitlist[index].digit.toString(),
                fontSize: 15,
                fontWeight: FontWeight.w900,
                color: AppColors.gradientFirstColor,
              ),
            ),
            textWidget(
              text: digitlist[index].setdigit.toString(),
              fontSize: 14,
              color: AppColors.gradientFirstColor,
            ),
          ],
        );
      },
    );
  }



  /// how to play ke pass wala api
  bool create = false;
  int period = 0;
  int gameid = 1;
  int GameResults = 0;

  int pageNumber = 1;
  int selectedTabIndex = 0;

  Widget Result5d() {
    setState(() {});

    return gameResult != []
        ? Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildTabContainer(
                    'Game History',
                    0,
                    width,
                    Colors.red,
                  ),
                  buildTabContainer('Chart', 1, width, Colors.red),
                  buildTabContainer('My History', 2, width, Colors.red),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              selectedTabIndex == 0
                  ? Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          margin: const EdgeInsets.only(left: 10, right: 10),
                          decoration: const BoxDecoration(
                              gradient: AppColors.primaryUnselectedGradient,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  topLeft: Radius.circular(10))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                width: width * 0.3,
                                child: textWidget(
                                    text: 'Period',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w900,
                                    color: AppColors.primaryTextColor),
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: width * 0.38,
                                child: textWidget(
                                    text: 'Result',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w900,
                                    color: AppColors.primaryTextColor),
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: width * 0.21,
                                child: textWidget(
                                    text: 'Total',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w900,
                                    color: AppColors.primaryTextColor),
                              ),
                            ],
                          ),
                        ),
                        ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: gameResult.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      height: height * 0.06,
                                      width: width * 0.3,
                                      child: textWidget(
                                          text: gameResult[index]
                                              .gamesno
                                              .toString(),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          maxLines: 1,
                                          color: AppColors.primaryTextColor),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      width: width * 0.38,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: List.generate(
                                          5,
                                          (index) => Container(
                                            padding: const EdgeInsets.all(4),
                                            margin: const EdgeInsets.all(2),
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                    color: AppColors
                                                        .gradientFirstColor)),
                                            child: textWidget(
                                                text: digitlist[index]
                                                    .digit
                                                    .toString(),
                                                fontSize: 13,
                                                fontWeight: FontWeight.w900,
                                                color: AppColors
                                                    .gradientFirstColor),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                        alignment: Alignment.center,
                                        width: width * 0.21,
                                        child: Container(
                                          padding: const EdgeInsets.all(4),
                                          margin: const EdgeInsets.all(2),
                                          alignment: Alignment.center,
                                          decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color:
                                                  AppColors.gradientFirstColor),
                                          child: textWidget(
                                              text: '10',
                                              fontSize: 13,
                                              fontWeight: FontWeight.w900,
                                              color:
                                                  AppColors.primaryTextColor),
                                        )),
                                  ],
                                ),
                                Container(
                                    width: width,
                                    color: Colors.grey,
                                    height: 0.5),
                              ],
                            );
                          },
                        ),
                        SizedBox(height: height * 0.02),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: limitResult == 0
                                  ? () {}
                                  : () {
                                      setState(() {
                                        pageNumber--;
                                        limitResult = limitResult - 10;
                                        offsetResult = offsetResult - 10;
                                      });
                                      setState(() {});
                                      gameHistoryResult();
                                    },
                              child: Container(
                                height: height * 0.06,
                                width: width * 0.10,
                                decoration: BoxDecoration(
                                  gradient: AppColors.loginSecondryGrad,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Icon(
                                  Icons.navigate_before,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            textWidget(
                              text: '$pageNumber',
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primaryTextColor,
                              maxLines: 1,
                            ),
                            const SizedBox(width: 16),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  limitResult = limitResult + 10;
                                  offsetResult = offsetResult + 10;
                                  pageNumber++;
                                });
                                setState(() {});
                                gameHistoryResult();
                              },
                              child: Container(
                                height: height * 0.06,
                                width: width * 0.10,
                                decoration: BoxDecoration(
                                  gradient: AppColors.loginSecondryGrad,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Icon(Icons.navigate_next,
                                    color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10)
                      ],
                    )
                  : selectedTabIndex == 1
                      ? ChartScreen()
                      : responseStatuscode == 400
                          ? const Notfounddata()
                          : items.isEmpty
                              ? const Center(child: CircularProgressIndicator())
                              : Container(
                                  width: width,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 15),
                                  margin: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  decoration: const BoxDecoration(
                                      gradient:
                                          AppColors.primaryUnselectedGradient,
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(10),
                                          topLeft: Radius.circular(10))),
                                  child: Column(
                                    children: [
                                      Align(
                                        alignment: Alignment.bottomRight,
                                        child: InkWell(
                                          onTap: () {
                                            // Navigator.push(context, MaterialPageRoute(builder: (context)=>const MyHistoryDetails()));
                                          },
                                          child: Container(
                                            height: height * 0.06,
                                            width: width * 0.25,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                border: Border.all(
                                                    color: AppColors
                                                        .gradientFirstColor)),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                const Text(
                                                  'Detail',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: AppColors
                                                          .primaryTextColor),
                                                ),
                                                Container(
                                                    height: height * 0.04,
                                                    width: width * 0.09,
                                                    child: const Image(
                                                        image: AssetImage(Assets
                                                            .iconsMoreBtn))),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      ListView.builder(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: items.length,
                                        itemBuilder: (context, index) {
                                          List<Color> colors;

                                          if (items[index].number == 0) {
                                            colors = [
                                              AppColors.orangeColor,
                                              AppColors.primaryTextColor,
                                            ];
                                          } else if (items[index].number == 5) {
                                            colors = [
                                              const Color(0xFF40ad72),
                                              AppColors.primaryTextColor,
                                            ];
                                          } else if (items[index].number ==
                                              10) {
                                            colors = [
                                              const Color(0xFF40ad72),
                                              const Color(0xFF40ad72),
                                            ];
                                          } else if (items[index].number ==
                                              20) {
                                            colors = [
                                              AppColors.primaryTextColor,
                                              AppColors.primaryTextColor,
                                            ];
                                          } else if (items[index].number ==
                                              30) {
                                            colors = [
                                              AppColors.orangeColor,
                                              AppColors.orangeColor,
                                            ];
                                          } else if (items[index].number ==
                                              40) {
                                            colors = [
                                              AppColors.goldencolor,
                                              AppColors.goldencolor,
                                            ];
                                          } else if (items[index].number ==
                                              50) {
                                            colors = [
                                              const Color(0xff6eb4ff),
                                              const Color(0xff6eb4ff)
                                            ];
                                          } else {
                                            int number = int.parse(
                                                items[index].number.toString());
                                            colors = number.isOdd
                                                ? [
                                                    const Color(0xFF40ad72),
                                                    const Color(0xFF40ad72),
                                                  ]
                                                : [
                                                    AppColors.orangeColor,
                                                    AppColors.orangeColor,
                                                  ];
                                          }

                                          return ExpansionTile(
                                            leading: Container(
                                                height: height * 0.06,
                                                width: width * 0.12,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    // color: Colors.grey
                                                    gradient: LinearGradient(
                                                        stops: const [0.5, 0.5],
                                                        colors: colors,
                                                        begin:
                                                            Alignment.topLeft,
                                                        end: Alignment
                                                            .bottomRight)),
                                                child: Center(
                                                  child: Text(
                                                    items[index].number == 40
                                                        ? 'Big'
                                                        : items[index].number ==
                                                                50
                                                            ? 'Small'
                                                            : items[index]
                                                                        .number ==
                                                                    10
                                                                ? 'G'
                                                                : items[index]
                                                                            .number ==
                                                                        20
                                                                    ? 'W'
                                                                    : items[index].number ==
                                                                            30
                                                                        ? 'O'
                                                                        : items[index]
                                                                            .number
                                                                            .toString(),
                                                    style: TextStyle(
                                                        fontSize: items[index]
                                                                    .number ==
                                                                40
                                                            ? 10
                                                            : items[index]
                                                                        .number ==
                                                                    50
                                                                ? 10
                                                                : 20,
                                                        fontWeight:
                                                            FontWeight.w800,
                                                        color: Colors.black),
                                                  ),
                                                )),
                                            title: Text(
                                              items[index].gamesno.toString(),
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w800,
                                                  color: Colors.white),
                                            ),
                                            subtitle: Text(
                                                items[index]
                                                    .createdAt
                                                    .toString(),
                                                style: const TextStyle(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.grey)),
                                            trailing: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Container(
                                                  height: height * 0.042,
                                                  width: width * 0.2,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      border: Border.all(
                                                          color: items[index]
                                                                      .status ==
                                                                  0
                                                              ? AppColors
                                                                  .primaryTextColor
                                                              : items[index]
                                                                          .status ==
                                                                      2
                                                                  ? AppColors
                                                                      .secondaryTextColor
                                                                  : Colors
                                                                      .green)),
                                                  child: Center(
                                                    child: Text(
                                                      items[index].status == 2
                                                          ? 'Failed'
                                                          : items[index]
                                                                      .status ==
                                                                  0
                                                              ? 'Pending'
                                                              : 'Succeed',
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color: items[index]
                                                                      .status ==
                                                                  0
                                                              ? Colors.white
                                                              : items[index]
                                                                          .status ==
                                                                      2
                                                                  ? AppColors
                                                                      .secondaryTextColor
                                                                  : Colors
                                                                      .green),
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  items[index].status == 0
                                                      ? '--'
                                                      : items[index].status == 2
                                                          ? '- ₹${items[index].amount.toStringAsFixed(2)}'
                                                          : '+ ₹${items[index].winAmount.toStringAsFixed(2)}',
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: items[index]
                                                                  .status ==
                                                              0
                                                          ? Colors.white
                                                          : items[index]
                                                                      .status ==
                                                                  2
                                                              ? AppColors
                                                                  .secondaryTextColor
                                                              : Colors.green),
                                                ),
                                              ],
                                            ),
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 16.0),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const SizedBox(
                                                      height: 15,
                                                    ),
                                                    const Align(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        child: Text(
                                                          'Details',
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w900,
                                                              color:
                                                                  Colors.white),
                                                        )),
                                                    const SizedBox(height: 8.0),
                                                    Container(
                                                      height: height * 0.08,
                                                      width: width,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          color: AppColors
                                                              .FirstColor),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            const Text(
                                                              'order number',
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                            const SizedBox(
                                                                height: 4.0),
                                                            Text(
                                                              items[index]
                                                                  .orderId
                                                                  .toString(),
                                                              style: const TextStyle(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                  color: Colors
                                                                      .white),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    historyDetails(
                                                        'Period',
                                                        items[index]
                                                            .gamesno
                                                            .toString(),
                                                        Colors.white),
                                                    historyDetails(
                                                        'Purchase amount',
                                                        items[index]
                                                            .amount
                                                            .toString(),
                                                        Colors.white),
                                                    historyDetails(
                                                        'Amount after tax',
                                                        items[index]
                                                            .tradeAmount
                                                            .toString(),
                                                        Colors.red),
                                                    historyDetails(
                                                        'Tax',
                                                        items[index]
                                                            .commission
                                                            .toString(),
                                                        Colors.white),
                                                    historyWinDetails(
                                                        'Result',
                                                        items[index].winNumber == null
                                                            ? '--'
                                                            : '${items[index].winNumber}, ',
                                                        items[index].winNumber ==
                                                                5
                                                            ? 'Green White,'
                                                            : items[index]
                                                                        .winNumber ==
                                                                    0
                                                                ? 'orange white,'
                                                                : items[index]
                                                                            .winNumber ==
                                                                        null
                                                                    ? ''
                                                                    : items[index]
                                                                            .winNumber
                                                                            .isOdd
                                                                        ? 'green,'
                                                                        : 'orange,',
                                                        items[index].winNumber ==
                                                                null
                                                            ? ''
                                                            : items[index]
                                                                        .winNumber <
                                                                    5
                                                                ? 'small'
                                                                : 'Big',
                                                        Colors.white,
                                                        items[index].winNumber ==
                                                                null
                                                            ? Colors.orange
                                                            : items[index]
                                                                    .winNumber
                                                                    .isOdd
                                                                ? Colors.green
                                                                : Colors.orange,
                                                        items[index].winNumber ==
                                                                null
                                                            ? Colors.orange
                                                            : items[index]
                                                                        .winNumber <
                                                                    5
                                                                ? Colors.yellow
                                                                : Colors.blue),
                                                    historyDetails(
                                                        'Select',
                                                        items[index].number ==
                                                                50
                                                            ? 'small'
                                                            : items[index]
                                                                        .number ==
                                                                    40
                                                                ? 'big'
                                                                : items[index]
                                                                            .number ==
                                                                        10
                                                                    ? 'Green'
                                                                    : items[index].number ==
                                                                            20
                                                                        ? 'White'
                                                                        : items[index].number ==
                                                                                30
                                                                            ? 'Orange'
                                                                            : items[index].number.toString(),
                                                        Colors.white),
                                                    historyDetails(
                                                        'Status',
                                                        items[index].status == 0
                                                            ? 'Unpaid'
                                                            : items[index]
                                                                        .status ==
                                                                    2
                                                                ? 'Failed'
                                                                : 'Succeed',
                                                        items[index].status == 0
                                                            ? Colors.white
                                                            : items[index]
                                                                        .status ==
                                                                    2
                                                                ? Colors.red
                                                                : Colors.green),
                                                    historyDetails(
                                                        'Win/Loss',
                                                        items[index].status == 0
                                                            ? '--'
                                                            : '₹${items[index].winAmount.toStringAsFixed(2)}',
                                                        items[index].status == 0
                                                            ? Colors.white
                                                            : items[index]
                                                                        .status ==
                                                                    2
                                                                ? Colors.red
                                                                : Colors.green),
                                                    historyDetails(
                                                        'Order time',
                                                        items[index]
                                                            .createdAt
                                                            .toString(),
                                                        Colors.white),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                      responseStatuscode == 400
                                          ? Container()
                                          : Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                GestureDetector(
                                                  onTap: limitResult == 0
                                                      ? () {}
                                                      : () {
                                                          setState(() {
                                                            pageNumber--;
                                                            limitResult =
                                                                limitResult -
                                                                    10;
                                                            offsetResult =
                                                                offsetResult -
                                                                    10;
                                                          });
                                                          setState(() {});
                                                          BettingHistory();
                                                        },
                                                  child: Container(
                                                    height: height * 0.06,
                                                    width: width * 0.10,
                                                    decoration: BoxDecoration(
                                                      gradient: AppColors
                                                          .loginSecondryGrad,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: const Icon(
                                                      Icons.navigate_before,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 16),
                                                textWidget(
                                                  text: '$pageNumber/${items.length}',
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w600,
                                                  color: AppColors
                                                      .primaryTextColor,
                                                  maxLines: 1,
                                                ),
                                                const SizedBox(width: 16),
                                                GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      limitResult =
                                                          limitResult + 10;
                                                      offsetResult =
                                                          offsetResult + 10;
                                                      pageNumber++;
                                                    });
                                                    setState(() {});
                                                    BettingHistory();
                                                  },
                                                  child: Container(
                                                    height: height * 0.06,
                                                    width: width * 0.10,
                                                    decoration: BoxDecoration(
                                                      gradient: AppColors
                                                          .loginSecondryGrad,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: const Icon(
                                                        Icons.navigate_next,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ],
                                            ),
                                    ],
                                  ),
                                )
            ],
          )
        : Container();
  }

  int limitResult = 10;
  int offsetResult = 0;

  game_winPopup() async {
    UserModel user = await userProvider.getUser();
    String userid = user.id.toString();
    final response = await http.get(
        Uri.parse('${ApiUrl.game_win}$userid&gamesno=$period&gameid=$gameid'));

    var data = jsonDecode(response.body);
    if (kDebugMode) {
      print('${ApiUrl.game_win}$userid&gamesno=$period&gameid=$gameid');
      print('nbnbnbnbn');
    }
    if (data["status"] == "200") {
      var totalamount = data["totalamount"];
      var win = data["win"];
      var gamesno = data["gamesno"];
      var gameid = data["gameid"];
      if (kDebugMode) {
        print('rrrrrrrr');
      }
      // showPopup(context,totalamount,win,gamesno,gameid);
      // Future.delayed(const Duration(seconds: 5), () {
      //   Navigator.of(context).pop();
      // });
      // ImageToast.showloss(text: gamesno, subtext: totalamount, subtext1: win, subtext2:gameid,context: context,);
    } else {
      setState(() {
        // loadingGreen = false;
      });
      // Utils.flushBarErrorMessage(data['msg'], context, Colors.black);
    }
  }

  void showPopup(BuildContext context, String totalamount, String win,
      String gamesno, String gameids) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(14))),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              textWidget(
                text: "Win Go :",
                fontSize: 12,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              textWidget(
                text: gameids == '1'
                    ? '1 Min'
                    : gameids == '2'
                        ? '3 Min'
                        : gameids == '3'
                            ? '5 Min'
                            : '10 Min',
                fontSize: 14,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
          content: SizedBox(
            height: 180,
            child: Column(
              children: [
                ListTile(
                  leading: textWidget(
                    text: "Game S.No.:",
                    fontSize: 12,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  trailing: textWidget(
                    text: gamesno,
                    fontSize: 12,
                    color: AppColors.secondaryTextColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ListTile(
                  leading: textWidget(
                    text: "Total Bet Amount:",
                    fontSize: 12,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  trailing: textWidget(
                    text: totalamount,
                    fontSize: 12,
                    color: AppColors.secondaryTextColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ListTile(
                  leading: textWidget(
                    text: "Total Win Amount:",
                    fontSize: 12,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  trailing: textWidget(
                    text: win,
                    fontSize: 12,
                    color: AppColors.secondaryTextColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  ///chart page
  Widget ChartScreen() {
    setState(() {});
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: ChartAlphabetRow(),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 15),
          margin: const EdgeInsets.only(left: 10, right: 10),
          decoration: const BoxDecoration(
              color: AppColors.percentageColor,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10), topLeft: Radius.circular(10))),
          child: Row(
            //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.center,
                width: width * 0.3,
                child: textWidget(
                    text: 'Period',
                    fontSize: 14,
                    fontWeight: FontWeight.w900,
                    color: AppColors.primaryTextColor),
              ),
              const SizedBox(
                width: 40,
              ),
              Container(
                alignment: Alignment.center,
                width: width * 0.21,
                child: textWidget(
                    text: 'Number',
                    fontSize: 14,
                    fontWeight: FontWeight.w900,
                    color: AppColors.primaryTextColor),
              ),
            ],
          ),
        ),
        Column(
          children: List.generate(
            gameResult.length,
            (index) {
              return Container(
                margin: const EdgeInsets.only(left: 10, right: 10),
                height: 30,
                width: width * 0.97,
                decoration: const BoxDecoration(color: AppColors.FirstColor),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    textWidget(
                        text: gameResult[index].gamesno.toString(),
                        color: Colors.white),
                    Row(
                        children: generateNumberWidgets(
                            int.parse(gameResult[index].number.toString()))),
                    Container(
                      height: 15,
                      width: 15,
                      margin: const EdgeInsets.all(2),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        //border: Border.all(width: 1,color: ),
                        shape: BoxShape.circle,
                        gradient:
                            int.parse(gameResult[index].number.toString()) < 5
                                ? AppColors.btnBlueGradient
                                : AppColors.btnYellowGradient,
                      ),
                      child: textWidget(
                        text: int.parse(gameResult[index].number.toString()) < 5
                            ? 'L'
                            : 'H',
                        color: AppColors.primaryTextColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Container(
                      height: 15,
                      width: 15,
                      margin: const EdgeInsets.all(2),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        //border: Border.all(width: 1,color: ),
                        shape: BoxShape.circle,
                        color: int.parse(gameResult[index].number.toString())
                                .isEven
                            ? AppColors.wingoVioletColor
                            : AppColors.wingoGreenColor,
                      ),
                      child: textWidget(
                        text: int.parse(gameResult[index].number.toString())
                                .isEven
                            ? 'E'
                            : 'O',
                        color: AppColors.primaryTextColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        SizedBox(
          height: height * 0.02,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: limitResult == 0
                  ? () {}
                  : () {
                      setState(() {
                        pageNumber--;
                        limitResult = limitResult - 10;
                        offsetResult = offsetResult - 10;
                      });
                      setState(() {});
                      gameHistoryResult();
                    },
              child: Container(
                height: height * 0.06,
                width: width * 0.10,
                decoration: BoxDecoration(
                  gradient: AppColors.goldenGradientDir,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.navigate_before,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(width: 16),
            textWidget(
              text: '$pageNumber',
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.secondaryTextColor,
              maxLines: 1,
            ),
            const SizedBox(width: 16),
            GestureDetector(
              onTap: () {
                setState(() {
                  limitResult = limitResult + 10;
                  offsetResult = offsetResult + 10;
                  pageNumber++;
                });
                setState(() {});
                gameHistoryResult();
              },
              child: Container(
                height: height * 0.06,
                width: width * 0.10,
                decoration: BoxDecoration(
                  gradient: AppColors.goldenGradientDir,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.navigate_next, color: Colors.white),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // int selectedTabIndex=-5;

  Widget buildTabContainer(
      String label, int index, double width, Color selectedTextColor) {
    return InkWell(
      onTap: () {
        setState(() {
          selectedTabIndex = index;
        });
        BettingHistory();
      },
      child: Container(
        height: 40,
        width: width / 3.3,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            gradient: selectedTabIndex == index
                ? AppColors.loginSecondryGrad
                : AppColors.primaryUnselectedGradient,
            borderRadius: BorderRadius.circular(8)),
        child: Text(
          label,
          style: TextStyle(
            fontSize: width / 24,
            fontWeight:
                selectedTabIndex == index ? FontWeight.bold : FontWeight.w500,
            color: selectedTabIndex == index
                ? AppColors.primaryTextColor
                : AppColors.primaryTextColor,
          ),
        ),
      ),
    );
  }

  UserViewProvider userProvider = UserViewProvider();

  List<ResultGameHistory> gameResult = [];
  Future<void> gameHistoryResult() async {
    final response = await http.get(
      Uri.parse('${ApiUrl.resultList}$gameid&limit=10&offset=$offsetResult'),
    );
    if (kDebugMode) {
      print(ApiUrl.changeAvtarList);
      print('changeAvtarList');
    }
    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body)['data'];
      setState(() {
        gameResult = responseData
            .map((item) => ResultGameHistory.fromJson(item))
            .toList();
      });
    } else if (response.statusCode == 400) {
      if (kDebugMode) {
        print('Data not found');
      }
    } else {
      setState(() {
        gameResult = [];
      });
      throw Exception('Failed to load data');
    }
  }

  Future<void> gameHistoryResult1() async {
    final response = await http.get(
      Uri.parse('${ApiUrl.resultList}$gameid&limit=1'),
    );
    if (kDebugMode) {
      print(ApiUrl.changeAvtarList);
      print('changeAvtarList');
    }
    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body)['data'];
      setState(() {
        period = int.parse(responseData[0]['gamesno'].toString()) + 1;
        GameResults = responseData[0]['number'];

      });
      _handleSlotMachineTap();
    } else if (response.statusCode == 400) {
      if (kDebugMode) {
        print('Data not found');
      }
    } else {
      setState(() {
        gameResult = [];
      });
      throw Exception('Failed to load data');
    }
  }

  List<BettingHistoryModel> items = [];
  Future<void> BettingHistory() async {
    UserModel user = await userProvider.getUser();
    String token = user.id.toString();
    final response = await http.get(
      Uri.parse(
          '${ApiUrl.betHistory}$token&game_id=$gameid&limit=10&offset=$offsetResult'),
    );
    if (kDebugMode) {
      print(
          '${ApiUrl.betHistory}$token&game_id=$gameid&limit=10&offset=$offsetResult');
      print('betHistory+token');
    }

    setState(() {
      responseStatuscode = response.statusCode;
    });

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body)['data'];
      setState(() {
        items = responseData
            .map((item) => BettingHistoryModel.fromJson(item))
            .toList();
      });
    } else if (response.statusCode == 400) {
      if (kDebugMode) {
        print('Data not found');
      }
    } else {
      setState(() {
        items = [];
      });
      throw Exception('Failed to load data');
    }
  }

  BaseApiHelper baseApiHelper = BaseApiHelper();

  gameconcept(int countdownSeconds) {
    if (countdownSeconds == 6) {
      setState(() {
        create = true;
      });
      if (kDebugMode) {
        print('5 sec left');
      }
    }  if (countdownSeconds == 3) {

        gameHistoryResult1();
    }
    else if (countdownSeconds == 0) {
      setState(() {
        create = false;
      });
      gameHistoryResult();
      print('0 sec left');
    } else {}
  }
}

Widget buildTime1(int time) {
  Duration myDuration = Duration(seconds: time);
  String strDigits(int n) => n.toString().padLeft(2, '0');
  final minutes = strDigits(myDuration.inMinutes.remainder(11));
  final seconds = strDigits(myDuration.inSeconds.remainder(60));
  return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
    buildTimeCard(time: minutes[0].toString(), header: 'MINUTES'),
    const SizedBox(
      width: 3,
    ),
    buildTimeCard(time: minutes[1].toString(), header: 'MINUTES'),
    const SizedBox(
      width: 5,
    ),
    buildTimeCard1(time: ':', header: 'MINUTES'),
    const SizedBox(
      width: 5,
    ),
    buildTimeCard(time: seconds[0].toString(), header: 'SECONDS'),
    const SizedBox(
      width: 3,
    ),
    buildTimeCard(time: seconds[1].toString(), header: 'SECONDS'),
  ]);
}

Widget buildTimeCard({required String time, required String header}) => Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: AppColors.methodblue,
              borderRadius: BorderRadius.circular(4)),
          child: Text(
            time,
            style: const TextStyle(
                fontWeight: FontWeight.w900,
                color: AppColors.whiteColor,
                fontSize: 16),
          ),
        ),
      ],
    );
Widget buildTimeCard1({required String time, required String header}) => Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          time,
          style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.whiteColor,
              fontSize: 15),
        ),
      ],
    );

Widget buildTime5sec(int time) {
  Duration myDuration = Duration(seconds: time);
  String strDigits(int n) => n.toString().padLeft(2, '0');
  final seconds = strDigits(myDuration.inSeconds.remainder(60));

  return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
    buildTimeCard5sec(time: seconds[0].toString(), header: 'SECONDS'),
    const SizedBox(width: 15),
    buildTimeCard5sec(time: seconds[1].toString(), header: 'SECONDS'),
  ]);
}

Widget buildTimeCard5sec({required String time, required String header}) =>
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
              gradient: AppColors.loginSecondryGrad,
              borderRadius: BorderRadius.circular(10)),
          child: Text(
            time,
            style: const TextStyle(
                fontWeight: FontWeight.w800,
                color: AppColors.primaryTextColor,
                fontSize: 100),
          ),
        )
      ],
    );

historyDetails(String title, String subtitle, Color subColor) {
  return Column(
    children: [
      const SizedBox(height: 8.0),
      Container(
        height: height * 0.05,
        width: width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.FirstColor),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Colors.white),
              ),
              Text(
                subtitle,
                style: TextStyle(
                    fontSize: 12, fontWeight: FontWeight.w700, color: subColor),
              )
            ],
          ),
        ),
      ),
    ],
  );
}

historyWinDetails(String title, String subtitle, String subtitle1,
    String subtitle2, Color subColor, Color subColor1, Color subColor2) {
  return Column(
    children: [
      const SizedBox(height: 8.0),
      Container(
        height: height * 0.05,
        width: width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.FirstColor),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Colors.white),
              ),
              Row(
                children: [
                  Text(
                    subtitle,
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: subColor),
                  ),
                  Text(
                    subtitle1,
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: subColor1),
                  ),
                  Text(
                    subtitle2,
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: subColor2),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    ],
  );
}

class TimeDigit extends StatelessWidget {
  final int value;
  const TimeDigit({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      padding: const EdgeInsets.all(5),
      child: Text(
        value.toString(),
        style: const TextStyle(
          color: Colors.red,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class Winlist {
  int gameid;
  String title;
  String subtitle;
  int time;

  Winlist(this.gameid, this.title, this.subtitle, this.time);
}

class AlfaBate {
  int Alfaid;
  String title;

  AlfaBate(
    this.Alfaid,
    this.title,
  );
}

class Notfounddata extends StatelessWidget {
  const Notfounddata({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image(
          image: const AssetImage(Assets.imagesNoDataAvailable),
          height: height / 3,
          width: width / 2,
        ),
        SizedBox(height: height * 0.07),
        const Text(
          "Data not found",
        )
      ],
    );
  }
}

List<Widget> generateNumberWidgets(int parse) {
  return List.generate(10, (index) {
    List<Color> colors = [
      AppColors.FirstColor,
      AppColors.FirstColor,
    ];

    if (index == parse) {
      colors = [
        AppColors.gradientFirstColor,
        AppColors.gradientFirstColor,
      ];
    }

    return Container(
      height: 15,
      width: 15,
      margin: const EdgeInsets.all(2),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: index == parse
              ? Colors.transparent
              : AppColors.gradientFirstColor,
        ),
        gradient: LinearGradient(
          colors: colors,
          stops: const [0.5, 0.5],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          tileMode: TileMode.mirror,
        ),
      ),
      child: Center(
        child: Text(
          '$index',
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            color: index == parse
                ? AppColors.primaryTextColor
                : AppColors.gradientFirstColor,
          ),
        ),
      ),
    );
  });
}

class GradientTextview extends StatelessWidget {
  const GradientTextview(
    this.text, {
    super.key,
    required this.gradient,
    this.style,
  });

  final String text;
  final TextStyle? style;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(text, style: style),
    );
  }
}
