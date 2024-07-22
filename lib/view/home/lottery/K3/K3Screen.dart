// ignore_for_file: depend_on_referenced_packages, library_private_types_in_public_api, non_constant_identifier_names, use_build_context_synchronously, camel_case_types
import 'dart:async';
import 'dart:convert';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:win4cash/main.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:win4cash/generated/assets.dart';
import 'package:win4cash/model/bettingHistory_Model.dart';
import 'package:win4cash/model/result_game_history.dart';
import 'package:win4cash/model/user_model.dart';
import 'package:win4cash/res/aap_colors.dart';
import 'package:win4cash/res/api_urls.dart';
import 'package:win4cash/res/app_constant.dart';
import 'package:win4cash/res/components/app_bar.dart';
import 'package:win4cash/res/components/app_btn.dart';
import 'package:win4cash/res/components/text_widget.dart';
import 'package:win4cash/res/helper/api_helper.dart';
import 'package:win4cash/res/provider/user_view_provider.dart';
import 'package:win4cash/res/provider/wallet_provider.dart';
import 'package:win4cash/utils/how_to_play.dart';
import 'package:win4cash/view/account/service_center/custmor_service.dart';
import 'package:win4cash/view/auth/constant_wallet.dart';
import 'package:win4cash/view/home/lottery/5d/trangle_painter.dart';
import 'package:win4cash/view/home/lottery/K3/dummygridK3.dart';
import 'package:win4cash/view/home/lottery/K3/k_3_slotmachine/slotmachine.dart';
import 'package:win4cash/view/home/widgets/game_anuncement.dart';
import 'package:provider/provider.dart';

class Big {
  String type;
  String amount;
  final Color color;
  Big(this.type, this.amount, this.color);
}

class Digitselect {
  String digit;
  String setdigit;
  Digitselect(this.digit, this.setdigit);
}

class ScreenK3 extends StatefulWidget {
  const ScreenK3({super.key});

  @override
  _ScreenK3State createState() => _ScreenK3State();
}

class _ScreenK3State extends State<ScreenK3>
    with SingleTickerProviderStateMixin {
  late int selectedCatIndex;
  late TabController _tabController;
  double containerHeight = 0;
  @override
  void initState() {
    startCountdown();
    walletfetch();
    gameHistoryResult();
    GamehistoryTRX(1);
    gameHistoryResult1();
    BettingHistory();
    super.initState();
    selectedCatIndex = 0;
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(_setHeight);
    _setHeight();
  }

  void _setHeight() {
    setState(() {
      switch (_tabController.index) {
        case 0:
          containerHeight = height * 0.65;
          break;
        case 1:
          containerHeight = height * 0.4;
          break;
        case 2:
          containerHeight = height * 0.3;
          break;
        case 3:
          containerHeight = height * 0.45;
          break;
        default:
          containerHeight = height * 0.4;
      }
    });
  }

  int selectedContainerIndex = -1;

  List<BetNumbers> betNumbers = [
    BetNumbers(Assets.images0, Colors.red, Colors.purple, "0"),
    BetNumbers(Assets.images1, Colors.green, Colors.green, "1"),
    BetNumbers(Assets.images2, Colors.red, Colors.red, "2"),
    BetNumbers(Assets.images3, Colors.green, Colors.green, "3"),
    BetNumbers(Assets.images4, Colors.red, Colors.red, "4"),
    BetNumbers(Assets.images5, Colors.red, Colors.purple, "5"),
    BetNumbers(Assets.images6, Colors.red, Colors.red, "6"),
    BetNumbers(Assets.images7, Colors.green, Colors.green, "7"),
    BetNumbers(Assets.images8, Colors.red, Colors.red, "8"),
    BetNumbers(Assets.images9, Colors.green, Colors.green, "9"),
  ];

  List<Winlist> list = [
    Winlist(1, "K3 Lotre", "1 Min", 60),
    Winlist(2, "K3 Lotre", "3 Min", 180),
    Winlist(3, "K3 Lotre", "5 Min", 300),
    Winlist(4, "K3 Lotre", "10 Min", 600),
  ];

  List<TotalWidget> totalitems = [
    TotalWidget(Assets.imagesRedplainK3, "3", "207.36X", Colors.red),
    TotalWidget(Assets.imagesGreenplainK3, "4", "69.36X", Colors.green),
    TotalWidget(Assets.imagesRedplainK3, "5", "34.36X", Colors.red),
    TotalWidget(Assets.imagesGreenplainK3, "6", "20.36X", Colors.green),
    TotalWidget(Assets.imagesRedplainK3, "7", "13.36X", Colors.red),
    TotalWidget(Assets.imagesGreenplainK3, "8", "207.36X", Colors.green),
    TotalWidget(Assets.imagesRedplainK3, "9", "07.36X", Colors.red),
    TotalWidget(Assets.imagesGreenplainK3, "10", "27.36X", Colors.green),
    TotalWidget(Assets.imagesRedplainK3, "11", "207.36X", Colors.red),
    TotalWidget(Assets.imagesGreenplainK3, "12", "7.36X", Colors.green),
    TotalWidget(Assets.imagesRedplainK3, "13", "27.36X", Colors.red),
    TotalWidget(Assets.imagesGreenplainK3, "14", "7.36X", Colors.green),
    TotalWidget(Assets.imagesRedplainK3, "15", "207.36X", Colors.red),
    TotalWidget(Assets.imagesGreenplainK3, "16", "207.36X", Colors.green),
    TotalWidget(Assets.imagesRedplainK3, "17", "207.36X", Colors.red),
    TotalWidget(Assets.imagesGreenplainK3, "18", "207.36X", Colors.green),
  ];

  int countdownSeconds = 60;
  int gameseconds = 60;
  String gametitle = 'K3 Lotre';
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
        walletfetch();
        gameHistoryResult();
        GamehistoryTRX(1);
        BettingHistory();
        game_winPopup();
      } else if (countdownSeconds == 59) {}
      countdownSeconds = (countdownSeconds - 1);
    });
  }

  int? responseStatuscode;

  @override
  void dispose() {
    countdownSeconds.toString();
    _tabController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  List<Big> SizeTypelist = [
    Big("Big", "1.98", Colors.yellow),
    Big("Small", "1.98", Colors.blue),
    Big("Even", "1.98", Colors.green),
    Big("Odd", "1.98", Colors.red),
  ];

  List<int> sametwoitemone = [11, 22, 33, 44, 55, 66];
  List<int> sametwoitemtwo = [11, 22, 33, 44, 55, 66];
  List<int> sametwoitemthree = [1, 2, 3, 4, 5, 6];
  List<int> samethreeitemone = [111, 222, 333, 444, 555, 666];
  List<int> differentitemone = [1, 2, 3, 4, 5, 6];
  int? showalphabet = 0;

  String? selectedAlphabet;
  String? selectedSizeType;
  String? selectedNumberType;
  String pankajtest = '143';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.scaffolddark,
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
                          //  ()

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
          child: Column(
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
                                ? Image.asset(Assets.iconsTimeColor, height: 70)
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
                                    return const HowToPlay(type:AppConstants.k3GameRule);
                                  });
                              // Navigator.push(context, MaterialPageRoute(builder: (context)=>const HowtoplayScreen()));
                            },
                            child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                height: 26,
                                width: width * 0.3,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    border: Border.all(
                                        color: AppColors.gradientFirstColor)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      Assets.iconsHowtoplay,
                                      height: 16,
                                    ),
                                    const Text(
                                      ' How to Play',
                                      style: TextStyle(
                                          color: AppColors.gradientFirstColor),
                                    ),
                                  ],
                                )),
                          ),
                          const Spacer(),
                          const Text(
                            'Time remaining',
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
                      SlotMachineView(),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      create == false
                          ? Column(
                              children: [
                                DefaultTabController(
                                  length: 4,
                                  child: TabBar(
                                    unselectedLabelColor: Colors
                                        .grey, // Set your custom unselected label color here
                                    indicator: const BoxDecoration(
                                        color: AppColors.gradientFirstColor,
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(10),
                                            topLeft: Radius.circular(10))),
                                    controller: _tabController,

                                    tabs: [
                                      Tab(
                                        child: textWidget(
                                            text: "Total",
                                            textAlign: TextAlign.center,
                                            fontSize: width * 0.03,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                      Tab(
                                        child: textWidget(
                                            text: "2 same",
                                            textAlign: TextAlign.center,
                                            fontSize: width * 0.03,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                      Tab(
                                        child: textWidget(
                                            text: "3 same",
                                            textAlign: TextAlign.center,
                                            fontSize: width * 0.03,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                      Tab(
                                        child: textWidget(
                                            text: "Different",
                                            textAlign: TextAlign.center,
                                            fontSize: width * 0.03,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: containerHeight,
                                  child: TabBarView(
                                    physics: const BouncingScrollPhysics(),
                                    controller: _tabController,
                                    children: [
                                      Total(),
                                      Same2(),
                                      Same3(),
                                      Different()
                                    ],
                                  ),
                                ),
                              ],
                            )
                          : Stack(
                              children: [
                                const DummygridK3(),
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
        ));
  }

  late SlotMachineImageController _numberController;
  bool _isSlotMachineRunning = false;

  void _handleSlotMachineTap() {
    if (!_isSlotMachineRunning) {
      final input = pankajtest;
      // '${GameResults}23';
      if (input.length == 3 && input.runes.every((r) => r >= 49 && r <= 54)) {
        final selectedNumbers = input.runes.map((r) => r - 48).toList();
        setState(() {
          _isSlotMachineRunning = true;
          _numberController.start(hitRollItemIndexes: selectedNumbers);
          for (int i = 0; i < 3; i++) {
            Future.delayed(Duration(seconds: 1 + i), () {
              _numberController.stop(
                  reelIndex: i, resultIndex: selectedNumbers[i]);
              if (i == 2) {
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
    }
  }

  void _showInvalidNumberDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Invalid Number"),
          content: const Text("Please enter a number between 111 and 666."),
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

  final Map<int, String> digitToImageMap = {
    1: Assets.k3Bigdice1,
    2: Assets.k3Bigdice2,
    3: Assets.k3Bigdice3,
    4: Assets.k3Bigdice4,
    5: Assets.k3Bigdice5,
    6: Assets.k3Bigdice6,
  };

  Widget SlotMachineView() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          right: -8,
          top: 47.0,
          child: Container(
            height: 30,
            width: 15,
            decoration: const BoxDecoration(
                color: Color(0xFF4675D2),
                borderRadius: BorderRadius.only(
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
            decoration: const BoxDecoration(
                color: Color(0xFF4675D2),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(5),
                    topLeft: Radius.circular(5))),
          ),
        ),
        Container(
          decoration: BoxDecoration(
              color: AppColors.FirstColor,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(width: 10, color: const Color(0xFF4675D2))),
          child: Center(
            child: SlotMachineNumber(
              rollItems: List.generate(
                6,
                (index) => RollItemNumber(
                  index: index + 1, // Adjust index to start from 1
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
              digitToImageMap: digitToImageMap,
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
            offset: const Offset(0, -32.0), // Translate by -50% of 64.0 height
            child: CustomPaint(
              size: const Size(30.53, 16.0), // Width and height of the triangle
              painter: TrianglePainter(),
            ),
          ),
        ),
        Positioned(
          left: 0,
          top: 86.0, // 50% of 64.0 height (to center vertically)
          child: Transform.translate(
            offset: const Offset(0, -32.0), // Translate by -50% of 64.0 height
            child: CustomPaint(
              size: const Size(30.53, 16.0), // Width and height of the triangle
              painter: TrianglePainter2(),
            ),
          ),
        ),
      ],
    );
  }

  /// how to play ke pass wala api
  bool create = false;
  int period = 0;
  int gameid = 1;

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

  int GameResults = 0;
  List<ResultGameHistory> gameResult = [];
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

  ///condition for obscure text
  String obscureCenterDigits(String input) {
    if (input.length < 4) {
      return input; // If the input is shorter than 4 characters, return the original string
    }

    // Get the length of the input string
    int length = input.length;

    // Calculate the start index for obscuring
    int startIndex = (length ~/ 2) - 1;

    // Calculate the end index for obscuring
    int endIndex = (length ~/ 2) + 1;

    // Create a List of characters from the input string
    List<String> chars = input.split('');

    // Replace characters in the specified range with asterisks
    for (int i = startIndex; i <= endIndex; i++) {
      chars[i] = '*';
    }

    // Join the List of characters back into a single string
    return chars.join('');
  }

  int pageNumber = 1;
  int selectedTabIndex = 0;

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
      // ImageToastTRX.showwin(text: gamesno, subtext: totalamount, subtext1: win, subtext2:gameid,context: context,);
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

  bool areConsecutive(String numberStr) {
    List<int> digits = numberStr.split('').map(int.parse).toList();
    digits.sort();
    for (int i = 1; i < digits.length; i++) {
      if (digits[i] != digits[i - 1] + 1) {
        return false;
      }
    }
    return true;
  }

  String analyzeNumber(int number) {
    String numberStr = number.toString();
    Set<String> uniqueDigits = numberStr.split('').toSet();

    if (uniqueDigits.length == 1) {
      return "Same number";
    } else if (uniqueDigits.length == 2) {
      return "2 same number";
    } else if (areConsecutive(numberStr)) {
      return "3 consecutive numbers";
    } else {
      return "3 different numbers";
    }
  }

  ///chart page
  Widget ChartScreen() {
    setState(() {});

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 15),
          margin: const EdgeInsets.only(left: 10, right: 10),
          decoration: const BoxDecoration(
              gradient: AppColors.primaryUnselectedGradient,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10), topLeft: Radius.circular(10))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.center,
                width: width * 0.25,
                child: textWidget(
                    text: 'Period',
                    fontSize: 14,
                    fontWeight: FontWeight.w900,
                    color: AppColors.primaryTextColor),
              ),
              Container(
                alignment: Alignment.center,
                width: width * 0.25,
                child: textWidget(
                    text: 'Result',
                    fontSize: 14,
                    fontWeight: FontWeight.w900,
                    color: AppColors.primaryTextColor),
              ),
              Container(
                alignment: Alignment.center,
                width: width * 0.35,
                child: textWidget(
                    text: 'Number',
                    fontSize: 14,
                    fontWeight: FontWeight.w900,
                    color: AppColors.primaryTextColor),
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 10, right: 10),
          decoration: const BoxDecoration(
              color: AppColors.FirstColor,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10))),
          child: Column(
            children: List.generate(
              gameResult.length,
              (index) {
                return Column(
                  children: [
                    SizedBox(
                      height: 30,
                      width: width * 0.97,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          textWidget(
                              text: gameResult[index].gamesno.toString(),
                              fontWeight: FontWeight.w900,
                              color: Colors.white),
                          Container(
                              alignment: Alignment.center,
                              width: width * 0.25,
                              height: 30,
                              child: ListView.builder(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 10),
                                  physics: const NeverScrollableScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemCount: pankajtest.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(left: 5.0),
                                      child: Container(
                                          height: 20,
                                          width: 20,
                                          // color: Colors.red,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: AssetImage(
                                                      'assets/k3/smalldice${pankajtest[index]}.png')))),
                                    );
                                  })),
                          textWidget(
                              text: analyzeNumber(int.parse(pankajtest)),
                              fontWeight: FontWeight.w900,
                              color: Colors.white),
                        ],
                      ),
                    ),
                    if (index != gameResult.length - 1)
                      Container(
                        margin: const EdgeInsets.only(left: 10, right: 10),
                        width: width,
                        color: Colors.grey,
                        height: 0.5,
                      ),
                  ],
                );
              },
            ),
          ),
        ),
        SizedBox(
          height: height * 0.02,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: pageNumber == 1
                  ? () {}
                  : () {
                setState(() {
                  pageNumber--;
                  limitResult = limitResult - 10;
                  offsetResult = offsetResult - 10;
                });
                setState(() {});
                gameHistoryResult();
                print(pageNumber);
                print('pageNumber');
              },
              child: Container(
                height: height * 0.06,
                width: width * 0.10,
                decoration: BoxDecoration(
                  color: pageNumber == 1?AppColors.bottomNavColor:AppColors.secondaryTextColor,
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
                  color:
                 // pageNumber == 1?AppColors.bottomNavColor:
                  AppColors.secondaryTextColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.navigate_next,
                    color: Colors.white),
              ),
            ),
          ],
        ),
      ],
    );
  }

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
                                    text: 'Sum',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w900,
                                    color: AppColors.primaryTextColor),
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: width * 0.21,
                                child: textWidget(
                                    text: 'Result',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w900,
                                    color: AppColors.primaryTextColor),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 10, right: 10),
                          decoration: const BoxDecoration(
                              color: AppColors.FirstColor,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10))),
                          child: ListView.builder(
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
                                        width: width * 0.35,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            textWidget(
                                                text: gameResult[index]
                                                    .number
                                                    .toString(),
                                                fontSize: 13,
                                                fontWeight: FontWeight.w900,
                                                color:
                                                    AppColors.primaryTextColor),
                                            textWidget(
                                                text:
                                                    gameResult[index].number < 9
                                                        ? 'Small'
                                                        : 'Big',
                                                fontSize: 13,
                                                fontWeight: FontWeight.w900,
                                                color:
                                                    AppColors.primaryTextColor),
                                            textWidget(
                                                text: gameResult[index]
                                                        .number
                                                        .isOdd
                                                    ? 'Odd'
                                                    : 'Even',
                                                fontSize: 13,
                                                fontWeight: FontWeight.w900,
                                                color:
                                                    AppColors.primaryTextColor)
                                          ],
                                        ),
                                      ),
                                      Container(
                                          alignment: Alignment.center,
                                          width: width * 0.21,
                                          height: 30,
                                          child: ListView.builder(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              scrollDirection: Axis.horizontal,
                                              shrinkWrap: true,
                                              itemCount: pankajtest.length,
                                              itemBuilder: (context, index) {
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 2.0),
                                                  child: Container(
                                                      height: 20,
                                                      width: 20,
                                                      // color: Colors.red,
                                                      decoration: BoxDecoration(
                                                          image: DecorationImage(
                                                              image: AssetImage(
                                                                  'assets/k3/smalldice${pankajtest[index]}.png')))),
                                                );
                                              })),
                                    ],
                                  ),
                                  if (index != gameResult.length - 1)
                                    Container(
                                      margin: const EdgeInsets.only(left: 10, right: 10),
                                      width: width,
                                      color: Colors.grey,
                                      height: 0.5,
                                    ),
                                ],
                              );
                            },
                          ),
                        ),
                        SizedBox(height: height * 0.02),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: pageNumber == 1
                                  ? () {}
                                  : () {
                                setState(() {
                                  pageNumber--;
                                  limitResult = limitResult - 10;
                                  offsetResult = offsetResult - 10;
                                });
                                setState(() {});
                                gameHistoryResult();
                                print(pageNumber);
                                print('pageNumber');
                              },
                              child: Container(
                                height: height * 0.06,
                                width: width * 0.10,
                                decoration: BoxDecoration(
                                  color: pageNumber == 1?AppColors.bottomNavColor:AppColors.secondaryTextColor,
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
                                  color:
                                  // pageNumber == 1?AppColors.bottomNavColor:
                                  AppColors.secondaryTextColor,
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
                                                SizedBox(
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
                                                  text:
                                                      '$pageNumber/${items.length}',
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

  List<BettingHistoryModel> items = [];
  Future<void> BettingHistory() async {
    UserModel user = await userProvider.getUser();
    String token = user.id.toString();
    final response = await http.get(
      Uri.parse('${ApiUrl.betHistory}$token&game_id=$gameid&limit=10&offset=$offsetResult'),
    );
    if (kDebugMode) {
      print('${ApiUrl.betHistory}$token&game_id=$gameid&limit=10&offset=$offsetResult');
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

  Future<void> walletfetch() async {
    try {
      if (kDebugMode) {
        print("qwerfghj");
      }
      final walletData = await baseApiHelper.fetchWalletData();
      if (kDebugMode) {
        print(walletData);
        print("wallet_data");
      }
      Provider.of<WalletProvider>(context, listen: false)
          .setWalletList(walletData!);
    } catch (error) {
      // Handle error here
      if (kDebugMode) {
        print("hiiii $error");
      }
    }
  }

  gameconcept(int countdownSeconds) {
    if (countdownSeconds == 6) {
      setState(() {
        create = true;
      });
      if (kDebugMode) {
        print('5 sec left');
      }
    }
    if (countdownSeconds == 3) {
      gameHistoryResult1();
    } else if (countdownSeconds == 0) {
      setState(() {
        create = false;
      });
      // gameHistoryResult();
      print('0 sec left');
    } else {}
  }

  ///tokentrx api (how to work jaha hai )
  final List<GameHistoryModel> _listdataResult = [];
  GamehistoryTRX(int gameid) async {
    // final gameid=widget.gameid;
    final response = await http.get(Uri.parse(
      "${ApiUrl.profile}limit=$limitResult&gameid=$gameid&offset=$offsetResult",
    ));
    if (kDebugMode) {
      print('pankaj');
      print(
          "${ApiUrl.profile}limit=$limitResult&gameid=$gameid&offset=$offsetResult");
      print(jsonDecode(response.body));
    }

    if (response.statusCode == 200) {
      _listdataResult.clear();
      if (kDebugMode) {
        print('hhhghgjt');
      }
      final jsonData = json.decode(response.body)['data'];
      for (var i = 0; i < jsonData.length; i++) {
        var period = jsonData[i]['gamesno'];
        var number = jsonData[i]['number'];
        var hash = jsonData[i]['hash'];
        var datetime = jsonData[i]['datetime'];
        var block = jsonData[i]['block'];
        if (kDebugMode) {
          print(period);
        }
        _listdataResult.add(GameHistoryModel(
            period: period.toString(),
            number: number.toString(),
            hash: hash,
            datetime: datetime,
            block: block));
      }
      setState(() {});
      // return jsonData.map((item) => partlyrecord.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  Widget Total() {
    return Column(
      children: [
        GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisSpacing: 8.0,
          ),
          shrinkWrap: true,
          itemCount: totalitems.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                Container(
                  height: height * 0.08,
                  width: width * 0.15,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(totalitems[index].image),
                          fit: BoxFit.fill)),
                  child: Center(
                    child: textWidget(
                        text: totalitems[index].title,
                        fontSize: width * 0.05,
                        fontWeight: FontWeight.bold,
                        color: totalitems[index].color),
                  ),
                ),
                textWidget(
                    text: totalitems[index].Subtitle,
                    fontSize: width * 0.034,
                    color: Colors.grey)
              ],
            );
          },
        ),
        SizedBox(
          height: height * 0.02,
        ),
        Row(
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
                      color: SizeTypelist[index].color,
                      borderRadius: BorderRadius.circular(6)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      textWidget(
                          text: SizeTypelist[index].type,
                          fontSize: width * 0.04,
                          color: Colors.white),
                      textWidget(
                          text: SizeTypelist[index].amount,
                          fontSize: width * 0.04,
                          color: Colors.white),
                    ],
                  ),
                ),
              ),
            )),
      ],
    );
  }

  Widget Same2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: height * 0.03,
        ),
        textWidget(
            text: "2 matching numbers:odds(13.83)",
            color: Colors.white,
            fontSize: width * 0.04),
        SizedBox(
          height: height * 0.03,
        ),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              sametwoitemone.length,
              (index) => Padding(
                padding: const EdgeInsets.all(2.0),
                child: Container(
                  height: 40,
                  width: 45,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: const Color(0xff784a9c),
                      borderRadius: BorderRadius.circular(6)),
                  child: textWidget(
                      text: sametwoitemone[index].toString(),
                      fontSize: width * 0.04,
                      color: Colors.white),
                ),
              ),
            )),
        SizedBox(
          height: height * 0.03,
        ),
        textWidget(
            text: "A pair of unique numbers: odds(69.12)",
            color: Colors.white,
            fontSize: width * 0.04),
        SizedBox(
          height: height * 0.03,
        ),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              sametwoitemtwo.length,
              (index) => Padding(
                padding: const EdgeInsets.all(2.0),
                child: Container(
                  height: 40,
                  width: 45,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: const Color(0xfffb9494),
                      borderRadius: BorderRadius.circular(6)),
                  child: textWidget(
                      text: sametwoitemtwo[index].toString(),
                      fontSize: width * 0.04,
                      color: Colors.white),
                ),
              ),
            )),
        SizedBox(height: height * 0.02),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              sametwoitemthree.length,
              (index) => Padding(
                padding: const EdgeInsets.all(2.0),
                child: Container(
                  height: 40,
                  width: 45,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: const Color(0xff3d7456),
                      borderRadius: BorderRadius.circular(6)),
                  child: textWidget(
                      text: sametwoitemthree[index].toString(),
                      fontSize: width * 0.04,
                      color: Colors.white),
                ),
              ),
            )),
      ],
    );
  }

  Widget Same3() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: height * 0.03,
        ),
        textWidget(
            text: "3 of the same number:odds(207.36)",
            color: Colors.white,
            fontSize: width * 0.04),
        SizedBox(
          height: height * 0.03,
        ),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              samethreeitemone.length,
              (index) => Padding(
                padding: const EdgeInsets.all(2.0),
                child: Container(
                  height: 40,
                  width: 45,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: const Color(0xff784a9c),
                      borderRadius: BorderRadius.circular(6)),
                  child: textWidget(
                      text: samethreeitemone[index].toString(),
                      fontSize: width * 0.04,
                      color: Colors.white),
                ),
              ),
            )),
        SizedBox(
          height: height * 0.03,
        ),
        textWidget(
            text: "Any 3 of the same numbers: odds(34.56)",
            color: Colors.white,
            fontSize: width * 0.04),
        SizedBox(
          height: height * 0.03,
        ),
        Container(
          height: height * 0.05,
          width: width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color(0xfffb9494)),
          child: Center(
            child: textWidget(
                text: "Any 3 of the same number: odds ",
                fontSize: width * 0.04,
                color: Colors.white),
          ),
        )
      ],
    );
  }

  Widget Different() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: height * 0.03,
        ),
        textWidget(
            text: "3 different number:odds(207.36)",
            color: Colors.white,
            fontSize: width * 0.04),
        SizedBox(
          height: height * 0.03,
        ),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              differentitemone.length,
              (index) => Padding(
                padding: const EdgeInsets.all(2.0),
                child: Container(
                  height: 40,
                  width: 45,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: const Color(0xff784a9c),
                      borderRadius: BorderRadius.circular(6)),
                  child: textWidget(
                      text: differentitemone[index].toString(),
                      fontSize: width * 0.04,
                      color: Colors.white),
                ),
              ),
            )),
        SizedBox(
          height: height * 0.03,
        ),
        textWidget(
            text: " 3 continuous numbers: odds(34.56)",
            color: Colors.white,
            fontSize: width * 0.04),
        SizedBox(
          height: height * 0.03,
        ),
        Container(
          height: height * 0.05,
          width: width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color(0xfffb9494)),
          child: Center(
            child: textWidget(
                text: " 3 continuous numbers ",
                fontSize: width * 0.04,
                color: Colors.white),
          ),
        ),
        SizedBox(
          height: height * 0.03,
        ),
        textWidget(
            text: " 2 different numbers: odds(34.56)",
            color: Colors.white,
            fontSize: width * 0.04),
        SizedBox(
          height: height * 0.03,
        ),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              differentitemone.length,
              (index) => Padding(
                padding: const EdgeInsets.all(2.0),
                child: Container(
                  height: 40,
                  width: 45,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: const Color(0xff784a9c),
                      borderRadius: BorderRadius.circular(6)),
                  child: textWidget(
                      text: differentitemone[index].toString(),
                      fontSize: width * 0.04,
                      color: Colors.white),
                ),
              ),
            )),
      ],
    );
  }
}

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
      width: 3,
    ),
    buildTimeCard(time: ':', header: 'MINUTES'),
    const SizedBox(
      width: 3,
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

class BetNumbers {
  String photo;
  final Color colorone;
  final Color colortwo;
  String number;
  BetNumbers(this.photo, this.colorone, this.colortwo, this.number);
}

class Tokennumber {
  String photo;
  final Color colorone;
  final Color colortwo;
  String number;
  Tokennumber(this.photo, this.colorone, this.colortwo, this.number);
}

///howtoplay ke pass wala
class pertrecord {
  final String period;
  final String number;
  final String hashh;
  // final String datetime;
  // final String block;
  // final Color color;
  pertrecord(
    this.period,
    this.number,
    this.hashh,
    // this.datetime,
    // this.block
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

///gamehistory model
class GameHistoryModel {
  final String period;
  final String number;
  final String hash;
  final String datetime;
  final String block;

  GameHistoryModel({
    required this.period,
    required this.number,
    required this.hash,
    required this.datetime,
    required this.block,
  });
}

class TotalWidget {
  String image;
  String title;
  String Subtitle;
  final Color color;
  TotalWidget(this.image, this.title, this.Subtitle, this.color);
}

List<Widget> generateNumberWidgets(int parse) {
  return List.generate(10, (index) {
    List<Color> colors = [
      const Color(0xFFFFFFFF),
      const Color(0xFFFFFFFF),
    ];

    if (index == parse) {
      if (parse == 0) {
        colors = [
          const Color(0xFFfd565c),
          const Color(0xFFb659fe),
        ];
      } else if (parse == 5) {
        colors = [
          const Color(0xFF40ad72),
          const Color(0xFFb659fe),
        ];
      } else {
        colors = parse % 2 == 0
            ? [
                const Color(0xFFfd565c),
                const Color(0xFFfd565c),
              ]
            : [
                const Color(0xFF40ad72),
                const Color(0xFF40ad72),
              ];
      }
    }

    return Container(
      height: 20,
      width: 20,
      margin: const EdgeInsets.all(2),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(),
        gradient: LinearGradient(
            colors: colors,
            stops: const [
              0.5,
              0.5,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            tileMode: TileMode.mirror),
      ),
      child: textWidget(
        text: '$index',
        fontWeight: FontWeight.w600,
        color: index == parse ? AppColors.primaryTextColor : Colors.black,
      ),
    );
  });
}

Widget _rotate() {
  return Column(
    mainAxisSize: MainAxisSize.max,
    children: [
      DefaultTextStyle(
        style: const TextStyle(fontSize: 13, color: Colors.white),
        child: AnimatedTextKit(
            repeatForever: true,
            isRepeatingAnimation: true,
            animatedTexts: [
              RotateAnimatedText(
                  'Please Fill In The Correct Bank Card Information.'),
              RotateAnimatedText('Been Approved By The Platform. The Bank'),
              RotateAnimatedText(
                  'Will Complete The Transfer Within 1-7 Working Days,'),
              RotateAnimatedText(
                  'But Delays May Occur, Especially During Holidays.But'),
              RotateAnimatedText('You Are Guaranteed To Receive Your Funds.'),
            ]),
      ),
    ],
  );
}
