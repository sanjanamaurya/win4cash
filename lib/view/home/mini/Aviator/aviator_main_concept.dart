// import 'dart:convert';
// import 'dart:math';
//
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:win4cash/main.dart';
// import 'package:win4cash/res/api_urls.dart';
// import 'package:win4cash/res/components/app_btn.dart';
// import 'package:win4cash/view/home/mini/Aviator/AviatorProvider.dart';
// import 'package:win4cash/view/home/mini/Aviator/aviator_constant/aviator_assets.dart';
// import 'package:win4cash/view/home/mini/Aviator/aviator_model/result_history_model.dart';
// import 'package:win4cash/view/home/mini/Aviator/home_page_aviator.dart';
// import 'package:win4cash/view/home/mini/Aviator/widget/Marquee/marquee.dart';
// import 'package:win4cash/view/home/mini/Aviator/widget/rendom_color.dart';
// import 'package:provider/provider.dart';
// import 'package:socket_io_client/socket_io_client.dart' as IO;
// import 'package:http/http.dart' as http;
// import 'dart:math' as math;
//
// class AviatorMainConcept extends StatefulWidget {
//   const AviatorMainConcept({Key? key}) : super(key: key);
//
//   @override
//   State<AviatorMainConcept> createState() => _AviatorMainConceptState();
// }
//
// class AllBets {
//   String? image;
//   String? username;
//   String? bet;
//   String? win;
//   AllBets(this.image, this.username, this.bet, this.win);
// }
//
// class _AviatorMainConceptState extends State<AviatorMainConcept>
//     with TickerProviderStateMixin {
//   late final AnimationController _controllers =
//       AnimationController(vsync: this, duration: const Duration(seconds: 1500))
//         ..repeat();
//
//   late final AnimationController _controllerfan = AnimationController(
//       vsync: this, duration: const Duration(milliseconds: 100))
//     ..repeat();
//
//   @override
//   void initState() {
//     _isMounted = true;
//     connectToServer();
//     animationControl();
//     planFlew();
//     resultHistory();
//     demoBet();
//     super.initState();
//   }
//
//   late Animation<double> _linearProgressAnimation;
//   @override
//   void dispose() {
//     _socket.disconnect();
//     _isMounted = false;
//     _controller.dispose();
//     super.dispose();
//   }
//
//   List<Demo> damibet = [];
//   late AnimationController _controller;
//   late AnimationController _controllerflew;
//   late Animation<Offset> _animationflew;
//   final bool _useRtlText = false;
//   List<ResultHistoryModel> number = [];
//   String gamesNo = '';
//   Color _currentColor = Colors.black;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xff101011),
//       appBar: AppBar(
//         backgroundColor: Colors.white12,
//         leading: const AppBackBtn(),
//         title: const Image(
//           image: AssetImage(AviatorAssets.aviatorText),
//           fit: BoxFit.fitHeight,
//           width: 100,
//         ),
//         actions: [
//           Container(
//             width: 150,
//             decoration: BoxDecoration(
//               border: Border.all(
//                   color: Colors.white12,
//                   width: 4.0,
//                   style: BorderStyle.solid), //Border.all
//               borderRadius: const BorderRadius.all(Radius.circular(30)),
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(5.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     context.read<AviatorWallet>().balance.toStringAsFixed(2),
//                     style: const TextStyle(
//                         color: Colors.green,
//                         fontWeight: FontWeight.w900,
//                         fontSize: 15),
//                   ),
//                   SizedBox(
//                     width: width * 0.02,
//                   ),
//                   const Text(
//                     'INR',
//                     style: TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.w900,
//                         fontSize: 15),
//                   ),
//                 ],
//               ),
//             ),
//           )
//         ],
//       ),
//       body: Column(
//         children: [
//           expansionWidget(),
//           Container(
//             height: height * 0.44,
//             width: width,
//             decoration: BoxDecoration(
//               border: Border.all(
//                   color: Colors.white12,
//                   width: 4.0,
//                   style: BorderStyle.solid), //Border.all
//               borderRadius: const BorderRadius.all(
//                 Radius.circular(10),
//               ),
//             ),
//             child: receiveData['status'] == 0
//                 ? Column(
//                     children: [
//                       Text(
//                         "Period : ${receiveData['period']}",
//                         style: const TextStyle(color: Colors.white),
//                       ),
//                       SizedBox(
//                         height: height * 0.34,
//                         width: width * 0.98,
//                         child: Row(
//                           children: [
//                             Container(
//                                 color: Colors.black,
//                                 width: width * 0.05,
//                                 height: height * 0.82,
//                                 child: _rowMarquee()),
//                             Container(
//                               height: height * 0.82,
//                               width: width * 0.92,
//                               color: Colors.white,
//                               child: Stack(
//                                 children: [
//                                   Positioned(
//                                     bottom: -width * 1.25,
//                                     left: -width * 1.25,
//                                     child: Container(
//                                         height: height * 2,
//                                         width: width * 2.5,
//                                         color: Colors.black.withOpacity(0.9),
//                                         child: imageBg()),
//                                   ),
//                                   Center(
//                                     child: Padding(
//                                       padding:
//                                           EdgeInsets.only(top: width * 0.05),
//                                       child: Column(
//                                         children: [
//                                           AnimatedBuilder(
//                                               animation: _controllerfan,
//                                               builder: (_, child) {
//                                                 return Transform.rotate(
//                                                   angle: _controllerfan.value *
//                                                       1 *
//                                                       math.pi,
//                                                   child: Container(
//                                                       height: 80,
//                                                       width: 60,
//                                                       decoration: const BoxDecoration(
//                                                           image: DecorationImage(
//                                                               image: AssetImage(
//                                                                   AviatorAssets
//                                                                       .aviatorFanAviator)))),
//                                                 );
//                                               }),
//                                           const Center(
//                                             child: Text(
//                                               'Waiting next Round',
//                                               style: TextStyle(
//                                                   fontSize: 25,
//                                                   fontWeight: FontWeight.w900,
//                                                   color: Colors.white),
//                                             ),
//                                           ),
//                                           const SizedBox(
//                                             height: 10,
//                                           ),
//                                           const Center(
//                                             child: Text(
//                                               'Place Your Bet',
//                                               style: TextStyle(
//                                                   fontSize: 20,
//                                                   fontWeight: FontWeight.w900,
//                                                   color: Colors.yellow),
//                                             ),
//                                           ),
//                                           Container(
//                                             width: 200,
//                                             decoration: BoxDecoration(
//                                               borderRadius:
//                                                   BorderRadius.circular(10),
//                                               border: Border.all(
//                                                   color:
//                                                       const Color(0xffea0b3e),
//                                                   width: 1),
//                                             ),
//                                             child: LinearProgressIndicator(
//                                               value: 1.0 - (receiveData['betTime']*0.01),
//                                               // value: _linearProgressAnimation
//                                               //         .value /
//                                               //     10,
//                                               backgroundColor: Colors.grey,
//                                               valueColor:
//                                                   const AlwaysStoppedAnimation<
//                                                       Color>(Color(0xffea0b3e)),
//                                               minHeight: 6,
//                                               borderRadius:
//                                                   BorderRadius.circular(10),
//                                             ),
//                                           ),
//                                           const SizedBox(
//                                             height: 8,
//                                           ),
//                                            Text(
//                                             'Time remaining:${(receiveData['betTime'] * 0.1).toStringAsFixed(1)}s',
//                                             style: TextStyle(
//                                                 color: Colors.white),
//                                           ),
//                                           const Align(
//                                             alignment: Alignment.bottomLeft,
//                                             child: Image(
//                                               image: AssetImage(
//                                                   AviatorAssets.aviatorPlane),
//                                               height: 28,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       Container(
//                         height: height * 0.06,
//                         width: width * 0.98,
//                         color: Colors.black,
//                         child: _buildMarquee(),
//                       ),
//                     ],
//                   )
//                 : receiveData['status'] == 1
//                     ? Column(
//                         children: [
//                           Text(
//                             "Period : ${receiveData['period']}",
//                             style: const TextStyle(color: Colors.white),
//                           ),
//                           SizedBox(
//                             height: height * 0.34,
//                             width: width * 0.98,
//                             child: Row(
//                               children: [
//                                 Container(
//                                     color: Colors.black,
//                                     width: width * 0.05,
//                                     height: height * 0.82,
//                                     child: _rowMarquee()),
//                                 Container(
//                                   height: height * 0.82,
//                                   width: width * 0.92,
//                                   color: Colors.white,
//                                   child: Stack(
//                                     children: [
//                                       Positioned(
//                                         bottom: -width * 1.25,
//                                         left: -width * 1.25,
//                                         child: Container(
//                                             height: height * 2,
//                                             width: width * 2.5,
//                                             color:
//                                                 Colors.black.withOpacity(0.9),
//                                             child: imageBg()),
//                                       ),
//                                       SizedBox(
//                                         height: height * 0.92,
//                                         width: width * 0.94,
//                                         child: aviator(
//                                           height * 0.92,
//                                           width * 0.92,
//                                         ),
//                                       ),
//                                       Center(
//                                         child: Text(
//                                           '${receiveData['timer']}X',
//                                           style: const TextStyle(
//                                               fontSize: 50,
//                                               fontWeight: FontWeight.w900,
//                                               color: Colors.white),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Container(
//                             height: height * 0.06,
//                             width: width * 0.98,
//                             color: Colors.black,
//                             child: _buildMarquee(),
//                           ),
//                         ],
//                       )
//                     : Column(
//                         children: [
//                           Text(
//                             "Period : '${receiveData['period']}X'",
//                             style: const TextStyle(color: Colors.white),
//                           ),
//                           SizedBox(
//                             height: height * 0.34,
//                             width: width * 0.98,
//                             child: Row(
//                               children: [
//                                 Container(
//                                     color: Colors.black,
//                                     width: width * 0.05,
//                                     height: height * 0.82,
//                                     child: _rowMarquee()),
//                                 Stack(
//                                   children: [
//                                     Center(
//                                       child: SizedBox(
//                                         height: height * 0.80,
//                                         width: width * 0.89,
//                                         child: Column(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.center,
//                                           children: [
//                                             SlideTransition(
//                                               position: _animationflew,
//                                               child: const Center(
//                                                 child: Image(
//                                                   image: AssetImage(
//                                                       AviatorAssets
//                                                           .aviatorPlane),
//                                                   height: 30,
//                                                 ),
//                                               ),
//                                             ),
//                                             Column(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment.center,
//                                               children: [
//                                                 const Text("Flew Away !",
//                                                     style: TextStyle(
//                                                         fontSize: 25,
//                                                         fontWeight:
//                                                             FontWeight.w900,
//                                                         color: Colors.white)),
//                                                 Text(
//                                                   '${receiveData['timer']}X',
//                                                   style: TextStyle(
//                                                       fontSize: 45,
//                                                       fontWeight:
//                                                       FontWeight.w900,
//                                                       color: Colors.red),
//                                                 ),
//                                               ],
//                                             )
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Container(
//                             height: height * 0.06,
//                             width: width * 0.98,
//                             color: Colors.black,
//                             child: _buildMarquee(),
//                           ),
//                         ],
//                       ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   bool isExpanded = false;
//   Widget expansionWidget() {
//     return ExpansionTile(
//       shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.all(Radius.circular(10))),
//       title: isExpanded
//           ? const Text("Round History",
//               style: TextStyle(fontSize: 12, color: Colors.white))
//           : Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(
//                   height: height * 0.053,
//                   width: width,
//                   child: ListView.builder(
//                       shrinkWrap: true,
//                       itemCount: number.length,
//                       scrollDirection: Axis.horizontal,
//                       itemBuilder: (BuildContext context, int index) {
//                         return Padding(
//                           padding: const EdgeInsets.all(2.0),
//                           child: Container(
//                             padding: const EdgeInsets.all(3.0),
//                             decoration: BoxDecoration(
//                               color: Colors.grey.withOpacity(0.2),
//                               border: Border.all(
//                                   color: Colors.grey.withOpacity(0.2)),
//                               borderRadius:
//                                   const BorderRadius.all(Radius.circular(10)),
//                             ),
//                             child: Center(
//                               child: Text(
//                                 '${number[index].price} X',
//                                 style: TextStyle(
//                                     fontSize: 10, color: _currentColor),
//                               ),
//                             ),
//                           ),
//                         );
//                       }),
//                 ),
//               ],
//             ),
//       onExpansionChanged: (value) {
//         setState(() {
//           isExpanded = value;
//         });
//       },
//       trailing: Container(
//         alignment: Alignment.center,
//         height: height * 0.05,
//         width: width * 0.15,
//         decoration: BoxDecoration(
//           color: Colors.grey.withOpacity(0.1),
//           border: Border.all(color: Colors.grey.withOpacity(0.2)),
//           borderRadius: const BorderRadius.all(Radius.circular(15)),
//         ),
//         child: Row(
//           mainAxisAlignment:
//               MainAxisAlignment.center, // Align icons in the center
//           children: [
//             const Icon(
//               Icons.history,
//               size: 16,
//               color: Colors.white,
//             ),
//             Padding(
//               padding: const EdgeInsets.only(bottom: 8.0),
//               child: Icon(
//                 isExpanded
//                     ? Icons.arrow_drop_up_rounded
//                     : Icons.arrow_drop_down_rounded,
//                 size: 28,
//                 color: Colors.pink,
//               ),
//             ),
//           ],
//         ),
//       ),
//       children: [
//         Container(
//           decoration: BoxDecoration(
//               color: Colors.grey.withOpacity(0.3),
//               borderRadius: const BorderRadius.only(
//                   bottomLeft: Radius.circular(10),
//                   bottomRight: Radius.circular(10))),
//           child: GridView.builder(
//             shrinkWrap: true,
//             itemCount: number.length,
//             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 8,
//               crossAxisSpacing: 2,
//               childAspectRatio: 2,
//               mainAxisSpacing: 2,
//             ),
//             itemBuilder: (BuildContext context, int index) {
//               return Padding(
//                 padding: const EdgeInsets.all(2.0),
//                 child: Container(
//                   alignment: Alignment.center,
//                   decoration: BoxDecoration(
//                     color: Colors.grey.withOpacity(0.1),
//                     border: Border.all(color: Colors.grey.withOpacity(0.2)),
//                     borderRadius: const BorderRadius.all(Radius.circular(10)),
//                   ),
//                   child: Text(
//                     '${number[index].price} x',
//                     style: TextStyle(
//                         fontSize: 10, color: RandomColor().getColor()),
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
//
//   late IO.Socket _socket;
//   dynamic receiveData = {};
//   bool _isMounted = false;
//   void connectToServer() {
//     _socket = IO.io(
//       'http://13.234.226.39:3006',
//       IO.OptionBuilder().setTransports(['websocket']).build(),
//     );
//     _socket.on('connect', (_) {
//       if (kDebugMode) {
//         print('Connected');
//       }
//     });
//     _socket.onConnectError((data) {
//       if (kDebugMode) {
//         print('Connection error: $data');
//       }
//     });
//     _socket.on('aviatoray', (data) {
//       // {
//       //    "betTime": 10,
//       //    "status": 1,
//       //    "period": "10",
//       //    "timer": "1.35"
//       // }
//       if (_isMounted) {
//         setState(() {
//           receiveData = jsonDecode(data);
//           print(receiveData);
//           print('receiveData');
//         });
//       }
//       if (receiveData['status'] == 1 && receiveData['timer'] == '1.00') {
//         animationControl();
//       }
//
//       if (receiveData['status'] == 2) {
//         damibet.clear();
//        // planFlew();
//         resultHistory();
//       }
//     });
//     _socket.connect();
//   }
//
//   animationControl() async {
//     _controller = AnimationController(
//       duration: const Duration(seconds: 5), // Set the animation duration
//       vsync: this,
//     );
//     _animation =
//         Tween<double>(begin: 20, end: height * 0.31).animate(_controller);
//     _animation.addListener(() {
//       setState(() {});
//       if (_controller.status == AnimationStatus.completed) {
//
//         _animation = Tween<double>(begin: height * 0.25, end: height * 0.35)
//             .animate(_controller);
//
//         Future.delayed(const Duration(seconds: 10));
//         animationAmm();
//       }
//
//     });
//     _controller.forward();
//   }
//
//   planFlew() {
//     _controllerflew = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 2),
//     );
//
//     _animationflew = Tween<Offset>(
//       begin:  Offset(0.0, 0.0),
//       end:  Offset(1.0, -1.0),
//     ).animate(CurvedAnimation(
//       parent: _controllerflew,
//       curve: Curves.easeInOut,
//     ));
//     _controllerflew.forward();
//   }
//
//   Future<void> resultHistory() async {
//     const url = '${ApiUrl.resultHistory}16';
//     final response = await http.get(Uri.parse(url));
//     if (response.statusCode == 200) {
//       final List<dynamic> responseData = json.decode(response.body)['data'];
//       setState(() {
//         gamesNo =
//             (int.parse(responseData[0]['gamesno'].toString()) + 1).toString();
//         number = responseData
//             .map((item) => ResultHistoryModel.fromJson(item))
//             .toList();
//       });
//     } else if (response.statusCode == 400) {
//     } else {
//       setState(() {
//         number = [];
//       });
//       throw Exception('Failed to load data');
//     }
//   }
//
//   Widget _rowMarquee() {
//     return CustomMarquee(
//       key: Key("$_useRtlText"),
//       text: '          🏐          ',
//       style: TextStyle(
//           fontWeight: FontWeight.w900,
//           fontSize: 4,
//           color: Colors.blueAccent.shade700),
//       velocity: 30.0,
//       textDirection: TextDirection.rtl,
//       scrollAxis: Axis.vertical,
//       blankSpace: height * 0.1,
//     );
//   }
//
//   Widget imageBg() {
//     return AnimatedBuilder(
//         animation: _controllers,
//         builder: (_, child) {
//           return Transform.rotate(
//             angle: _controllers.value * 170 * math.pi,
//             child: const Image(
//               image: AssetImage(AviatorAssets.aviatorChakra),
//             ),
//           );
//         });
//   }
//   animation() async {
//     if (receiveData['status'] == 2) {
//       await Future.delayed(const Duration(milliseconds: 500));
//       if (_controller.status == AnimationStatus.completed) {
//         _controller.reverse();
//       } else if (_controller.status == AnimationStatus.dismissed) {
//         _controller.forward();
//       }
//       animation();
//     }
//   }
//
//   Widget _buildMarquee() {
//     return CustomMarquee(
//       key: Key("$_useRtlText"),
//       text: '🏐',
//       style: const TextStyle(
//           fontWeight: FontWeight.w900, fontSize: 4, color: Colors.white),
//       velocity: 30.0,
//       blankSpace: width * 0.15,
//     );
//   }
//
//
//   late Animation<double> _animation;
//   animationAmm() async {
//     if (receiveData['status'] == 2) {
//       await Future.delayed(const Duration(milliseconds: 500));
//       if (_controller.status == AnimationStatus.completed) {
//         _controller.reverse();
//       } else if (_controller.status == AnimationStatus.dismissed) {
//         _controller.forward();
//       }
//       animationAmm();
//     }
//   }
//
//   aviator(double height, double width) {
//     return SizedBox(
//       height: height,
//       width: width,
//       child: Container(
//         alignment: Alignment.bottomLeft,
//         height: _animation.value,
//         width: _animation.value,
//         child: Stack(
//           clipBehavior: Clip.none,
//           children: [
//            CustomPaint(
//                     painter: MyPainter(_animation.value),
//                     size: Size(_animation.value, _animation.value / 1.5),
//                   ),
//             Positioned(
//                 right: -width * 0.2,
//                 top: -height * 0.10,
//                 child: const Image(
//                     image: AssetImage(AviatorAssets.aviatorPlane),
//                     height: 40,
//                     width: 100)),
//           ],
//         ),
//       ),
//     );
//   }
//
//   var rnd = Random();
//   double xtime = 1.0;
//
//   // void Demoremove() async {
//   //   for (var i = 0; i < 40; i++) {
//   //     int amount = rnd.nextInt(40);
//   //     int memid = rnd.nextInt(2000);
//   //
//   //     await Future.delayed(const Duration(milliseconds: 10000));
//   //
//   //     int indexToUpdate = rnd.nextInt(damibet.length);
//   //
//   //     if (indexToUpdate < damibet.length) {
//   //       damibet[indexToUpdate] = Demo(
//   //         name: 'Memberid$memid',
//   //         amount: double.parse((amount * 10).toString()),
//   //         x: xtime.toStringAsFixed(2),
//   //         winners: (double.parse((amount * 10).toString()) * xtime)
//   //             .toStringAsFixed(2),
//   //         color: 1,
//   //       );
//   //     }
//   //
//   //     setState(() {});
//   //
//   //     await Future.delayed(const Duration(milliseconds: 10000));
//   //
//   //     if (indexToUpdate < damibet.length) {
//   //       damibet.removeAt(indexToUpdate);
//   //     }
//   //
//   //     setState(() {});
//   //   }
//   // }
//
//   demoBet() async {
//     if (receiveData['status'] == 1) {
//       for (var i = 0; i < 80; i++) {
//         int memid = rnd.nextInt(2000);
//         int amount = rnd.nextInt(9);
//         await Future.delayed(const Duration(milliseconds: 500));
//         damibet.add(Demo(
//             name: 'Memberid$memid',
//             amount: double.parse((amount * 10).toString()),
//             x: '',
//             winners: '',
//             color: 0));
//         setState(() {});
//       }
//     }
//   }
// }
//
// class MyPainter extends CustomPainter {
//   final double animationValue;
//
//   MyPainter(this.animationValue);
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     final path = drawPath(size.width, size.height, animationValue);
//
//     final paint = Paint()
//       ..color = Colors.redAccent.withOpacity(0.7)
//       ..style = PaintingStyle.fill;
//
//     final borderPaint = Paint()
//       ..color = Colors.red.shade900 // Change border color
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 4.0; // Change border width
//
//     canvas.drawPath(path, paint);
//     canvas.drawPath(path, borderPaint);
//   }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return true;
//   }
// }
//
// Path drawPath(double canvasWidth, double chartHeight, double animationValue) {
//   final path = Path();
//   final segmentWidth = canvasWidth / 2 / 2;
//   path.moveTo(0, chartHeight);
//   path.cubicTo(
//     segmentWidth,
//     chartHeight,
//     4 * segmentWidth,
//     80,
//     canvasWidth,
//     0,
//   );
//   path.lineTo(canvasWidth, chartHeight);
//   path.close();
//
//   return path;
// }
