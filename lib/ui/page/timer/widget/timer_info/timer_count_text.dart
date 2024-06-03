import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minimal_pomodoro_timer/provider/long_break_interval_provider.dart';

import '../../../../../helper/enum.dart';
import '../../../../../provider/focus_count_provider.dart';
import '../../../../../provider/hide_timer_count_provider.dart';
import '../../../../../provider/short_break_count_provider.dart';
import '../../../../../provider/timer_item_provider.dart';

class TimerCountText extends ConsumerWidget {
  const TimerCountText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final focusCount = ref.watch(focusCountProvider);
    final shortBreakCount = ref.watch(shortBreakCountProvider);
    final timerItem = ref.watch(timerItemProvider);
    final longBreakInterval = ref.watch(longBreakIntervalProvider);
    final hideTimerCount = ref.watch(hideTimerCountProvider);
    final totalFocusCount = longBreakInterval;
    final totalShortBreakCount = longBreakInterval - 1;

    var countString = "";
    if (!hideTimerCount) {
      if (timerItem == TimerItem.focus) {
        countString = "$focusCount / $totalFocusCount";
      } else if (timerItem == TimerItem.shortBreak) {
        countString = "$shortBreakCount / $totalShortBreakCount";
      } else {
        countString = "";
      }
    }

    return LayoutBuilder(builder: (context, constraints) {
      final orientation = MediaQuery.of(context).orientation;
      final fontSize = (orientation == Orientation.portrait)
          ? constraints.maxHeight * 0.28
          : constraints.maxWidth * 0.08;
      if (kDebugMode) {
        print("Timer count font size: $fontSize");
      }
      return Text(countString, style: TextStyle(fontSize: fontSize));
    });
  }
}
