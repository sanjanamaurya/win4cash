import 'package:flutter/material.dart';
import 'package:win4cash/generated/assets.dart';
import 'package:win4cash/main.dart';
import 'package:win4cash/res/aap_colors.dart';
import 'package:win4cash/view/home/Mines/mines_home_page.dart';
import 'package:win4cash/view/home/widgets/Classes/lottery_subfile.dart';
import 'package:win4cash/view/home/widgets/Classes/original_classes.dart';
import 'package:win4cash/view/home/widgets/lottery_page.dart';

class PopularPage extends StatefulWidget {
  final int sId;
  const PopularPage({super.key, required this.sId});

  @override
  State<PopularPage> createState() => _PopularPageState();
}

class _PopularPageState extends State<PopularPage> {
  @override
  Widget build(BuildContext context) {
    List<MiniGameModel> miniGameList = [
      MiniGameModel(
          image: Assets.categoryAvaitorimagenew,
          onTap: () {
            // Navigator.push(context,
            //     MaterialPageRoute(builder: (context) => GameAviator()));
          }),
      MiniGameModel(
          image: Assets.categoryMines,
          onTap: () {
           //  Navigator.push(context, MaterialPageRoute(builder: (context)=>const MinesHomePage()));
          }),
      MiniGameModel(
          image: Assets.categoryDice,
          onTap: () {
            // Navigator.push(context, MaterialPageRoute(builder: (context)=>GameAviator()));
          }),
      MiniGameModel(
          image: Assets.categoryHilo,
          onTap: () {
            // Navigator.push(context, MaterialPageRoute(builder: (context)=>GameAviator()));
          }),
      MiniGameModel(
          image: Assets.categoryPlinko,
          onTap: () {
            // Navigator.push(context, MaterialPageRoute(builder: (context)=>GameAviator()));
          }),
      MiniGameModel(
          image: Assets.categoryLimbo,
          onTap: () {
            // Navigator.push(context, MaterialPageRoute(builder: (context)=>GameAviator()));
          }),
    ];

    return Column(
      children: [
        widget.sId == 1
            ? Padding(
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
                          " Original".toUpperCase(),
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
                    GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 2.0,
                        // childAspectRatio: 1.6
                      ),
                      shrinkWrap: true,
                      itemCount: miniGameList.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: miniGameList[index].onTap,
                          child: Center(
                            child: Container(
                              height: height * 0.25,
                              width: width * 0.5,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: AssetImage(
                                      miniGameList[index].image,
                                    ),
                                  )),
                              //  color: Colors.deepPurpleAccent,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              )
            : Column(
                children: [
                  LotteryPage(sId: widget.sId,),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
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
                              " Original".toUpperCase(),
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
                        GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 8.0,
                            mainAxisSpacing: 2.0,
                            // childAspectRatio: 1.6
                          ),
                          shrinkWrap: true,
                          itemCount: miniGameList.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: miniGameList[index].onTap,
                              child: Center(
                                child: Container(
                                  height: height * 0.25,
                                  width: width * 0.5,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: AssetImage(
                                          miniGameList[index].image,
                                        ),
                                      )),
                                  //  color: Colors.deepPurpleAccent,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              )
      ],
    );
  }
}
