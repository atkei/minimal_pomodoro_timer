import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minimal_pomodoro_timer/provider/shared_utility_provider.dart';

final shortBreakCountProvider =
    StateNotifierProvider<ShortBreakCountNotifier, int>(
  (ref) => ShortBreakCountNotifier(ref: ref),
);

class ShortBreakCountNotifier extends StateNotifier<int> {
  ShortBreakCountNotifier({required this.ref}) : super(1) {
    state = ref.watch(sharedUtilityProvider).getShortBreakCount();
  }

  Ref ref;

  void increment() {
    ref.watch(sharedUtilityProvider).saveShortBreakCount(state + 1);
    state = ref.watch(sharedUtilityProvider).getShortBreakCount();
  }

  void decrement() {
    ref.watch(sharedUtilityProvider).saveShortBreakCount(state - 1);
    state = ref.watch(sharedUtilityProvider).getShortBreakCount();
  }

  void set(int count) {
    ref.watch(sharedUtilityProvider).saveShortBreakCount(count);
    state = ref.watch(sharedUtilityProvider).getShortBreakCount();
  }

  void reset() {
    ref.watch(sharedUtilityProvider).saveShortBreakCount(1);
    state = ref.watch(sharedUtilityProvider).getShortBreakCount();
  }
}
