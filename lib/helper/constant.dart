import 'package:flutter/material.dart';

import 'enum.dart';

class TimerDefault {
  TimerDefault._();

  static int focusHours = 0;
  static int focusMinutes = 25;
  static int focusSeconds = 0;
  static int shortBreakHours = 0;
  static int shortBreakMinutes = 5;
  static int shortBreakSeconds = 0;
  static int longBreakHours = 0;
  static int longBreakMinutes = 30;
  static int longBreakSeconds = 0;
  static int longBreakInterval = 3;
  static Color focusProgressColor = Colors.lightBlueAccent;
  static Color shortBreakProgressColor = Colors.greenAccent;
  static Color longBreakProgressColor = Colors.orangeAccent;

  static Duration focusDuration =
      const Duration(hours: 0, minutes: 25, seconds: 0);
  static Duration shortBreakDuration =
      const Duration(hours: 0, minutes: 5, seconds: 0);
  static Duration longBreakDuration =
      const Duration(hours: 0, minutes: 30, seconds: 0);

  static bool resumeRequired = false;
  static TimerItem resumeTimerItem = TimerItem.focus;
  static int resumeFocusCount = 1;
  static int resumeShortBreakCount = 1;

  static Duration getDuration(TimerItem item) {
    switch (item) {
      case TimerItem.focus:
        return focusDuration;
      case TimerItem.shortBreak:
        return shortBreakDuration;
      case TimerItem.longBreak:
        return longBreakDuration;
    }
  }
}
