import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:settings_ui/settings_ui.dart';

import '../../../../../provider/long_break_progress_color_provider.dart';

class LongBreakProgressColorSettingTile extends ConsumerWidget {
  const LongBreakProgressColorSettingTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenSize = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;
    final settingFontSize = (orientation == Orientation.portrait)
        ? screenSize.height * 0.018
        : screenSize.width * 0.018;

    final color = ref.watch(longBreakProgressColorProvider);

    return SettingsTile(
      title: Text(
        AppLocalizations.of(context)!.colorLongBreakIndicator,
        style: TextStyle(fontSize: settingFontSize),
      ),
      trailing: Container(
        width: 15,
        height: 15,
        color: color,
      ),
      onPressed: (context) {
        var newColor = color;
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: SingleChildScrollView(
                child: ColorPicker(
                  pickerColor: color,
                  onColorChanged: (color) => newColor = color,
                ),
              ),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      ref
                          .read(longBreakProgressColorProvider.notifier)
                          .set(newColor);
                      Navigator.of(context).pop();
                    },
                    child: Text(AppLocalizations.of(context)!.ok)),
              ],
            );
          },
        );
      },
    );
  }
}
