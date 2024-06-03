import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minimal_pomodoro_timer/helper/constant.dart';
import 'package:minimal_pomodoro_timer/provider/shared_utility_provider.dart';

final focusProgressColorProvider =
    StateNotifierProvider<FocusProgressColorNotifier, Color>(
  (ref) => FocusProgressColorNotifier(ref: ref),
);

class FocusProgressColorNotifier extends StateNotifier<Color> {
  FocusProgressColorNotifier({required this.ref})
      : super(TimerDefault.focusProgressColor) {
    state = ref.watch(sharedUtilityProvider).getFocusProgressColor();
  }

  Ref ref;

  void set(Color c) {
    ref.watch(sharedUtilityProvider).saveFocusProgressColor(c);
    state = ref.watch(sharedUtilityProvider).getFocusProgressColor();
  }
}
