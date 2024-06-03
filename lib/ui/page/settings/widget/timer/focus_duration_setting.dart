import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minimal_pomodoro_timer/provider/focus_duration_provider.dart';
import 'package:minimal_pomodoro_timer/provider/timer_provider_helper.dart';
import 'package:minimal_pomodoro_timer/ui/page/settings/widget/timer/duration_text.dart';
import 'package:settings_ui/settings_ui.dart';

class FocusDurationSetting extends ConsumerWidget {
  const FocusDurationSetting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenSize = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;
    final actionSheetHeight = (orientation == Orientation.portrait)
        ? screenSize.height * 0.3
        : screenSize.height * 0.4;
    final settingFontSize = (orientation == Orientation.portrait)
        ? screenSize.height * 0.018
        : screenSize.width * 0.018;

    final MaterialLocalizations localizations =
        MaterialLocalizations.of(context);
    final duration = ref.watch(focusDurationProvider);

    return SettingsTile(
      title: Text(AppLocalizations.of(context)!.focusDuration,
          style: TextStyle(fontSize: settingFontSize)),
      trailing: DurationText(duration),
      onPressed: (context) {
        var newDuration = duration;
        showCupertinoModalPopup<void>(
            context: context,
            builder: (BuildContext context) {
              return CupertinoActionSheet(
                message: SizedBox(
                    height: actionSheetHeight,
                    child: CupertinoTimerPicker(
                      initialTimerDuration: duration,
                      onTimerDurationChanged: (pickedDuration) {
                        newDuration = pickedDuration;
                        if (kDebugMode) {
                          print("Picked focus duration: $pickedDuration");
                        }
                      },
                    )),
                actions: [
                  CupertinoActionSheetAction(
                    child: Text(localizations.okButtonLabel),
                    onPressed: () {
                      ref.read(focusDurationProvider.notifier).set(newDuration);
                      Navigator.pop(context);
                      resetTimer(ref);
                      // ref.refresh(focusDurationProvider);
                    },
                  ),
                ],
                cancelButton: CupertinoActionSheetAction(
                  isDestructiveAction: true,
                  child: Text(localizations.cancelButtonLabel),
                  onPressed: () => Navigator.pop(context),
                ),
              );
            });
      },
    );
  }
}
