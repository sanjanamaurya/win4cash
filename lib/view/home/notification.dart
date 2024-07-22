import 'dart:convert';
import 'package:win4cash/generated/assets.dart';
import 'package:win4cash/main.dart';
import 'package:win4cash/model/notification_model.dart';
import 'package:win4cash/res/aap_colors.dart';
import 'package:win4cash/res/components/text_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:win4cash/res/api_urls.dart';
import 'package:win4cash/res/components/app_bar.dart';
import 'package:http/http.dart' as http;


class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {

  @override
  void initState() {
    notificationn();
    // TODO: implement initState
    super.initState();
  }

  int ?responseStatuscode;

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
            text: 'Notification',
            fontWeight: FontWeight.w900,
            fontSize: 20,
            color: AppColors.primaryTextColor,),

          gradient: AppColors.primaryUnselectedGradient),
      body:ListView(
        shrinkWrap: true,
        children: [
          const SizedBox(height: 10),
          responseStatuscode== 400 ?
          const Notfounddata(): items.isEmpty? const Center(child: CircularProgressIndicator()):
          ListView.builder(
              itemCount:
              items.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index){
                return Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(11)),
                  child: Container(
                    decoration: BoxDecoration(gradient: AppColors.primaryUnselectedGradient, borderRadius: BorderRadiusDirectional.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                          //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset(Assets.iconsProNotification,scale: 1.5,),
                            SizedBox(width: width*0.02,),
                              textWidget(text:
                              items[index].name.toString(),
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: AppColors.primaryTextColor
                              ),
                              Spacer(),
                              Image.asset(Assets.iconsDeleat,scale: 1.5,),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: HtmlWidget(items[index].disc.toString()
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                );

          }),
          const SizedBox(height: 20),


          // Container(
          //   height: height / 3,
          //   width: height / 3.7,
          //   child: Transform.rotate(
          //     angle: -pi / 75,
          //     origin: Offset(0, height / 6), // move pivot point to left edge
          //     child: Container(
          //       decoration: BoxDecoration(
          //         color: Colors.yellow,
          //         borderRadius: BorderRadius.only(
          //           topLeft: Radius.circular(height / 8),
          //           bottomLeft: Radius.circular(height / 8.8),
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          // SizedBox(height: 20,),

          // CustomPaint(
          //   painter: RightLeaningLinePainter(),
          //   child: Center(
          //     child: Container(
          //       // Ensure the container fills the area to display the painting
          //       width: 50,
          //       height: 100,
          //       decoration: BoxDecoration(
          //         borderRadius: BorderRadius.only(
          //           topLeft: Radius.circular(height / 8),
          //           bottomLeft: Radius.circular(height / 8.8),
          //         ),
          //       ),
          //       // Other properties such as decoration can be added here
          //     ),
          //   ),
          // )

          // Center(
       //   child: Container(
      //     height: 200,
      //     width: 200,
      //     child: Center(
      //       child: Container(
      //         height: 200,
      //         width: 200,
      //         child: ClipPath(
      //           clipper: TiltedClipper(),
      //           child: Container(
      //             decoration: BoxDecoration(
      //                                      color: Colors.yellow,
      //                                      borderRadius: BorderRadius.only(
      //                                          topLeft: Radius.circular(height/8),
      //                                          bottomLeft: Radius.circular(height/8.8)
      //                                      ),
      //           ),
      //         ),
      //       ),
      //     ),
      //   ),
      //   )),






        ],
      )
    );
  }

  List<NotificationModel> items = [];

  Future<void> notificationn() async {

    final response = await http.get(Uri.parse(ApiUrl.notificationapi),);
    if (kDebugMode) {
      print(ApiUrl.notificationapi);
      print('notificationapi');
    }

    setState(() {
      responseStatuscode = response.statusCode;
    });

    if (response.statusCode==200) {
      final List<dynamic> responseData = json.decode(response.body)['data'];
      setState(() {

        items = responseData.map((item) => NotificationModel.fromJson(item)).toList();
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
        items = [];
      });
      throw Exception('Failed to load data');
    }
  }

}

class Notfounddata extends StatelessWidget {
  const Notfounddata({super.key});

  @override
  Widget build(BuildContext context){
    final heights = MediaQuery.of(context).size.height;
    final widths = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image(
          image: const AssetImage(Assets.imagesNoDataAvailable),
          height: heights / 3,
          width: widths / 2,
        ),
        SizedBox(height: heights*0.07),
        const Text("Data not found",)
      ],
    );
  }

}







