import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minimal_pomodoro_timer/provider/shared_utility_provider.dart';

final focusCountProvider = StateNotifierProvider<FocusCountNotifier, int>(
  (ref) => FocusCountNotifier(ref: ref),
);

class FocusCountNotifier extends StateNotifier<int> {
  FocusCountNotifier({required this.ref}) : super(1) {
    state = ref.watch(sharedUtilityProvider).getFocusCount();
  }

  Ref ref;

  void increment() {
    ref.watch(sharedUtilityProvider).saveFocusCount(state + 1);
    state = ref.watch(sharedUtilityProvider).getFocusCount();
  }

  void decrement() {
    ref.watch(sharedUtilityProvider).saveFocusCount(state - 1);
    state = ref.watch(sharedUtilityProvider).getFocusCount();
  }

  void set(int count) {
    ref.watch(sharedUtilityProvider).saveFocusCount(count);
    state = ref.watch(sharedUtilityProvider).getFocusCount();
  }

  void reset() {
    ref.watch(sharedUtilityProvider).saveFocusCount(1);
    state = ref.watch(sharedUtilityProvider).getFocusCount();
  }
}
