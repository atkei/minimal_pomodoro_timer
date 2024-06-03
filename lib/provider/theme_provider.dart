import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minimal_pomodoro_timer/provider/shared_utility_provider.dart';

final isDarkProvider = StateNotifierProvider<DarkThemeNotifier, bool>((ref) {
  return DarkThemeNotifier(ref: ref);
});

class DarkThemeNotifier extends StateNotifier<bool> {
  DarkThemeNotifier({required this.ref}) : super(false) {
    state = ref.watch(sharedUtilityProvider).isDarkModeEnabled();
  }

  Ref ref;

  void toggle() {
    ref.watch(sharedUtilityProvider).setDarkModeEnabled(
        !ref.watch(sharedUtilityProvider).isDarkModeEnabled());
    state = ref.watch(sharedUtilityProvider).isDarkModeEnabled();
  }
}
