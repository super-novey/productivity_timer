import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:productivity_timer/controllers/timer.dart';
import 'package:productivity_timer/models/timer_model.dart';
import 'package:productivity_timer/widgets/productivity_button.dart';

class TimerHomePage extends StatelessWidget {
  TimerHomePage({super.key});
  final CountDownTimer timer = CountDownTimer();

  @override
  Widget build(BuildContext context) {
    final double widthScreen = MediaQuery.of(context).size.width;
    timer.startWork();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: const Text(
          "My work timer",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: ProductivityButton(
                        color: const Color(0xff009688),
                        text: "Work",
                        onPressed: emptyMethod),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: ProductivityButton(
                        color: const Color(0xff607D8B),
                        text: "Short Break",
                        onPressed: () => timer.startBreak(true)),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: ProductivityButton(
                        color: const Color(0xff455A64),
                        text: "Long Break",
                        onPressed: () => timer.startBreak(false)),
                  ),
                ],
              ),
            ),
            Expanded(
                child: StreamBuilder(
                    initialData: '00:00',
                    stream: timer.stream(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      TimerModel timer = (snapshot.data == '00:00')
                          ? TimerModel('00:00', 1)
                          : snapshot.data;
                      return CircularPercentIndicator(
                        radius: widthScreen / 2.3,
                        percent: timer.percent,
                        lineWidth: 10,
                        progressColor: const Color(0xff009688),
                        center: Text(
                          timer.time,
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                      );
                    })),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: ProductivityButton(
                        color: const Color(0xff212121),
                        text: "Stop",
                        onPressed: () => timer.stopTimer()),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: ProductivityButton(
                        color: const Color(0xff009688),
                        text: "Restart",
                        onPressed: () => timer.startTimer()),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }

  void emptyMethod() {}
}
