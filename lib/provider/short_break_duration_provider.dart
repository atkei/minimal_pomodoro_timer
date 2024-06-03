import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minimal_pomodoro_timer/helper/constant.dart';
import 'package:minimal_pomodoro_timer/provider/shared_utility_provider.dart';

final shortBreakDurationProvider =
    StateNotifierProvider<ShortBreakDurationNotifier, Duration>(
  (ref) => ShortBreakDurationNotifier(ref: ref),
);

class ShortBreakDurationNotifier extends StateNotifier<Duration> {
  ShortBreakDurationNotifier({required this.ref})
      : super(TimerDefault.shortBreakDuration) {
    state = ref.watch(sharedUtilityProvider).getShortBreakDuration();
  }

  Ref ref;

  void set(Duration duration) {
    ref.watch(sharedUtilityProvider).saveShortBreakDuration(duration);
    state = ref.watch(sharedUtilityProvider).getShortBreakDuration();
  }
}
