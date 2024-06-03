import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minimal_pomodoro_timer/helper/notification_helpr.dart';
import 'package:minimal_pomodoro_timer/provider/focus_duration_provider.dart';
import 'package:minimal_pomodoro_timer/provider/left_time_provider.dart';
import 'package:minimal_pomodoro_timer/provider/long_break_interval_provider.dart';
import 'package:minimal_pomodoro_timer/provider/long_duration_provider.dart';
import 'package:minimal_pomodoro_timer/provider/short_break_duration_provider.dart';
import 'package:minimal_pomodoro_timer/provider/timer_stopped_provider.dart';

import '../../../../../custom_icon/custom_icons_icons.dart';
import '../../../../../helper/enum.dart';
import '../../../../../provider/focus_count_provider.dart';
import '../../../../../provider/timer_item_provider.dart';

class StartButton extends ConsumerWidget {
  const StartButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timerItem = ref.watch(timerItemProvider);
    final focusDuration = ref.watch(focusDurationProvider);
    final focusCount = ref.watch(focusCountProvider);
    final longBreakInterval = ref.watch(longBreakIntervalProvider);
    final shortBreakDuration = ref.watch(shortBreakDurationProvider);
    final longBreakDuration = ref.watch(longBreakDurationProvider);
    final leftTimeState = ref.read(leftTimeProvider.notifier);
    final timerStoppedState = ref.read(timerStoppedProvider.notifier);

    String title;
    if (timerItem == TimerItem.focus) {
      if (focusCount == longBreakInterval) {
        title = AppLocalizations.of(context)!.timeLongBreak;
      } else {
        title = AppLocalizations.of(context)!.timeShortBreak;
      }
    } else {
      title = AppLocalizations.of(context)!.timeFocus;
    }

    return IconButton(
      icon: const Icon(CustomIcons.play),
      onPressed: () {
        final duration = (timerItem == TimerItem.focus)
            ? focusDuration
            : (timerItem == TimerItem.shortBreak)
                ? shortBreakDuration
                : longBreakDuration;
        scheduleTimerNotification(title, duration, ref);
        leftTimeState.start(duration);
        timerStoppedState.unsetTimerStopped();
      },
    );
  }
}
