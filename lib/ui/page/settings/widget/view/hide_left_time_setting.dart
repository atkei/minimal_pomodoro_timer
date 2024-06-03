import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minimal_pomodoro_timer/provider/hide_left_time_provider.dart';
import 'package:settings_ui/settings_ui.dart';

class HideLeftTimeSettingTile extends ConsumerWidget {
  const HideLeftTimeSettingTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenSize = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;
    final settingFontSize = (orientation == Orientation.portrait)
        ? screenSize.height * 0.018
        : screenSize.width * 0.018;

    final hideLeftTime = ref.watch(hideLeftTimeProvider);

    return SettingsTile.switchTile(
      title: Text(
        AppLocalizations.of(context)!.hideRemainingTime,
        style: TextStyle(fontSize: settingFontSize),
      ),
      initialValue: !hideLeftTime,
      onToggle: (_) {
        ref.read(hideLeftTimeProvider.notifier).toggle();
      },
    );
  }
}
