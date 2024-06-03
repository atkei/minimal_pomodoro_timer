import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minimal_pomodoro_timer/helper/constant.dart';
import 'package:minimal_pomodoro_timer/provider/shared_utility_provider.dart';

final longBreakProgressColorProvider =
    StateNotifierProvider<LongBreakProgressColorNotifier, Color>(
  (ref) => LongBreakProgressColorNotifier(ref: ref),
);

class LongBreakProgressColorNotifier extends StateNotifier<Color> {
  LongBreakProgressColorNotifier({required this.ref})
      : super(TimerDefault.longBreakProgressColor) {
    state = ref.watch(sharedUtilityProvider).getLongBreakProgressColor();
  }

  Ref ref;

  void set(Color c) {
    ref.watch(sharedUtilityProvider).saveLongBreakProgressColor(c);
    state = ref.watch(sharedUtilityProvider).getLongBreakProgressColor();
  }
}
