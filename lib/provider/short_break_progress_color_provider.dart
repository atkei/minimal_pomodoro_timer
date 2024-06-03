import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minimal_pomodoro_timer/helper/constant.dart';
import 'package:minimal_pomodoro_timer/provider/shared_utility_provider.dart';

final shortBreakProgressColorProvider =
    StateNotifierProvider<ShortBreakProgressColorNotifier, Color>(
  (ref) => ShortBreakProgressColorNotifier(ref: ref),
);

class ShortBreakProgressColorNotifier extends StateNotifier<Color> {
  ShortBreakProgressColorNotifier({required this.ref})
      : super(TimerDefault.shortBreakProgressColor) {
    state = ref.watch(sharedUtilityProvider).getShortBreakProgressColor();
  }

  Ref ref;

  void set(Color c) {
    ref.watch(sharedUtilityProvider).saveShortBreakProgressColor(c);
    state = ref.watch(sharedUtilityProvider).getShortBreakProgressColor();
  }
}
