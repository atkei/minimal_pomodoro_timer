import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minimal_pomodoro_timer/provider/shared_utility_provider.dart';

import '../helper/enum.dart';

final timerItemProvider = StateNotifierProvider<TimerItemNotifier, TimerItem>(
  (ref) => TimerItemNotifier(ref: ref),
);

class TimerItemNotifier extends StateNotifier<TimerItem> {
  TimerItemNotifier({required this.ref}) : super(TimerItem.focus) {
    state = ref.watch(sharedUtilityProvider).getTimerItem();
  }

  final Ref ref;

  void setItem(TimerItem item) {
    ref.watch(sharedUtilityProvider).saveTimerItem(item);
    state = ref.watch(sharedUtilityProvider).getTimerItem();
  }
}
