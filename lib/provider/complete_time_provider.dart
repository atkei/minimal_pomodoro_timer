import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minimal_pomodoro_timer/provider/shared_utility_provider.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/timezone.dart';

final completeTimeProvider =
    StateNotifierProvider<CompleteTimeNotifier, TZDateTime>(
  (ref) => CompleteTimeNotifier(ref: ref),
);

class CompleteTimeNotifier extends StateNotifier<TZDateTime> {
  CompleteTimeNotifier({required this.ref}) : super(tz.TZDateTime.now(tz.UTC)) {
    state = ref.watch(sharedUtilityProvider).getCompleteTZSDateTime();
  }

  Ref ref;

  void set(TZDateTime scheduledTime) {
    ref.watch(sharedUtilityProvider).saveCompleteTZDateTime(scheduledTime);
    state = ref.watch(sharedUtilityProvider).getCompleteTZSDateTime();
  }
}
