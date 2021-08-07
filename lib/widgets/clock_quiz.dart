import 'package:flutter/material.dart';
import 'package:oken/providers/quiz_provider.dart';
import 'package:oken/providers/timer_provider.dart';
import 'package:provider/provider.dart';

class ClockQuiz extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    QuizProvider quizProvider = Provider.of<QuizProvider>(context);
    int time = Provider.of<TimerProvider>(context).time;
    Size size = MediaQuery.of(context).size;

    if (!quizProvider.isTalking) return Container();

    return Container(
      width: size.width,
      padding: EdgeInsets.symmetric(vertical: 10),
      color: Colors.black.withOpacity(0.6),
      child: Center(
        child: Container(
          padding: EdgeInsets.all(11),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.white)),
          child: Text(
            time.toString(),
            style: TextStyle(color: Colors.white, fontSize: size.width * 0.05),
          ),
        ),
      ),
    );
  }
}