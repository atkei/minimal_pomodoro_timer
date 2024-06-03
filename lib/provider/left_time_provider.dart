import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minimal_pomodoro_timer/helper/ringtone_service.dart';
import 'package:minimal_pomodoro_timer/provider/complete_time_provider.dart';
import 'package:minimal_pomodoro_timer/provider/ringtone_provider.dart';
import 'package:minimal_pomodoro_timer/provider/shared_utility_provider.dart';
import 'package:minimal_pomodoro_timer/provider/vibration_count_provider.dart';
import 'package:timezone/timezone.dart' as tz;

import '../helper/vibration_service.dart';

final leftTimeProvider = StateNotifierProvider<LeftTimeNotifier, Duration>(
  (ref) => LeftTimeNotifier(ref: ref),
);

class LeftTimeNotifier extends StateNotifier<Duration> {
  LeftTimeNotifier({required this.ref}) : super(const Duration(seconds: 0)) {
    resume();
  }

  Ref ref;

  final Ticker _ticker = Ticker();

  StreamSubscription<int>? _tickerSubscription;

  void start(Duration duration) {
    if (kDebugMode) {
      print("Start timer");
    }
    ref
        .read(completeTimeProvider.notifier)
        .set(tz.TZDateTime.now(tz.UTC).add(duration));
    _startTimer(duration);
  }

  void resume() {
    if (kDebugMode) {
      print("Resume timer");
    }
    final currentDateTime = tz.TZDateTime.now(tz.UTC);
    final completeDateTime =
        ref.watch(sharedUtilityProvider).getCompleteTZSDateTime();
    final isTimerStopped = ref.watch(sharedUtilityProvider).isTimerStopped();
    final remainDuration = completeDateTime.difference(currentDateTime);
    if (remainDuration.isNegative) {
      // Set left time to 0 since the timer has already completed before resume.
      state = const Duration(seconds: 0);
    } else if (!isTimerStopped) {
      // If the timer has not been stopped, start the timer from the remaining time.
      state = remainDuration;
      _startTimer(state);
    }
  }

  void startFromState() {
    _startTimer(state);
  }

  void reset(Duration duration) {
    _tickerSubscription?.cancel();
    state = duration;
  }

  void cancel() {
    _tickerSubscription?.cancel();
  }

  void set(Duration duration) {
    state = duration;
  }

  void _startTimer(Duration duration) {
    _tickerSubscription?.cancel();

    _tickerSubscription =
        _ticker.tick(ticks: duration.inSeconds).listen((seconds) {
      state = Duration(seconds: seconds);
      if (kDebugMode) {
        print("Reminder seconds: $state");
      }
    });

    _tickerSubscription?.onDone(() {
      state = const Duration(seconds: 0);
      VibrationService().vibrate(ref.read(vibrationCountProvider));
      RingtoneService().play(ref.read(isRingToneProvider));
      if (kDebugMode) {
        print("Done");
      }
    });

    state = duration;
  }
}

class Ticker {
  Stream<int> tick({required int ticks}) {
    return Stream.periodic(
      const Duration(seconds: 1),
      (x) => ticks - x - 1,
    ).take(ticks);
  }
}
