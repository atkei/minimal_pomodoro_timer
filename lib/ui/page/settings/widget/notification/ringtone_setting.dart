import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minimal_pomodoro_timer/provider/ringtone_provider.dart';
import 'package:settings_ui/settings_ui.dart';

class RingtoneSetting extends ConsumerWidget {
  const RingtoneSetting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenSize = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;
    final settingFontSize = (orientation == Orientation.portrait)
        ? screenSize.height * 0.018
        : screenSize.width * 0.018;

    final isRingTone = ref.watch(isRingToneProvider);

    return SettingsTile.switchTile(
      title: Text(
        AppLocalizations.of(context)!.ringtone,
        style: TextStyle(fontSize: settingFontSize),
      ),
      initialValue: isRingTone,
      onToggle: (_) {
        ref.read(isRingToneProvider.notifier).toggle();
      },
    );
  }
}
