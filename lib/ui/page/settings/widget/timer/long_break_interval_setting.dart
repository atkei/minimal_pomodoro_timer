import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minimal_pomodoro_timer/provider/long_break_interval_provider.dart';
import 'package:minimal_pomodoro_timer/provider/timer_provider_helper.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:settings_ui/settings_ui.dart';

class LongBreakIntervalSetting extends ConsumerWidget {
  const LongBreakIntervalSetting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenSize = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;
    final interval = ref.watch(longBreakIntervalProvider);
    var pickedInterval = interval;
    final settingFontSize = (orientation == Orientation.portrait)
        ? screenSize.height * 0.018
        : screenSize.width * 0.018;

    return SettingsTile(
      title: Text(
        AppLocalizations.of(context)!.longBreakInterval,
        style: TextStyle(fontSize: settingFontSize),
      ),
      trailing: Text(
          AppLocalizations.of(context)!.longBreakIntervalSetting(interval)),
      onPressed: (context) => {
        showCupertinoDialog<int>(
          barrierDismissible: true,
          context: context,
          builder: (context) {
            return StatefulBuilder(builder: (context, setState) {
              return AlertDialog(
                content: NumberPicker(
                  minValue: 2,
                  maxValue: 99,
                  value: pickedInterval,
                  onChanged: (value) {
                    setState(() {
                      pickedInterval = value;
                    });
                  },
                ),
                actionsAlignment: MainAxisAlignment.spaceEvenly,
                actions: [
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text("Cancel"),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      ref
                          .read(longBreakIntervalProvider.notifier)
                          .set(pickedInterval);
                      Navigator.pop(context);
                      resetTimer(ref);
                      // ref.refresh(longBreakIntervalSettingProvider);
                    },
                    child: const Text("OK"),
                  ),
                ],
              );
            });
          },
        ),
      },
    );
  }
}
