import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class DetailsScreen extends StatelessWidget {
  DetailsScreen({super.key, required this.timer1, required this.timer2});
  final Duration timer1;
  final Duration timer2;
  String fromDurationToText(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    int twoDigitMilliSeconds = duration.inMilliseconds.remainder(1000);
    String lastPart =
        (twoDigitMilliSeconds / 10).floor().toString().padLeft(2, "0");
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds:$lastPart";
  }

  String calculateCff(
      {required Duration totalCbr, required Duration TimerCbr2}) {
    double result =
        (TimerCbr2.inSeconds.toDouble() / totalCbr.inSeconds.toDouble()) * 100;
    return '${result.floor()}%';
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: WillPopScope(
          onWillPop: () async {
            final value = await showDialog<bool>(
                context: context,
                builder: (context) =>
                    AlertDialog(title: Text('Are you sure?'), actions: [
                      TextButton(
                        child: const Text(
                          'yes',
                          style: TextStyle(color: Colors.blue),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                      ),
                      TextButton(
                        child: Text(
                          'no',
                          style: TextStyle(color: Colors.red),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ]));
            if (value != null) {
              return Future.value(value);
            } else {
              return Future.value(false);
            }
          },
          child: Container(
            color: Color(0xfff4f4f4),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    "Timer 1 is : ${fromDurationToText(timer1)}",
                  ),
                  Text('Timer 2 is : ${fromDurationToText(timer2)}'),
                  Text('CCF'),
                  Text(calculateCff(totalCbr: timer1, TimerCbr2: timer2))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
