import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minimal_pomodoro_timer/provider/shared_utility_provider.dart';

final hideTimerCountProvider =
    StateNotifierProvider<HideTimerCountNotifier, bool>((ref) {
  return HideTimerCountNotifier(ref: ref);
});

class HideTimerCountNotifier extends StateNotifier<bool> {
  HideTimerCountNotifier({required this.ref}) : super(false) {
    state = ref.watch(sharedUtilityProvider).isTimerCountHiddenEnabled();
  }

  Ref ref;

  void toggle() {
    ref.watch(sharedUtilityProvider).setTimerCountHiddenEnabled(
        !ref.watch(sharedUtilityProvider).isTimerCountHiddenEnabled());
    state = ref.watch(sharedUtilityProvider).isTimerCountHiddenEnabled();
  }
}
