import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minimal_pomodoro_timer/provider/hide_timer_item_provider.dart';

import '../../../../../helper/enum.dart';
import '../../../../../provider/app_lifecycle_state_provider.dart';
import '../../../../../provider/timer_item_provider.dart';

class TimerItemText extends ConsumerWidget {
  const TimerItemText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timerItem = ref.watch(timerItemProvider);

    ref.listen<AppLifecycleState>(appLifecycleProvider, (previous, next) {
      switch (next) {
        case AppLifecycleState.detached:
        case AppLifecycleState.paused:
        case AppLifecycleState.inactive:
          ref.read(timerItemProvider.notifier).setItem(timerItem);
          break;
        case AppLifecycleState.resumed:
          break;
      }
    });

    final hideTimerItem = ref.watch(hideTimerItemProvider);

    var itemString = "";
    if (!hideTimerItem) {
      switch (timerItem) {
        case TimerItem.focus:
          itemString = AppLocalizations.of(context)!.focus;
          break;
        case TimerItem.shortBreak:
          itemString = AppLocalizations.of(context)!.shortBreak;
          break;
        case TimerItem.longBreak:
          itemString = AppLocalizations.of(context)!.longBreak;
          break;
      }
    }

    return LayoutBuilder(builder: (context, constraints) {
      final orientation = MediaQuery.of(context).orientation;
      final fontSize = (orientation == Orientation.portrait)
          ? constraints.maxHeight * 0.4
          : constraints.maxWidth * 0.12;
      if (kDebugMode) {
        print("Timer item font size: $fontSize");
      }
      return Text(
        itemString,
        style: TextStyle(fontSize: fontSize),
      );
    });
  }
}
