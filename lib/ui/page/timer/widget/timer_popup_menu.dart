import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minimal_pomodoro_timer/provider/hide_menu_provider.dart';

import '../../../../provider/timer_provider_helper.dart';
import '../../settings/settings.dart';

enum MenuItem {
  nextTimer,
  previousTimer,
  firstSession,
  settings,
}

class TimerPopupMenu extends ConsumerWidget {
  const TimerPopupMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hideMenu = ref.watch(hideMenuProvider);
    final color =
        (hideMenu) ? Theme.of(context).scaffoldBackgroundColor : Colors.grey;
    return PopupMenuButton<MenuItem>(
      icon: Icon(
        Icons.dehaze_rounded,
        color: color,
      ),
      onSelected: (MenuItem i) {
        switch (i) {
          case MenuItem.nextTimer:
            nextTimer(ref);
            break;
          case MenuItem.previousTimer:
            prevTimer(ref);
            break;
          case MenuItem.firstSession:
            resetTimer(ref);
            break;
          case MenuItem.settings:
            Navigator.of(context)
                .push(MaterialPageRoute(
                  builder: (context) => const SettingsPage(),
                ))
                .then((value) {});
            break;
        }
      },
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem(
            value: MenuItem.nextTimer,
            child: Row(
              children: [
                const Icon(Icons.skip_next),
                Text("   ${AppLocalizations.of(context)!.nextTimer}"),
              ],
            ),
          ),
          PopupMenuItem(
            value: MenuItem.previousTimer,
            child: Row(
              children: [
                const Icon(Icons.skip_previous),
                Text("   ${AppLocalizations.of(context)!.previousTimer}"),
              ],
            ),
          ),
          PopupMenuItem(
            value: MenuItem.firstSession,
            child: Row(
              children: [
                const Icon(Icons.refresh),
                Text("   ${AppLocalizations.of(context)!.resetSession}"),
              ],
            ),
          ),
          PopupMenuItem(
            value: MenuItem.settings,
            child: Row(
              children: [
                const Icon(Icons.settings),
                Text("   ${AppLocalizations.of(context)!.settings}"),
              ],
            ),
          ),
        ];
      },
    );
  }
}
