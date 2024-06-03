import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minimal_pomodoro_timer/helper/constant.dart';
import 'package:minimal_pomodoro_timer/provider/shared_utility_provider.dart';

final longBreakDurationProvider =
    StateNotifierProvider<LongBreakDurationNotifier, Duration>(
  (ref) => LongBreakDurationNotifier(ref: ref),
);

class LongBreakDurationNotifier extends StateNotifier<Duration> {
  LongBreakDurationNotifier({required this.ref})
      : super(TimerDefault.longBreakDuration) {
    state = ref.watch(sharedUtilityProvider).getLongBreakDuration();
  }

  Ref ref;

  void set(Duration duration) {
    ref.watch(sharedUtilityProvider).saveLongBreakDuration(duration);
    state = ref.watch(sharedUtilityProvider).getLongBreakDuration();
  }
}
