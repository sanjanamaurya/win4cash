import 'package:flutter/material.dart';
import 'package:win4cash/main.dart';
import 'package:win4cash/res/components/custom_switch.dart';
import 'package:win4cash/res/components/small_sliding_switch.dart';
import 'package:win4cash/view/home/Mines/bet_history.dart';

class MinesDrawer extends StatefulWidget {
  const MinesDrawer({super.key});

  @override
  State<MinesDrawer> createState() => _MinesDrawerState();
}

class _MinesDrawerState extends State<MinesDrawer> {

    bool autoCas = false;


  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: EdgeInsets.only(top: height * 0.1, right: width * 0.03),
            child: Container(
              height: height * 0.28,
              width: width * 0.8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color(0xff212226).withOpacity(0.9),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Column(
                    children: [
                      Container(
                        height: height * 0.07,
                        width: width,
                        decoration:  BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color:  Colors.black.withOpacity(0.9),
                        ),
                        child: Center(
                          child:Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Row(
                              children: [
                                Icon(Icons.volume_up_outlined,color: Colors.white,),
                                Text('   Sound',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Spacer(),
                                CustomSwitch(
                                  width: width * 0.1,
                                  height: height * 0.025,
                                  toggleSize: height * 0.015,
                                  value: autoCas,
                                  borderRadius: 20.0,
                                  padding: 2.0,
                                  toggleColor: Colors.white,
                                  switchBorder: Border.all(
                                    color: Colors.grey,
                                    width: 1.0,
                                  ),
                                  toggleBorder: Border.all(
                                    color: Colors.white,
                                    width: 2.0,
                                  ),
                                  activeColor: Colors.green,
                                  inactiveColor: Colors.grey.withOpacity(0.2),
                                  onToggle: (val) {
                                    setState(() {
                                      autoCas = val;
                                    });
                                  },
                                ),

                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: height*0.01,),
                      Container(
                        height: height * 0.15,
                        width: width,
                        decoration:  BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color:  Colors.black.withOpacity(0.9),
                        ),
                        child: Center(
                          child:Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: (){
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return MineGameHistory();
                                      },
                                    );
                                   // Navigator.pop(context);
                                  },
                                  child: Row(
                                    children: [
                                      Icon(Icons.history_edu_sharp,color: Colors.white,),
                                      Text('   Bet History',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),


                                    ],
                                  ),
                                ),
                                Divider(color: Colors.grey,),
                                Row(
                                  children: [
                                    Icon(Icons.rule,color: Colors.white,),
                                    Text('   Game Rule',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),


                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
