import 'dart:async';

import 'package:win4cash/generated/assets.dart';
import 'package:win4cash/main.dart';
import 'package:win4cash/res/aap_colors.dart';
import 'package:win4cash/view/home/dragon_tiger_new/dragon_tiger.dart';
import 'package:flutter/material.dart';
import 'package:win4cash/view/home/widgets/Classes/rummy_list.dart';
import 'package:win4cash/view/home/widgets/lottery_page.dart';
import 'package:win4cash/view/home/widgets/popular_page.dart';

class CategoryElement extends StatefulWidget {
  final int selectedCategoryIndex;
  const CategoryElement({super.key, required this.selectedCategoryIndex});

  @override
  State<CategoryElement> createState() => _CategoryElementState();
}

class _CategoryElementState extends State<CategoryElement> {
  @override
  Widget build(BuildContext context) {
    List<RummylistModel> Rummylist = [
      RummylistModel(
          image: Assets.imagesAviatorFirst,
          onTap: () {
            // Navigator.push(context, MaterialPageRoute(builder: (context)=>DragontigerPage(gameId: '10',)));
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const DragonTiger(gameId: '10')));
          }),
    ];
    return widget.selectedCategoryIndex == 0
        ? LotteryPage(sId: widget.selectedCategoryIndex)
        : widget.selectedCategoryIndex == 1
            ? PopularPage(sId: widget.selectedCategoryIndex)
            : widget.selectedCategoryIndex == 2
                ? Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: Rummylist.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
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
                                    " Dragon Tiger".toUpperCase(),
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
                              GestureDetector(
                                onTap: Rummylist[index].onTap,
                                child: Container(
                                  height: height * 0.17,
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10)),
                                      color: Colors.orange.shade900),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      const Text(
                                        "Dragon Tiger",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(width: width * 0.12),
                                      Image.asset(
                                        Assets.categoryDragontiger,
                                        height: height * 0.13,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        }),
                  )
                : widget.selectedCategoryIndex == 3
                    ? PopularPage(sId: widget.selectedCategoryIndex)
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          Assets.imagesCommingsoon,
                          height: height * 0.20,
                        ),
                      );
  }
}
