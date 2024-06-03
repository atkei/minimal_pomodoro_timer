import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minimal_pomodoro_timer/provider/shared_utility_provider.dart';

final hideMenuProvider = StateNotifierProvider<HideMenuNotifier, bool>((ref) {
  return HideMenuNotifier(ref: ref);
});

class HideMenuNotifier extends StateNotifier<bool> {
  HideMenuNotifier({required this.ref}) : super(false) {
    state = ref.watch(sharedUtilityProvider).isTimeLeftHiddenEnabled();
  }

  Ref ref;

  void toggle() {
    ref.watch(sharedUtilityProvider).setTimeLeftHiddenEnabled(
        !ref.watch(sharedUtilityProvider).isTimeLeftHiddenEnabled());
    state = ref.watch(sharedUtilityProvider).isTimeLeftHiddenEnabled();
  }
}
