import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minimal_pomodoro_timer/ui/page/timer/widget/time_left.dart';
import 'package:minimal_pomodoro_timer/ui/page/timer/widget/timer_action_button.dart';
import 'package:minimal_pomodoro_timer/ui/page/timer/widget/timer_info.dart';

class TimerPage extends ConsumerWidget with WidgetsBindingObserver {
  const TimerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orientation = MediaQuery.of(context).orientation;

    return (orientation == Orientation.portrait)
        ? _buildVertical(context, ref)
        : _buildHorizontal(context, ref);
  }

  Widget _buildVertical(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              TimerInfo(),
              TimeLeft(),
              TimerActionButton(),
            ]),
      ),
    );
  }

  Widget _buildHorizontal(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  TimerInfo(),
                  TimeLeft(),
                  TimerActionButton(),
                ]),
          ],
        ),
      ),
    );
  }
}
