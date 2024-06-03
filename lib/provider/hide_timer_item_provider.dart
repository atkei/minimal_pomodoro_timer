import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minimal_pomodoro_timer/provider/shared_utility_provider.dart';

final hideTimerItemProvider =
    StateNotifierProvider<HideTimerItemNotifier, bool>((ref) {
  return HideTimerItemNotifier(ref: ref);
});

class HideTimerItemNotifier extends StateNotifier<bool> {
  HideTimerItemNotifier({required this.ref}) : super(false) {
    state = ref.watch(sharedUtilityProvider).isTimerItemHiddenEnabled();
  }

  Ref ref;

  void toggle() {
    ref.watch(sharedUtilityProvider).setTimerItemHiddenEnabled(
        !ref.watch(sharedUtilityProvider).isTimerItemHiddenEnabled());
    state = ref.watch(sharedUtilityProvider).isTimerItemHiddenEnabled();
  }
}
