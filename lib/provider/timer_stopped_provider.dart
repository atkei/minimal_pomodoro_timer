import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minimal_pomodoro_timer/provider/shared_utility_provider.dart';

final timerStoppedProvider = StateNotifierProvider<TimerStoppedNotifier, bool>(
  (ref) => TimerStoppedNotifier(ref: ref),
);

class TimerStoppedNotifier extends StateNotifier<bool> {
  TimerStoppedNotifier({required this.ref}) : super(true) {
    state = ref.watch(sharedUtilityProvider).isTimerStopped();
  }

  final Ref ref;

  void unsetTimerStopped() {
    ref.watch(sharedUtilityProvider).unsetTimerStopped();
    state = ref.watch(sharedUtilityProvider).isTimerStopped();
  }

  void setTimerStopped() {
    ref.watch(sharedUtilityProvider).setTimerStopped();
    state = ref.watch(sharedUtilityProvider).isTimerStopped();
  }
}
