import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:win4cash/main.dart';
import 'package:win4cash/res/aap_colors.dart';
import 'package:win4cash/res/components/app_bar.dart';
import 'package:win4cash/res/components/app_btn.dart';
import 'package:win4cash/res/components/text_field.dart';
import 'package:win4cash/res/components/text_widget.dart';
import 'package:win4cash/utils/filter_date-formate.dart';
import 'package:win4cash/view/promotion/promotion_new.dart';

class SubOrdinateDataScreen extends StatefulWidget {
 final Map<String, dynamic> responseData;
  const SubOrdinateDataScreen( {super.key, required this.responseData});

  @override
  State<SubOrdinateDataScreen> createState() => _SubOrdinateDataScreenState();
}

class _SubOrdinateDataScreenState extends State<SubOrdinateDataScreen> {
  TextEditingController searchCon = TextEditingController();

  DateTime _selectedDate = DateTime.now();
@override
  void initState() {
  listparsing();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffolddark,
      appBar: GradientAppBar(
          title: textWidget(
              text: 'Subordinate Data', fontSize: 25, color: Colors.white),
          leading: const AppBackBtn(),
          centerTitle: true,
          gradient: AppColors.primaryUnselectedGradient),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(top: height * 0.2),
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
                  child: Container(
                    width: width * 0.9,
                    decoration: BoxDecoration(
                        gradient: AppColors.loginSecondryGrad,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              addTextColumn(
                                  alllevel[dataindex].no_of_payin.toString(), 'Deposit Number', Colors.white),
                              addTextColumn(
                                  alllevel[dataindex].totalbet.toString(), 'Number of bettor', Colors.white),
                              addTextColumn(
                                  alllevel[dataindex].no_of_people.toString(),
                                  'Number of People making\n            first deposit',
                                  Colors.white),
                            ],
                          ),
                          Column(
                            children: [
                              addTextColumn(
                                  alllevel[dataindex].total_payin.toString(), 'Deposit Amount', Colors.white),
                              addTextColumn( alllevel[dataindex].total_bet_amount.toString(), 'Total bet', Colors.white),
                              addTextColumn(
                                  alllevel[dataindex].first_recharge.toString(),
                                  'first deposit amount',
                                  Colors.white),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: height * 0.04,
                      )
                    ]),
                  ),
                ),
                ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: alldata.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.all(10),
                        height: height * 0.25,
                        width: width * 0.93,
                        decoration: BoxDecoration(
                            color: AppColors.secondaryContainerTextColor,
                            borderRadius: BorderRadius.circular(5)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              children: [
                                textWidget(
                                    text: '  UID:${alldata[index].uid}',
                                    fontSize: 18,
                                    color: AppColors.primaryTextColor),
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.copy,
                                      size: 20,
                                      color: AppColors.primaryTextColor,
                                    )),
                              ],
                            ),
                            Container(
                              width: width * 0.9,
                              height: 0.5,
                              color: AppColors.gradientFirstColor,
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  textWidget(
                                      text: 'Level',
                                      fontSize: 16,
                                      color: AppColors.primaryTextColor),
                                  textWidget(
                                      text: alldata[index].type.toString(),
                                      fontSize: 16,
                                      color: AppColors.primaryTextColor),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  textWidget(
                                      text: 'Deposit amount',
                                      fontSize: 16,
                                      color: AppColors.primaryTextColor),
                                  textWidget(
                                      text: alldata[index].depositAmount.toString(),
                                      fontSize: 16,
                                      color: AppColors.gradientFirstColor),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  textWidget(
                                      text: 'Bet amount',
                                      fontSize: 18,
                                      color: AppColors.primaryTextColor),
                                  textWidget(
                                      text: alldata[index].turnover.toString(),
                                      fontSize: 18,
                                      color: AppColors.gradientFirstColor),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  textWidget(
                                      text: 'Commission',
                                      fontSize: 18,
                                      color: AppColors.primaryTextColor),
                                  textWidget(
                                      text: alldata[index].commission.toString(),
                                      fontSize: 18,
                                      color: AppColors.gradientFirstColor),
                                ],
                              ),
                            ),

                          ],
                        ),
                      );
                    }),
              ],
            ),
          ),
          Container(
            width: width,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
                  child: CustomTextField(
                    fieldRadius: BorderRadius.circular(10),
                    fillColor: Colors.white.withOpacity(0.01),
                    controller: searchCon,
                    onChanged: (val){
                      resetData();
                    },
                    maxLines: 1,
                    hintText: 'Search subordinate UID',
                    suffixIcon: InkWell(
                      onTap: () {
                        search(searchCon.text);
                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(5, 5, 10, 5),
                        child: Container(
                          alignment: Alignment.center,
                          height: height * 0.03,
                          width: width * 0.2,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            gradient: AppColors.loginSecondryGrad,
                          ),
                          child: const Icon(
                            Icons.search,
                            size: 35,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
                  child: Container(
                    height: height * 0.065,

                    decoration: BoxDecoration(
                        color: AppColors.secondaryContainerTextColor,
                        borderRadius: BorderRadius.circular(5)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(width: 20,),
                        Center(
                          child: textWidget(
                              text:selectedTierIndex==0? '  All':'Tier $selectedTierIndex',
                              fontSize: 18,
                              color: AppColors.primaryTextColor),
                        ),
                        IconButton(
                            onPressed: () {
                              showSubordinateFilterBottomSheet(context);
                            },
                            icon: const Icon(
                                Icons.keyboard_arrow_down_outlined,
                                color: AppColors.primaryTextColor))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  int selectedTierIndex = 0;
  List<AllTierData> alldata = [];
  List<subordinatedata> alllevel = [];
  String type='all';
  int dataindex= 6;

  listparsing(){
    print(type);
    print('hkkkkkkkkkkkkkkk');
    if(type=='all') {
      alldata.clear();
      alllevel.clear();

      for (var data in widget.responseData['levelwisecommission']) {
        alllevel.add(subordinatedata(
          data['count'],
            data['name'],
            data['commission'],
            data['total_payin'],
            data['no_of_payin'],
            data['first_recharge'],
            data['no_of_people'],
            data['totalbet'],
          data['total_bet_amount'],
        ));
        if(data['name']!='all')
        for (var alldatas in widget.responseData["userdata"][data['name']]) {
          alldata.add(AllTierData(
              userId: alldatas['user_id'],
              username: alldatas['username'].toString().toUpperCase(),
              turnover: alldatas['turnover'],
              commission: alldatas['commission'],
              uid: alldatas['u_id'],
              depositAmount: alldatas['deposit_amount'],
              type: data['name']
          ));
        }
        setState(() {});
      }
    }else{
      alldata.clear();
      for (var alldatas in widget.responseData["userdata"][type]) {
        alldata.add(AllTierData(
            userId: alldatas['user_id'],
            username: alldatas['username'].toString().toUpperCase(),
            turnover: alldatas['turnover'],
            commission: alldatas['commission'],
            uid: alldatas['u_id'],
            depositAmount: alldatas['deposit_amount'],
            type: type

        ));
      }
      setState(() {});
    }
  }
  List<AllTierData> alldataSearch=[];
  void search(String query) {
    List<AllTierData> searchResult = alldata.where((data) => data.userId.toString().contains(query)).toList();
    setState(() {
      alldata = searchResult;
    });
  }
  void resetData() {
    listparsing();
  }
  showSubordinateFilterBottomSheet(BuildContext context) {


    showModalBottomSheet(
      backgroundColor:AppColors.secondaryContainerTextColor,
      shape: const RoundedRectangleBorder(
          borderRadius:   BorderRadius.only(
              topRight: Radius.circular(10), topLeft: Radius.circular(10))
      ),
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(20),

          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: textWidget(
                        text: 'Cancel', fontSize: 16, color: Colors.grey),
                  ),
                  TextButton(
                    onPressed: () {
                      //
                      Navigator.pop(context, selectedTierIndex);
                      listparsing();
                    },
                    child: textWidget(
                        text: 'Confirm', fontSize: 16, color: Colors.blue),
                  ),
                ],
              ),
              Expanded(
                child: CupertinoPicker(

                  selectionOverlay:
                      const CupertinoPickerDefaultSelectionOverlay(
                    background: CupertinoDynamicColor.withBrightness(
                      color: Colors.transparent,
                      darkColor: Colors.transparent,
                    ),
                  ),
                  scrollController: FixedExtentScrollController(
                    initialItem: selectedTierIndex,
                  ),
                  itemExtent: 50,
                  onSelectedItemChanged: (tierIndex) {
                    setState(() {
                      selectedTierIndex = tierIndex; // Update selected index
                      type=tierIndex==0?'all':'Tier $tierIndex';
                      dataindex=type=='all'?alllevel.length-1:int.parse(type.split('').last.toString());
                    });

                  },
                  children: [
                    for (var datas in alllevel)
                  Text(datas.name)
                    ]
                  ),
                ),
            ],
          ),
        );
      },
    ).then((value) {
      if (value != null) {
        print('Selected Tier: $value');
      }
    });
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
                color: AppColors.primaryTextColor),
          ),
        ],
      ),
    );
  }
}


class subordinatedata {
  final dynamic count;
  final dynamic name;
  final dynamic commission;
  final dynamic total_payin;
  final dynamic no_of_payin;
  final dynamic first_recharge;
  final dynamic no_of_people;
  final dynamic totalbet;
  final dynamic total_bet_amount;

  subordinatedata(
      this.count,
      this.name,
      this.commission,
      this.total_payin,
      this.no_of_payin,
      this.first_recharge,
      this.no_of_people,
      this.totalbet,
      this.total_bet_amount);
}