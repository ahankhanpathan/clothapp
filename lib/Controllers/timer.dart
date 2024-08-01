import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constant/strings.dart';

class CountdownTimer extends StatefulWidget {
  @override
  _CountdownTimerState createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  late Timer _timer;
  int _secondsRemaining = 120;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
        } else {
          timer.cancel();
          Get.back();
          Get.snackbar(Strings.checkoutFailed, Strings.checkoutUpi,
              backgroundColor: Colors.red, colorText: Colors.white);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Duration duration = Duration(seconds: _secondsRemaining);
    String minutes = '${duration.inMinutes}'.padLeft(2, '0');
    String seconds = '${duration.inSeconds.remainder(60)}'.padLeft(2, '0');
    return Text(
      'Time Remaining: $minutes:$seconds',
      style: TextStyle(fontWeight: FontWeight.bold),
    );
  }
}
