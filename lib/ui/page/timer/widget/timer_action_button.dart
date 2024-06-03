import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minimal_pomodoro_timer/provider/left_time_provider.dart';
import 'package:minimal_pomodoro_timer/provider/timer_stopped_provider.dart';
import 'package:minimal_pomodoro_timer/ui/page/timer/widget/button/complete_button.dart';
import 'package:minimal_pomodoro_timer/ui/page/timer/widget/button/start_button.dart';

class TimerActionButton extends ConsumerWidget {
  const TimerActionButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orientation = MediaQuery.of(context).orientation;
    final screenSize = MediaQuery.of(context).size;
    final timeLeft = ref.watch(leftTimeProvider);
    final isStopped = ref.watch(timerStoppedProvider);
    final width = (orientation == Orientation.portrait)
        ? screenSize.height * 0.25
        : screenSize.width * 0.3;
    final height = (orientation == Orientation.portrait)
        ? screenSize.height * 0.3
        : screenSize.width * 0.25;

    return SizedBox(
      width: width,
      height: height,
      child: _setButton(isStopped, timeLeft),
    );
  }

  Widget _setButton(bool isStopped, Duration timeLeft) {
    if (isStopped) {
      return const StartButton();
    } else if (!isStopped && timeLeft.inSeconds > 0) {
      return const SizedBox.shrink();
    } else {
      return const CompleteButton();
    }
  }
}
