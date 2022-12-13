import 'dart:async';

import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hexcolor/hexcolor.dart';

import 'details.dart';

class HomePage2 extends StatefulWidget {
  const HomePage2({super.key});

  @override
  State<HomePage2> createState() => _HomePageState2();
}

class _HomePageState2 extends State<HomePage2> {
  Timer? timer;
  Timer? timer_btn2;
  int counter = 0;
  int localCounter = 0;
  bool TimerIsRunning = false;
  int counter_Btn2 = 0;
  int localCounter_Btn2 = 0;
  bool TimerIsRunning_Btn2 = false;

  void startTimer() {
    TimerIsRunning = true;
    timer = Timer.periodic(Duration(milliseconds: 1), (timer) {
      setState(() {
        counter = localCounter + timer.tick;
      });
    });
  }

  void startTimer_Btn2() {
    TimerIsRunning_Btn2 = true;
    timer_btn2 = Timer.periodic(Duration(milliseconds: 1), (timer) {
      setState(() {
        counter_Btn2 = localCounter_Btn2 + timer.tick;
      });
    });
  }

  String fromDurationToTxet(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    int twoDigitMilliSeconds = duration.inMilliseconds.remainder(1000);
    String lastPart =
        (twoDigitMilliSeconds / 10).floor().toString().padLeft(2, "0");
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds:$lastPart";
  }

  // HexColor('#F3EFE0')
  // HexColor('#434242')
  Color backgroundColor = HexColor('#434242');
  Color secondColor = HexColor('#F3EFE0');
  Color ThirdColor = HexColor('#22A39F');

  void stop() {
    localCounter = counter;
    timer!.cancel();
    TimerIsRunning = false;
  }

  void stop_Btn2() {
    localCounter_Btn2 = counter_Btn2;
    timer_btn2!.cancel();
    TimerIsRunning_Btn2 = false;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: DoubleBackToCloseApp(
          snackBar: const SnackBar(
            content: Text('Tap back again to leave'),
          ),
          child: Container(
            height: double.infinity,
            width: double.infinity,
            color: backgroundColor,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: secondColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    HexColor('#22A39F'))),
                            onPressed: () {
                              if (!TimerIsRunning) {
                                startTimer();
                                startTimer_Btn2();
                              } else {
                                bool btn2_wasRunning = TimerIsRunning_Btn2;
                                stop();
                                stop_Btn2();
                                showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                            title: Text('Are you sure?'),
                                            actions: [
                                              TextButton(
                                                child: const Text(
                                                  'yes',
                                                  style: TextStyle(
                                                      color: Colors.blue),
                                                ),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              DetailsScreen(
                                                                  timer1: Duration(
                                                                      milliseconds:
                                                                          counter),
                                                                  timer2: Duration(
                                                                      milliseconds:
                                                                          counter_Btn2)))).then(
                                                      (value) {
                                                    setState(() {
                                                      localCounter = 0;
                                                      counter = 0;
                                                      TimerIsRunning = false;
                                                      localCounter_Btn2 = 0;
                                                      counter_Btn2 = 0;
                                                      TimerIsRunning_Btn2 = false;
                                                    });
                                                  });
                                                },
                                              ),
                                              TextButton(
                                                child: Text(
                                                  'no',
                                                  style: TextStyle(
                                                      color: Colors.red),
                                                ),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                  startTimer();
                                                  if (btn2_wasRunning) {
                                                    startTimer_Btn2();
                                                  }
                                                },
                                              ),
                                            ]));
                              }
                            },
                            child:
                                Text(TimerIsRunning == false ? 'Start' : 'finsh'),
                          ),
                          //
                          Text(
                            fromDurationToTxet(Duration(milliseconds: counter)),
                            style: TextStyle(
                                color: HexColor('#22A39F'),
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: secondColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Text(
                            fromDurationToTxet(Duration(milliseconds: counter_Btn2)),
                            style: TextStyle(
                                color: ThirdColor,
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: GestureDetector(
                                onTap: () {
                                  if (TimerIsRunning) {
                                    if (!TimerIsRunning_Btn2) {
                                      startTimer_Btn2();
                                    } else {
                                      stop_Btn2();
                                    }
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text('ERR')));
                                  }
                                },
                                child: Container(
                                  width: double.infinity,
                                  child: CircleAvatar(
                                    backgroundColor: HexColor('#222222'),
                                    child: LayoutBuilder(
                                      builder: (context, constraints) {
                                        return Icon(
                                          TimerIsRunning_Btn2
                                              ? Icons.pause
                                              : Icons.play_arrow,
                                          color: Colors.white,
                                          size: constraints.biggest.height * 0.7,
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
