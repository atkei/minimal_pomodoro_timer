import 'dart:ui';

import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minimal_pomodoro_timer/helper/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/timezone.dart';

import '../helper/enum.dart';

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError();
});

final sharedUtilityProvider = Provider<SharedUtility>((ref) {
  final sharedPrefs = ref.watch(sharedPreferencesProvider);
  return SharedUtility(sharedPreferences: sharedPrefs);
});

class SharedUtility {
  SharedUtility({
    required this.sharedPreferences,
  });

  final SharedPreferences sharedPreferences;

  bool isDarkModeEnabled() {
    return sharedPreferences
            .getBool(TimerPrefKey.darkThemeEnabled.toString()) ??
        true;
  }

  void setDarkModeEnabled(bool isDark) {
    sharedPreferences.setBool(TimerPrefKey.darkThemeEnabled.toString(), isDark);
  }

  bool isTimeLeftHiddenEnabled() {
    return sharedPreferences
            .getBool(TimerPrefKey.timeLeftHiddenEnabled.toString()) ??
        false;
  }

  void setTimeLeftHiddenEnabled(bool isHidden) {
    sharedPreferences.setBool(
        TimerPrefKey.timeLeftHiddenEnabled.toString(), isHidden);
  }

  bool isTimerItemHiddenEnabled() {
    return sharedPreferences
            .getBool(TimerPrefKey.timerItemHiddenEnabled.toString()) ??
        false;
  }

  void setTimerItemHiddenEnabled(bool isHidden) {
    sharedPreferences.setBool(
        TimerPrefKey.timerItemHiddenEnabled.toString(), isHidden);
  }

  bool isTimerCountHiddenEnabled() {
    return sharedPreferences
            .getBool(TimerPrefKey.timerCountHiddenEnabled.toString()) ??
        false;
  }

  void setTimerCountHiddenEnabled(bool isHidden) {
    sharedPreferences.setBool(
        TimerPrefKey.timerCountHiddenEnabled.toString(), isHidden);
  }

  bool isMenuHiddenEnabled() {
    return sharedPreferences
            .getBool(TimerPrefKey.menuHiddenEnable.toString()) ??
        false;
  }

  void setMenuHiddenEnabled(bool isHidden) {
    sharedPreferences.setBool(
        TimerPrefKey.menuHiddenEnable.toString(), isHidden);
  }

  void saveFocusProgressColor(Color color) {
    sharedPreferences.setInt(
        TimerPrefKey.focusProgressColor.toString(), color.value);
  }

  Color getFocusProgressColor() {
    int? colorValue =
        sharedPreferences.getInt(TimerPrefKey.focusProgressColor.toString());
    if (colorValue == null) {
      return TimerDefault.focusProgressColor;
    } else {
      return Color(colorValue);
    }
  }

  Color getShortBreakProgressColor() {
    int? colorValue = sharedPreferences
        .getInt(TimerPrefKey.shortBreakProgressColor.toString());
    if (colorValue == null) {
      return TimerDefault.shortBreakProgressColor;
    } else {
      return Color(colorValue);
    }
  }

  void saveShortBreakProgressColor(Color color) {
    sharedPreferences.setInt(
        TimerPrefKey.shortBreakProgressColor.toString(), color.value);
  }

  Color getLongBreakProgressColor() {
    int? colorValue = sharedPreferences
        .getInt(TimerPrefKey.longBreakProgressColor.toString());
    if (colorValue == null) {
      return TimerDefault.longBreakProgressColor;
    } else {
      return Color(colorValue);
    }
  }

  void saveLongBreakProgressColor(Color color) {
    sharedPreferences.setInt(
        TimerPrefKey.longBreakProgressColor.toString(), color.value);
  }

  bool isWakelockEnabled() {
    return sharedPreferences.getBool(TimerPrefKey.wakeLockEnabled.toString()) ??
        true;
  }

  void setWakelockEnabled(bool enabled) {
    sharedPreferences.setBool(TimerPrefKey.wakeLockEnabled.toString(), enabled);
  }

  bool isRingToneEnabled() {
    return sharedPreferences.getBool(TimerPrefKey.ringToneEnabled.toString()) ??
        false;
  }

  void setRingToneEnabled(bool enabled) {
    sharedPreferences.setBool(TimerPrefKey.ringToneEnabled.toString(), enabled);
  }

  int getVibrationCount() {
    return sharedPreferences.getInt(TimerPrefKey.vibrationCount.toString()) ??
        1;
  }

  void saveVibrationCount(int i) {
    sharedPreferences.setInt(TimerPrefKey.vibrationCount.toString(), i);
  }

  Duration getFocusDuration() {
    return Duration(
        seconds:
            sharedPreferences.getInt(TimerPrefKey.focusDuration.toString()) ??
                TimerDefault.focusDuration.inSeconds);
  }

  void saveFocusDuration(Duration d) async {
    sharedPreferences.setInt(
        TimerPrefKey.focusDuration.toString(), d.inSeconds);
  }

  Duration getShortBreakDuration() {
    return Duration(
        seconds: sharedPreferences
                .getInt(TimerPrefKey.shortBreakDuration.toString()) ??
            TimerDefault.shortBreakDuration.inSeconds);
  }

  void saveShortBreakDuration(Duration d) {
    sharedPreferences.setInt(
        TimerPrefKey.shortBreakDuration.toString(), d.inSeconds);
  }

  Duration getLongBreakDuration() {
    return Duration(
        seconds: sharedPreferences
                .getInt(TimerPrefKey.longBreakDuration.toString()) ??
            TimerDefault.longBreakDuration.inSeconds);
  }

  void saveLongBreakDuration(Duration d) {
    sharedPreferences.setInt(
        TimerPrefKey.longBreakDuration.toString(), d.inSeconds);
  }

  int getLongBreakInterval() {
    return sharedPreferences
            .getInt(TimerPrefKey.longBreakInterval.toString()) ??
        TimerDefault.longBreakInterval;
  }

  void saveLongBreakInterval(int i) {
    sharedPreferences.setInt(TimerPrefKey.longBreakInterval.toString(), i);
  }

  TimerItem getTimerItem() {
    final itemStr =
        sharedPreferences.getString(TimerPrefKey.timerItem.toString());
    if (itemStr == null) {
      return TimerDefault.resumeTimerItem;
    } else {
      return EnumToString.fromString(TimerItem.values, itemStr)!;
    }
  }

  void saveTimerItem(TimerItem timerItem) {
    sharedPreferences.setString(TimerPrefKey.timerItem.toString(),
        EnumToString.convertToString(timerItem));
  }

  int getFocusCount() {
    return sharedPreferences.getInt(TimerPrefKey.focusCount.toString()) ??
        TimerDefault.resumeFocusCount;
  }

  void saveFocusCount(int count) {
    sharedPreferences.setInt(TimerPrefKey.focusCount.toString(), count);
  }

  int getShortBreakCount() {
    return sharedPreferences.getInt(TimerPrefKey.shortBreakCount.toString()) ??
        TimerDefault.resumeShortBreakCount;
  }

  void saveShortBreakCount(int count) {
    sharedPreferences.setInt(TimerPrefKey.shortBreakCount.toString(), count);
  }

  bool isTimerStopped() {
    return sharedPreferences.getBool(TimerPrefKey.isTimerStopped.toString()) ??
        true;
  }

  void setTimerStopped() {
    sharedPreferences.setBool(TimerPrefKey.isTimerStopped.toString(), true);
  }

  void unsetTimerStopped() {
    sharedPreferences.setBool(TimerPrefKey.isTimerStopped.toString(), false);
  }

  bool isTimerResumed() {
    return sharedPreferences.getBool(TimerPrefKey.isTimerResumed.toString()) ??
        true;
  }

  void setTimerResumed() {
    sharedPreferences.setBool(TimerPrefKey.isTimerResumed.toString(), true);
  }

  void unsetTimerResumed() {
    sharedPreferences.setBool(TimerPrefKey.isTimerResumed.toString(), false);
  }

  TZDateTime getCompleteTZSDateTime() {
    final tzDateTimeStr =
        sharedPreferences.getString(TimerPrefKey.completeTZDateTime.toString());
    if (tzDateTimeStr == null) {
      return tz.TZDateTime.now(tz.UTC).add(const Duration(minutes: 25));
    } else {
      final dateTime = DateTime.parse(tzDateTimeStr).toUtc();
      return tz.TZDateTime.from(dateTime, tz.UTC);
    }
  }

  void saveCompleteTZDateTime(TZDateTime tzDateTime) {
    sharedPreferences.setString(TimerPrefKey.completeTZDateTime.toString(),
        tzDateTime.toIso8601String());
  }
}
