import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Loader extends StatelessWidget {
  final String lottieURL;
  final List tasks;
  final String doneAllTaskMessage;

  const Loader({
    Key? key,
    required this.lottieURL,
    required this.tasks,
    required this.doneAllTaskMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        /// Lottie Animation
        FadeIn(
          child: SizedBox(
            width: 200,
            height: 200,
            child: Lottie.asset(
              lottieURL,
              animate: tasks.isNotEmpty ? false : true,
            ),
          ),
        ),

        /// Bottom Texts
        FadeInUp(
          from: 30,
          child: Text(doneAllTaskMessage),
        ),
      ],
    );
  }
}
