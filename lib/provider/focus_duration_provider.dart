import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minimal_pomodoro_timer/helper/constant.dart';
import 'package:minimal_pomodoro_timer/provider/shared_utility_provider.dart';

final focusDurationProvider =
    StateNotifierProvider<FocusDurationNotifier, Duration>(
  (ref) => FocusDurationNotifier(ref: ref),
);

class FocusDurationNotifier extends StateNotifier<Duration> {
  FocusDurationNotifier({required this.ref})
      : super(TimerDefault.focusDuration) {
    state = ref.watch(sharedUtilityProvider).getFocusDuration();
  }

  Ref ref;

  void set(Duration duration) {
    ref.watch(sharedUtilityProvider).saveFocusDuration(duration);
    state = ref.watch(sharedUtilityProvider).getFocusDuration();
  }
}
