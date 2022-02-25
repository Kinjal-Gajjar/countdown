import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:timer/button_widget.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  static const maxSeconds = 60;
  int seconds = maxSeconds;
  Timer? timer;
  void startTime({bool reset = true}) {
    if (reset) {
      resetTimer();
    }
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      if (seconds > 0) {
        setState(() {
          seconds--;
        });
      } else {
        stopTimer(reset: false);
      }
    });
  }

  void resetTimer() {
    setState(() => seconds = maxSeconds);
  }

  void stopTimer({bool reset = true}) {
    if (reset) {
      resetTimer();
    }
    setState(() {
      timer?.cancel();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xAA0e0d1d),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildTimer(),
          SizedBox(
            height: 80,
          ),
          bulidButtons(),
        ],
      )),
    );
  }

  Widget bulidButtons() {
    final isRunning = timer == null ? false : timer!.isActive;
    final isCompleted = seconds == maxSeconds || seconds == 0;

    return isRunning || !isCompleted
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ButtonWidget(
                text: isRunning ? 'Pause' : 'Resume',
                onClicked: () {
                  if (isRunning) {
                    stopTimer(reset: false);
                  } else {
                    startTime(reset: false);
                  }
                },
                color: Colors.white,
                backgroundcolor: Color(0xff98042E),
              ),
              SizedBox(
                width: 12,
              ),
              ButtonWidget(
                text: 'Cancle',
                onClicked: stopTimer,
                color: Colors.white,
                backgroundcolor: Color(0xff4A0A25),
              ),
            ],
          )
        : ButtonWidget(
            text: 'Start Timer!',
            color: Colors.white,
            backgroundcolor: Color(0xff98042E),
            onClicked: () {
              startTime();
            });
  }

  Widget buildTimer() => SizedBox(
        height: 200,
        width: 200,
        child: Stack(
          fit: StackFit.expand,
          children: [
            CircularProgressIndicator(
              value: 1 - seconds / maxSeconds,
              strokeWidth: 12,
              valueColor: AlwaysStoppedAnimation(Color(0xff98042E)),
              backgroundColor: Color(0xff262533),
            ),
            Center(
              child: buildTime(),
            )
          ],
        ),
      );

  Widget buildTime() {
    if (seconds == 0) {
      return Icon(
        Icons.done,
        color: Colors.greenAccent,
        size: 112,
      );
    } else {
      return Text(
        '$seconds',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: 80,
        ),
      );
    }
  }
}
