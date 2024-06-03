import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minimal_pomodoro_timer/provider/shared_utility_provider.dart';

import '../helper/ringtone_service.dart';

final isRingToneProvider = StateNotifierProvider<RingToneNotifier, bool>((ref) {
  return RingToneNotifier(ref: ref);
});

class RingToneNotifier extends StateNotifier<bool> {
  RingToneNotifier({required this.ref}) : super(false) {
    state = ref.watch(sharedUtilityProvider).isWakelockEnabled();
  }

  Ref ref;

  void toggle() {
    ref.watch(sharedUtilityProvider).setWakelockEnabled(
        !ref.watch(sharedUtilityProvider).isWakelockEnabled());
    state = ref.watch(sharedUtilityProvider).isWakelockEnabled();

    // Play sound when turned on.
    RingtoneService().play(state);
  }
}
