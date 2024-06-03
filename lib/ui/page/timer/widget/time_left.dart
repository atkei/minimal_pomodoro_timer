import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minimal_pomodoro_timer/provider/focus_duration_provider.dart';
import 'package:minimal_pomodoro_timer/provider/hide_left_time_provider.dart';
import 'package:minimal_pomodoro_timer/provider/left_time_provider.dart';
import 'package:minimal_pomodoro_timer/provider/long_duration_provider.dart';
import 'package:minimal_pomodoro_timer/provider/timer_item_provider.dart';
import 'package:minimal_pomodoro_timer/provider/timer_stopped_provider.dart';
import 'package:tuple/tuple.dart';

import '../../../../helper/enum.dart';
import '../../../../provider/app_lifecycle_state_provider.dart';
import '../../../../provider/focus_progress_color_provider.dart';
import '../../../../provider/long_break_progress_color_provider.dart';
import '../../../../provider/short_break_duration_provider.dart';
import '../../../../provider/short_break_progress_color_provider.dart';
import '../../../../provider/theme_provider.dart';

class TimeLeft extends ConsumerWidget {
  const TimeLeft({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hideLeftTime = ref.watch(hideLeftTimeProvider);
    final isDark = ref.watch(isDarkProvider);

    ref.listen<AppLifecycleState>(appLifecycleProvider, (previous, next) {
      if (next == AppLifecycleState.paused) {
        // Cancel timer count when transitioning to background.
        ref.read(leftTimeProvider.notifier).cancel();
      } else if (next == AppLifecycleState.resumed) {
        // Resume timer count when transitioning to foreground.
        ref.read(leftTimeProvider.notifier).resume();
      }
    });

    Tuple2<Duration, double> leftTimeProgressTuple =
        _toTimeLeftDurationAndProgress(ref);
    final timerText =
        (hideLeftTime) ? '' : _toTimerString(leftTimeProgressTuple.item1);

    final screenSize = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;
    final width = (orientation == Orientation.portrait)
        ? screenSize.height * 0.25
        : screenSize.width * 0.25;
    final height = (orientation == Orientation.portrait)
        ? screenSize.height * 0.25
        : screenSize.width * 0.25;
    var fontSize = width * 0.15;

    if (kDebugMode) {
      print("Left time font size: $fontSize");
    }

    final progressBackGroundColor = (isDark)
        ? CupertinoColors.darkBackgroundGray
        : CupertinoColors.lightBackgroundGray;

    return SizedBox(
      width: width,
      height: height,
      child: LayoutBuilder(builder: (context, constraints) {
        return Stack(
          children: [
            Center(
              child: SizedBox(
                width: width,
                height: height,
                child: CircularProgressIndicator(
                  backgroundColor: progressBackGroundColor,
                  strokeWidth: constraints.maxWidth * 0.035,
                  valueColor: AlwaysStoppedAnimation(_toIndicatorColor(ref)),
                  value: leftTimeProgressTuple.item2,
                ),
              ),
            ),
            Center(child: Text(timerText, style: TextStyle(fontSize: fontSize)))
          ],
        );
      }),
    );
  }

  Tuple2<Duration, double> _toTimeLeftDurationAndProgress(WidgetRef ref) {
    final leftTime = ref.watch(leftTimeProvider);
    final timerItem = ref.watch(timerItemProvider);
    final isTimerStopped = ref.watch(timerStoppedProvider);
    final focusDuration = ref.watch(focusDurationProvider);
    final shortBreakDuration = ref.watch(shortBreakDurationProvider);
    final longBreakDuration = ref.watch(longBreakDurationProvider);

    Duration lt;
    double progress;
    if (isTimerStopped) {
      progress = 100;
      if (timerItem == TimerItem.focus) {
        lt = focusDuration;
      } else if (timerItem == TimerItem.shortBreak) {
        lt = shortBreakDuration;
      } else {
        lt = longBreakDuration;
      }
    } else {
      lt = leftTime;
      if (timerItem == TimerItem.focus) {
        progress =
            (focusDuration.inSeconds - lt.inSeconds) / focusDuration.inSeconds;
      } else if (timerItem == TimerItem.shortBreak) {
        progress = (shortBreakDuration.inSeconds - lt.inSeconds) /
            shortBreakDuration.inSeconds;
      } else {
        progress = (longBreakDuration.inSeconds - lt.inSeconds) /
            longBreakDuration.inSeconds;
      }
    }

    return Tuple2<Duration, double>(lt, progress);
  }

  Color _toIndicatorColor(WidgetRef ref) {
    final timerItem = ref.watch(timerItemProvider);
    final focusProgressColor = ref.watch(focusProgressColorProvider);
    final shortBreakProgressColor = ref.watch(shortBreakProgressColorProvider);
    final longBreakProgressColor = ref.watch(longBreakProgressColorProvider);

    switch (timerItem) {
      case TimerItem.focus:
        return focusProgressColor;
      case TimerItem.shortBreak:
        return shortBreakProgressColor;
      case TimerItem.longBreak:
        return longBreakProgressColor;
    }
  }

  String _toTimerString(Duration duration) {
    var hoursVal = duration.inHours;
    var hours = hoursVal.toString();
    var minutesVal = duration.inMinutes - duration.inHours * 60;
    var minutes =
        (minutesVal < 10) ? "0" + minutesVal.toString() : minutesVal.toString();
    var secondsVal = duration.inSeconds - duration.inMinutes * 60;
    var seconds =
        (secondsVal < 10) ? "0" + secondsVal.toString() : secondsVal.toString();
    if (hoursVal > 0) {
      return hours + ":" + minutes + ":" + seconds;
    } else {
      return minutes + ":" + seconds;
    }
  }
}
