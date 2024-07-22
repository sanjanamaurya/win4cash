import 'dart:async';

import 'package:flutter/material.dart';
import 'package:win4cash/generated/assets.dart';
import 'package:win4cash/main.dart';
import 'package:win4cash/res/aap_colors.dart';
import 'package:win4cash/res/components/app_btn.dart';
import 'package:win4cash/res/components/text_widget.dart';
import 'package:win4cash/utils/routes/routes_name.dart';
import 'package:win4cash/view/home/lottery/5d/5d_screen.dart';
import 'package:win4cash/view/home/lottery/K3/K3Screen.dart';
import 'package:win4cash/view/home/lottery/trx/trx_screen.dart';
import 'package:win4cash/view/home/widgets/Classes/lottery_subfile.dart';

class LotteryPage extends StatefulWidget {
  final int sId;
  const LotteryPage({super.key, required this.sId});

  @override
  State<LotteryPage> createState() => _LotteryPageState();
}

class _LotteryPageState extends State<LotteryPage> {
  @override
  void initState() {
    startCountdown();
    super.initState();
  }

  int countdownSeconds = 60;
  Timer? countdownTimer;
  Future<void> startCountdown() async {
    DateTime now = DateTime.now().toUtc();

    int initialSeconds = 60 - now.second; // Calculate initial remaining seconds
    setState(() {
      countdownSeconds = initialSeconds;
    });

    countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      updateUI(timer);
    });
  }

  void updateUI(Timer timer) {
    setState(() {
      if (countdownSeconds == 60) {
      } else if (countdownSeconds == 1) {
        // Do something
      }
      countdownSeconds = (countdownSeconds - 1) % 60;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<PopularLottery> lotteryGameList = [
      PopularLottery(
        name: 'Win Go',
        image: Assets.categoryWingocoin1,
        onTap: () {
          Navigator.pushNamed(context, RoutesName.winGoScreen);
        },
      ),
      PopularLottery(
        name: 'Trx Win Go',
        image: Assets.categoryTrxcoin1,
        onTap: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => const TrxScreen()),
          // );
        },
      ),
      PopularLottery(
        name: 'K3',
        image: Assets.categoryK3,
        onTap: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => const ScreenK3()),
          // );
        },
      ),
      PopularLottery(
        name: '5D',
        image: Assets.categoryFivedCoin,
        onTap: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => const Screen5d()),
          // );
        },
      ),
    ];
    return Column(
      children: [
        widget.sId == 0
            ? Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.local_fire_department,
                          color: AppColors.gradientFirstColor,
                          size: 30,
                        ),
                        Text(
                          " Popular  Lottery".toUpperCase(),
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        )
                      ],
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            InkWell(
                              onTap: () {
                                //    Navigator.push(context, MaterialPageRoute(builder: (context)=>TrxScreen()));
                              },
                              child: Container(
                                height: height * 0.15,
                                width: width * 0.5,
                                decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                          Assets.categoryNewimg1,
                                        ),
                                        fit: BoxFit.fill)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    textWidget(
                                        text: '     Trx 1Min',
                                        fontWeight: FontWeight.w900,
                                        fontSize: 15,
                                        color: AppColors.primaryTextColor),
                                    textWidget(
                                        text: '      Countdown to Lottery',
                                        fontWeight: FontWeight.w700,
                                        fontSize: 12,
                                        color: AppColors.primaryTextColor),
                                    SizedBox(
                                      height: height * 0.01,
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: width * 0.05,
                                        ),
                                        Container(
                                          height: height * 0.045,
                                          width: width * 0.25,
                                          decoration: const BoxDecoration(
                                              image: DecorationImage(
                                                  image: AssetImage(
                                                    Assets
                                                        .categoryNewimgcalender,
                                                  ),
                                                  fit: BoxFit.fill)),
                                          child: Center(
                                              child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10.0),
                                            child: Text(
                                              '00           $countdownSeconds',
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w900,
                                                  color: Colors.cyan),
                                            ),
                                          )),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) =>
                                //             const Screen5d()));
                              },
                              child: Container(
                                height: height * 0.15,
                                width: width * 0.5,
                                decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                          Assets.categoryNewimg2,
                                        ),
                                        fit: BoxFit.fill)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    textWidget(
                                        text: '     5D 1Min',
                                        fontWeight: FontWeight.w900,
                                        fontSize: 15,
                                        color: AppColors.primaryTextColor),
                                    textWidget(
                                        text: '      Countdown to Lottery',
                                        fontWeight: FontWeight.w700,
                                        fontSize: 12,
                                        color: AppColors.primaryTextColor),
                                    SizedBox(
                                      height: height * 0.01,
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: width * 0.05,
                                        ),
                                        Container(
                                          height: height * 0.045,
                                          width: width * 0.25,
                                          decoration: const BoxDecoration(
                                              image: DecorationImage(
                                                  image: AssetImage(
                                                    Assets
                                                        .categoryNewimgcalender,
                                                  ),
                                                  fit: BoxFit.fill)),
                                          child: Center(
                                              child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10.0),
                                            child: Text(
                                              '00           $countdownSeconds',
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w900,
                                                  color: Colors.pinkAccent),
                                            ),
                                          )),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                context, RoutesName.winGoScreen);
                          },
                          child: Container(
                            height: height * 0.3,
                            width: width * 0.44,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                      Assets.categoryNewimg3,
                                    ),
                                    fit: BoxFit.fill)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 15,
                                ),
                                textWidget(
                                    text: '     WinGo 1Min',
                                    fontWeight: FontWeight.w900,
                                    fontSize: 15,
                                    color: AppColors.primaryTextColor),
                                textWidget(
                                    text: '      Countdown to Lottery',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12,
                                    color: AppColors.primaryTextColor),
                                SizedBox(
                                  height: height * 0.01,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: width * 0.05,
                                    ),
                                    Container(
                                      height: height * 0.045,
                                      width: width * 0.25,
                                      decoration: const BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                Assets.categoryNewimgcalender,
                                              ),
                                              fit: BoxFit.fill)),
                                      child: Center(
                                          child: Padding(
                                        padding:
                                            const EdgeInsets.only(top: 10.0),
                                        child: Text(
                                          '00           $countdownSeconds',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w900,
                                              color: Colors.deepPurpleAccent),
                                        ),
                                      )),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    Row(
                      children: [
                        Container(
                            height: height * 0.05,
                            width: width * 0.05,
                            child: const VerticalDivider(
                              thickness: 3,
                              color: AppColors.gradientFirstColor,
                            )),
                        Text(
                          " Lottery".toUpperCase(),
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        )
                      ],
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    ListView.builder(
                      padding:  const EdgeInsets.symmetric(horizontal: 10),
                      physics:  const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: lotteryGameList.length,
                      itemBuilder: (context, index) {
                        return
                          InkWell(
                            onTap: lotteryGameList[index].onTap,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Container(
                                height: height * 0.2,
                                width: width * 0.9,
                                decoration: BoxDecoration(
                                  gradient: AppColors.primaryUnselectedGradient,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      height: height * 0.15,
                                      width: width * 0.24,
                                      decoration: BoxDecoration(
                                        gradient: AppColors.btnBlueGradient,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Image.asset(lotteryGameList[index].image,),
                                    ),
                                    Container(
                                      height: height * 0.15,
                                      width: width * 0.55,
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                lotteryGameList[index].name.toUpperCase(),
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              AppBtn(
                                                height: height * 0.04,
                                                width: width * 0.22,
                                                title: 'GO →',
                                                fontSize: 15,
                                                onTap: () {},
                                                hideBorder: true,
                                                gradient: AppColors.loginSecondryGrad,
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: height * 0.01,
                                          ),
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Container(
                                              height: height * 0.04,
                                              width: width * 0.52,
                                              decoration: BoxDecoration(
                                                gradient: AppColors.buttonGradient,
                                                borderRadius: BorderRadius.circular(5),
                                              ),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  const Text(
                                                    "   The Highest bonus in history",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 8,
                                                    ),
                                                  ),
                                                  Container(
                                                    height: height * 0.03,
                                                    width: width * 0.005,
                                                    color: Colors.white,
                                                  ),
                                                  const Text(
                                                    "0.00",
                                                    style: TextStyle(
                                                      color: AppColors.gradientFirstColor,
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: height * 0.01,
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                height: height * 0.02,
                                                width: width * 0.005,
                                                color: Colors.white,
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Container(
                                                width: width * 0.48,
                                                child: const Text(
                                                  "Thought the platform WIN GO Hash lottery seed as the result of the lottery",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 9,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        //   lotteryContainer(
                        //   height,
                        //   width,
                        //   lotteryGameList[index].name, // title
                        //   , // subtitle
                        //    // Pass the onTap function directly
                        //   lotteryGameList[index].image,
                        // );
                      },
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                  ],
                ),
              )
            : Padding(
                padding: const EdgeInsets.fromLTRB(10, 25, 10, 5),
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                            height: height * 0.05,
                            width: width * 0.05,
                            child: const VerticalDivider(
                              thickness: 3,
                              color: AppColors.gradientFirstColor,
                            )),
                        Text(
                          " Lottery".toUpperCase(),
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        )
                      ],
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    Center(
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 8.0,
                          mainAxisSpacing: 2.0,
                          // childAspectRatio: 1.6
                        ),
                        shrinkWrap: true,
                        itemCount: lotteryGameList.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: lotteryGameList[index].onTap,
                            child: Center(
                              child: Container(
                                height: height * 0.25,
                                width: width * 0.5,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: const DecorationImage(
                                      fit: BoxFit.fill,
                                      image: AssetImage(
                                        Assets.imagesPopularlotterybg,
                                      ),
                                    )),
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      lotteryGameList[index].name,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w900,
                                          fontSize: 16,
                                          color: Colors.white),
                                    ),
                                    Container(
                                      height: 90,
                                      width: 100,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  lotteryGameList[index].image),
                                              fit: BoxFit.fill)),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 68.0),
                                      child: Container(
                                        height: 25,
                                        width: 60,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                                width: 1.5,
                                                color: AppColors
                                                    .primaryTextColor)),
                                        child: const Center(
                                          child: Text(
                                            'GO →',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w900,
                                                fontSize: 16,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
      ],
    );
  }

  Widget lotteryContainer(
      double height,
      double width,
      String title,
      String subtitle,
      VoidCallback onTap,
      String imagePath,
      ) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Container(
          height: height * 0.2,
          width: width * 0.9,
          decoration: BoxDecoration(
            gradient: AppColors.primaryUnselectedGradient,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: height * 0.15,
                width: width * 0.24,
                decoration: BoxDecoration(
                  gradient: AppColors.btnBlueGradient,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Image.asset(imagePath),
              ),
              Container(
                height: height * 0.15,
                width: width * 0.55,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          title.toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        AppBtn(
                          height: height * 0.04,
                          width: width * 0.22,
                          title: 'GO →',
                          fontSize: 15,
                          onTap: () {},
                          hideBorder: true,
                          gradient: AppColors.loginSecondryGrad,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        height: height * 0.04,
                        width: width * 0.52,
                        decoration: BoxDecoration(
                          gradient: AppColors.buttonGradient,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Text(
                              "   The Highest bonus in history",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 8,
                              ),
                            ),
                            Container(
                              height: height * 0.03,
                              width: width * 0.005,
                              color: Colors.white,
                            ),
                            const Text(
                              "0.00",
                              style: TextStyle(
                                color: AppColors.gradientFirstColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: height * 0.02,
                          width: width * 0.005,
                          color: Colors.white,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Container(
                          width: width * 0.48,
                          child: Text(
                            subtitle,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 9,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
