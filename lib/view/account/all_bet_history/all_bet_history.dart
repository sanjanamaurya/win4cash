
import 'package:flutter/material.dart';
import 'package:win4cash/generated/assets.dart';
import 'package:win4cash/res/aap_colors.dart';
import 'package:win4cash/res/components/app_bar.dart';
import 'package:win4cash/res/components/text_widget.dart';
import 'package:win4cash/view/account/all_bet_history/avaitor_all_bet_history.dart';
import 'package:win4cash/view/account/all_bet_history/dragon_tiger_all_history.dart';
import 'package:win4cash/view/account/all_bet_history/trx_all_history.dart';
import 'package:win4cash/view/account/all_bet_history/wingoallhistory.dart';

class AllBetHistory extends StatefulWidget {
  const AllBetHistory({super.key});

  @override
  State<AllBetHistory> createState() => _AllBetHistoryState();
}

class _AllBetHistoryState extends State<AllBetHistory> {
  int selectedIndex = 0;

  void selectIndex(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

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
            text: 'All Bet History',
            fontWeight: FontWeight.w900,
            fontSize: 20,
            color: AppColors.primaryTextColor,
          ),
          gradient: AppColors.primaryUnselectedGradient),
      body: ListView(
        shrinkWrap: true,
        children: [
          SizedBox(
            width: 400,
            height: 80,
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              children: [
                selectableContainer(
                  isSelected: selectedIndex == 0,
                  onTap: () {
                    selectIndex(0);
                  },
                  text: 'Wingo',
                  imagePath: Assets.categoryWingocoin1,
                ),
                // selectableContainer(
                //   isSelected: selectedIndex == 1,
                //   onTap: () {
                //     selectIndex(1);
                //   },
                //   text: 'Trx',
                //   imagePath: Assets.categoryTrxcoin1,
                // ),
                selectableContainer(
                  isSelected: selectedIndex == 2,
                  onTap: () {
                    selectIndex(2);
                  },
                  text: 'Dragon Tiger',
                  imagePath: Assets.categoryChessIcon,
                ),
                // selectableContainer(
                //   isSelected: selectedIndex == 3,
                //   onTap: () {
                //     selectIndex(3);
                //   },
                //   text: 'Avaitor',
                //   imagePath: Assets.aviatorFanAviator,
                // ),
              ],
            ),
          ),
          selectedIndex == 0
              ? const WingoAllHistory()
              : selectedIndex == 1
                  ? const TrxAllHistory()
                  : selectedIndex == 2
                      ? const DragonTigerAllHistory(
                          gameid: '10',
                        )
                      : selectedIndex == 3
              ? const AvaitorAllHistory(gameid: '1',):Container()
        ],
      ),
    );
  }

  Widget selectableContainer({
    required bool isSelected,
    required VoidCallback onTap,
    required String text,
    required String imagePath,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            color: isSelected
                ? AppColors.iconsColor
                : AppColors.secondaryContainerTextColor,
            borderRadius: const BorderRadius.all(Radius.circular(5))),
        child: Row(
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(
              width: 60,
              child: Center(
                child: Text(
                  text,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
