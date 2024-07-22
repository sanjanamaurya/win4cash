import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:win4cash/main.dart';
import 'package:win4cash/view/home/mini/Aviator/aviator_constant/aviator_assets.dart';
import 'package:win4cash/view/home/mini/Aviator/widget/switch.dart';
import 'package:shared_preferences/shared_preferences.dart';


class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  bool isSwitched = false;
  bool isSwitch = false;
  bool status = false;
  bool isSwitchOn = true;
  // late int stm;
  // Soundpool pownsound = Soundpool(streamType: StreamType.notification);
  //
  // sound({required String audio})async{
  //   int soundId = await rootBundle.load(audio).then((ByteData soundData) {
  //     return pownsound.load(soundData);
  //   });
  //   stm = await pownsound.play(soundId);
  // }
  @override
  Widget build(BuildContext context) {
    return Dialog(
        alignment: Alignment.topRight,
        shape: RoundedRectangleBorder(

          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child:Container(
          height: height*0.57,
          width: width*0.66,
          color: Color(0xff2c2d30),
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CircleAvatar(),
                    Container(
                      width: width*0.35,
                      // color: Colors.red,


                      child: Text(
                        "Aman_2345",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w700),),
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: height*0.07,
                      width: width*0.27,
                      decoration: BoxDecoration(
                          // color: Colors.red,
                        borderRadius: BorderRadius.circular(30),
                            border: Border.all(color: Colors.grey)
                      ),
                      child:Row(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.account_circle_outlined,size: 30,color: Colors.grey,),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text("change",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w500,fontSize: 16),),
                                Text("Avatar",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w500,fontSize: 16),),
                              ],
                            ),
                          )
                        ],
                      ) ,
                    )
                  ],
                ),
              ),
              SizedBox(height: height*0.02,),
              Container(
                height: height*0.07,
                color:Color(0xff1b1c1d),
                child:Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(Icons.volume_down_alt,color: Colors.grey,size: 28,),
                      Text("sound",style: TextStyle(fontSize: 17,color: Colors.grey),),
                      SizedBox(width: width*0.38,),
                      CustomSwitch(
                        width: width * 0.1,
                        height: height * 0.025,
                        toggleSize: height * 0.015,
                        value: isSwitched,
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
                            isSwitched = val;
                          });
                        },
                      ),
                    ],
                  ),
                )
              ),
              SizedBox(height: height*0.005,),
              Container(
                height: height*0.07,
                color:Color(0xff1b1c1d),
                child: Padding(
                  padding:  EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Image(image: AssetImage(AviatorAssets.music),height: 30,),
                      Text("music",style: TextStyle(fontSize: 17,color: Colors.grey),),
                      SizedBox(width: width*0.38,),
                      CustomSwitch(
                        width: width * 0.1,
                        height: height * 0.025,
                        toggleSize: height * 0.015,
                        value: isSwitched,
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
                            isSwitched = val;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: height*0.005,),
              Container(
                height: height*0.07,
                color:Color(0xff1b1c1d),
                child: Padding(
                  padding:  EdgeInsets.all(8.0),
                  child: Row(
                    children: [

                      Image(image: AssetImage(AviatorAssets.fan),height: 30),
                      Text("animation",style: TextStyle(fontSize: 17,color: Colors.grey),),
                      SizedBox(width: width*0.3,),
                      CustomSwitch(
                        width: width * 0.1,
                        height: height * 0.025,
                        toggleSize: height * 0.015,
                        value: isSwitched,
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
                            isSwitched = val;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: height*0.04,),
              Container(
                height: height*0.07,
                color:Color(0xff1b1c1d),
                child: Padding(
                  padding:  EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(Icons.history,color: Colors.grey,size: 28,),
                      Text("My Bet History",style: TextStyle(fontSize: 18,color: Colors.grey),),

                    ],
                  ),
                ),
              ),
              SizedBox(height: height*0.005,),
              Container(
                height: height*0.07,
                color:Color(0xff1b1c1d),
                child: Padding(
                  padding:  EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(Icons.token_outlined,color: Colors.grey,size: 28,),
                      Text("Game Limits",style: TextStyle(fontSize: 18,color: Colors.grey),),

                    ],
                  ),
                ),
              ),

            ],
          ) ,
        ) );
  }

  @override
  void initState() {

    // TODO: implement initState
    super.initState();
  }


}
