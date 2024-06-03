import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minimal_pomodoro_timer/helper/vibration_service.dart';
import 'package:minimal_pomodoro_timer/provider/short_break_duration_provider.dart';

import '../helper/enum.dart';
import '../helper/notification_helpr.dart';
import 'focus_count_provider.dart';
import 'focus_duration_provider.dart';
import 'left_time_provider.dart';
import 'long_break_duration_provider.dart';
import 'long_break_interval_provider.dart';
import 'short_break_count_provider.dart';
import 'timer_item_provider.dart';
import 'timer_stopped_provider.dart';

void resetTimer(WidgetRef ref) {
  ref.read(focusCountProvider.notifier).reset();
  ref.read(shortBreakCountProvider.notifier).reset();
  ref.read(timerItemProvider.notifier).setItem(TimerItem.focus);
  ref.read(timerStoppedProvider.notifier).setTimerStopped();
  ref.read(leftTimeProvider.notifier).reset(ref.watch(focusDurationProvider));

  FlutterLocalNotificationsPlugin().cancel(notificationId);
  VibrationService().stopVibrate();
}

void nextTimer(WidgetRef ref) {
  final timerItem = ref.read(timerItemProvider);
  final focusCount = ref.read(focusCountProvider);
  final focusDuration = ref.read(focusDurationProvider);
  final shortBreakCount = ref.read(shortBreakCountProvider);
  final shortBreakDuration = ref.read(shortBreakDurationProvider);
  final longBreakDuration = ref.read(longBreakDurationProvider);
  final longBreakInterval = ref.read(longBreakIntervalProvider);
  final totalFocusCount = longBreakInterval;

  switch (timerItem) {
    case TimerItem.focus:
      if (focusCount >= totalFocusCount) {
        ref.read(leftTimeProvider.notifier).reset(longBreakDuration);
        ref.read(timerItemProvider.notifier).setItem(TimerItem.longBreak);
      } else {
        ref.read(shortBreakCountProvider.notifier).set(focusCount);
        ref.read(leftTimeProvider.notifier).reset(shortBreakDuration);
        ref.read(timerItemProvider.notifier).setItem(TimerItem.shortBreak);
      }
      break;
    case TimerItem.shortBreak:
      ref.read(focusCountProvider.notifier).set(shortBreakCount + 1);
      ref.read(timerItemProvider.notifier).setItem(TimerItem.focus);
      ref.read(leftTimeProvider.notifier).reset(focusDuration);
      break;
    case TimerItem.longBreak:
      ref.read(focusCountProvider.notifier).set(1);
      ref.read(timerItemProvider.notifier).setItem(TimerItem.focus);
      ref.read(leftTimeProvider.notifier).reset(focusDuration);
      break;
  }
  ref.read(timerStoppedProvider.notifier).setTimerStopped();

  FlutterLocalNotificationsPlugin().cancel(notificationId);
  VibrationService().stopVibrate();
}

void prevTimer(WidgetRef ref) {
  final timerItem = ref.read(timerItemProvider);
  final focusCount = ref.read(focusCountProvider);
  final shortBreakCount = ref.read(shortBreakCountProvider);
  final focusDuration = ref.read(focusDurationProvider);
  final shortBreakDuration = ref.read(shortBreakDurationProvider);
  final longBreakDuration = ref.read(longBreakDurationProvider);
  final longBreakInterval = ref.read(longBreakIntervalProvider);
  final totalFocusCount = longBreakInterval;

  switch (timerItem) {
    case TimerItem.focus:
      if (focusCount == 1) {
        ref.read(timerItemProvider.notifier).setItem(TimerItem.longBreak);
        ref.read(leftTimeProvider.notifier).reset(longBreakDuration);
      } else {
        ref.read(shortBreakCountProvider.notifier).set(focusCount - 1);
        ref.read(timerItemProvider.notifier).setItem(TimerItem.shortBreak);
        ref.read(leftTimeProvider.notifier).reset(shortBreakDuration);
      }
      break;
    case TimerItem.shortBreak:
      ref.read(focusCountProvider.notifier).set(shortBreakCount);
      ref.read(timerItemProvider.notifier).setItem(TimerItem.focus);
      ref.read(leftTimeProvider.notifier).reset(focusDuration);
      break;
    case TimerItem.longBreak:
      ref.read(focusCountProvider.notifier).set(totalFocusCount);
      ref.read(timerItemProvider.notifier).setItem(TimerItem.focus);
      ref.read(leftTimeProvider.notifier).reset(focusDuration);
      break;
  }
  ref.read(timerStoppedProvider.notifier).setTimerStopped();

  FlutterLocalNotificationsPlugin().cancel(notificationId);
  VibrationService().stopVibrate();
}
