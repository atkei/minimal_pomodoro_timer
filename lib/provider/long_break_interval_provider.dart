import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minimal_pomodoro_timer/helper/constant.dart';
import 'package:minimal_pomodoro_timer/provider/shared_utility_provider.dart';

final longBreakIntervalProvider =
    StateNotifierProvider<LongBreakIntervalNotifier, int>(
  (ref) => LongBreakIntervalNotifier(ref: ref),
);

class LongBreakIntervalNotifier extends StateNotifier<int> {
  LongBreakIntervalNotifier({required this.ref})
      : super(TimerDefault.longBreakInterval) {
    state = ref.watch(sharedUtilityProvider).getLongBreakInterval();
  }

  Ref ref;

  void set(int i) {
    ref.watch(sharedUtilityProvider).saveLongBreakInterval(i);
    state = ref.watch(sharedUtilityProvider).getLongBreakInterval();
  }
}
