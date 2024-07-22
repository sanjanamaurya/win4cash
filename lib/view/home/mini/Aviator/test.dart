import 'dart:async';
import 'package:flutter/material.dart';



class testest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Linear Progress Indicator'),
        ),
        body: Center(
          child: ProgressWidget(),
        ),
      ),
    );
  }
}

class ProgressWidget extends StatefulWidget {
  @override
  _ProgressWidgetState createState() => _ProgressWidgetState();
}

class _ProgressWidgetState extends State<ProgressWidget> {
  int WaitingTimeSeconds = 30;
  int elapsedSeconds = 25;
  Timer? timer_progress;

  @override
  void initState() {
    super.initState();
    startTimerProgress();
  }

  @override
  void dispose() {
    timer_progress?.cancel();
    super.dispose();
  }

  void startTimerProgress() {
    timer_progress = Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        if (elapsedSeconds < WaitingTimeSeconds) {
          elapsedSeconds++;
        } else {
          t.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        LinearProgressIndicator(
          value: elapsedSeconds / WaitingTimeSeconds,
        ),
        SizedBox(height: 20),
        Text('${((elapsedSeconds / WaitingTimeSeconds) * 100).toStringAsFixed(0)}%'),
      ],
    );
  }
}