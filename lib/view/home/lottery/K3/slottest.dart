//
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:win4cash/view/home/lottery/K3/k_3_slotmachine/slotmachine.dart';
//
// ///
// class SlotNumberImageScreen extends StatefulWidget {
//   const SlotNumberImageScreen({Key? key}) : super(key: key);
//
//   @override
//   State<SlotNumberImageScreen> createState() => _SlotNumberImageScreenState();
// }
//
// class _SlotNumberImageScreenState extends State<SlotNumberImageScreen>
//     with WidgetsBindingObserver, SingleTickerProviderStateMixin {
//   final TextEditingController _numberControllerInput = TextEditingController();
//   late SlotMachineImageController _numberController;
//   bool _isSlotMachineRunning = false;
//
//
//
//   @override
//   void initState() {
//     super.initState();
//
//   }
//
//   void _handleSlotMachineTap() {
//     if (!_isSlotMachineRunning) {
//       final input = _numberControllerInput.text;
//       if (input.length == 3 && input.runes.every((r) => r >= 49 && r <= 54)) {
//         final selectedNumbers = input.runes.map((r) => r - 48).toList();
//         setState(() {
//           _isSlotMachineRunning = true;
//           _numberController.start(hitRollItemIndexes: selectedNumbers);
//           for (int i = 0; i < 3; i++) {
//             Future.delayed(Duration(seconds: 1 + i), () {
//               _numberController.stop(reelIndex: i, resultIndex: selectedNumbers[i]);
//               if (i == 2) {
//                 setState(() {
//                   _isSlotMachineRunning = false;
//                 });
//               }
//             });
//           }
//         });
//       } else {
//         _showInvalidNumberDialog();
//       }
//     }
//   }
//
//   void _showInvalidNumberDialog() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text("Invalid Number"),
//           content: const Text("Please enter a number between 111 and 666."),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: const Text("OK"),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final height = MediaQuery.of(context).size.height;
//     final width = MediaQuery.of(context).size.width;
//     return Scaffold(
//       body: Row(
//         children: [
//           Expanded(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     SizedBox(
//                       height: height / 16,
//                       width: width / 2.5,
//                       child: TextField(
//                         controller: _numberControllerInput,
//                         keyboardType: TextInputType.number,
//                         decoration: const InputDecoration(
//                           border: OutlineInputBorder(),
//                           labelText: 'Enter any 3 numbers between 1 - 6 ',
//                         ),
//                       ),
//                     ),
//                     InkWell(
//                       onTap: _handleSlotMachineTap,
//                       child: Container(
//                         height: height / 12,
//                         width: width / 8,
//                         decoration: const BoxDecoration(
//                           color: Colors.red,
//                           // Add more decoration as needed
//                         ),
//                         child: const Icon(Icons.play_arrow, color: Colors.white),
//                       ),
//                     ),
//                   ],
//                 ),
//                 Container(
//                   clipBehavior: Clip.none,
//                   height: height / 1.5,
//                   width: width / 1.5,
//                   decoration: const BoxDecoration(
//                     color: Colors.blue,
//                   ),
//                   child: SlotMachineNumber(
//                     rollItems: List.generate(
//                       6,
//                           (index) => RollItemNumber(
//                         index: index + 1, // Adjust index to start from 1
//                       ),
//                     ),
//
//                     onCreated: (controller) {
//                       _numberController = controller;
//                     },
//                     onFinished: (resultIndexes) {
//                       if (kDebugMode) {
//                         print('Result: $resultIndexes');
//                       }
//                     },
//                     digitToImageMap: digitToImageMap,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }