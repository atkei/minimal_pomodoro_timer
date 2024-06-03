import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minimal_pomodoro_timer/provider/shared_utility_provider.dart';

final vibrationCountProvider =
    StateNotifierProvider<VibrationCountNotifier, int>(
  (ref) => VibrationCountNotifier(ref: ref),
);

class VibrationCountNotifier extends StateNotifier<int> {
  VibrationCountNotifier({required this.ref}) : super(1) {
    state = ref.watch(sharedUtilityProvider).getVibrationCount();
  }

  Ref ref;

  void set(int c) {
    ref.watch(sharedUtilityProvider).saveVibrationCount(c);
    state = ref.watch(sharedUtilityProvider).getVibrationCount();
  }
}
