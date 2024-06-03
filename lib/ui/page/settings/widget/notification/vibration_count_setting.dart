import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minimal_pomodoro_timer/provider/vibration_count_provider.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:settings_ui/settings_ui.dart';

class VibrationCountSetting extends ConsumerWidget {
  const VibrationCountSetting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenSize = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;
    final settingFontSize = (orientation == Orientation.portrait)
        ? screenSize.height * 0.018
        : screenSize.width * 0.018;

    final vibrationCount = ref.watch(vibrationCountProvider);
    var pickedVibrationCount = vibrationCount;

    return SettingsTile(
      title: Text(
        AppLocalizations.of(context)!.numVibrations,
        style: TextStyle(fontSize: settingFontSize),
      ),
      trailing: _toValueText(vibrationCount),
      onPressed: (context) => {
        showCupertinoDialog<int>(
          barrierDismissible: true,
          context: context,
          builder: (context) {
            return StatefulBuilder(builder: (context, setState) {
              return AlertDialog(
                content: NumberPicker(
                  minValue: -1,
                  maxValue: 99,
                  value: pickedVibrationCount,
                  onChanged: (value) {
                    setState(() {
                      pickedVibrationCount = value;
                    });
                  },
                ),
                actionsAlignment: MainAxisAlignment.spaceEvenly,
                actions: [
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(AppLocalizations.of(context)!.cancel),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      ref
                          .read(vibrationCountProvider.notifier)
                          .set(pickedVibrationCount);
                      Navigator.pop(context);
                    },
                    child: Text(AppLocalizations.of(context)!.ok),
                  ),
                ],
              );
            });
          },
        ),
      },
    );
  }

  Text _toValueText(int count) {
    if (count == -1) {
      return const Text("∞");
    } else {
      return Text("$count");
    }
  }
}
