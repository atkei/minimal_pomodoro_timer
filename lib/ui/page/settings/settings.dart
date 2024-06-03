import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minimal_pomodoro_timer/ui/page/settings/widget/notification/app_notification_setting.dart';
import 'package:minimal_pomodoro_timer/ui/page/settings/widget/notification/ringtone_setting.dart';
import 'package:minimal_pomodoro_timer/ui/page/settings/widget/notification/vibration_count_setting.dart';
import 'package:minimal_pomodoro_timer/ui/page/settings/widget/others/review_setting.dart';
import 'package:minimal_pomodoro_timer/ui/page/settings/widget/others/version_license_setting.dart';
import 'package:minimal_pomodoro_timer/ui/page/settings/widget/timer/focus_duration_setting.dart';
import 'package:minimal_pomodoro_timer/ui/page/settings/widget/timer/long_break_duration_setting.dart';
import 'package:minimal_pomodoro_timer/ui/page/settings/widget/timer/long_break_interval_setting.dart';
import 'package:minimal_pomodoro_timer/ui/page/settings/widget/timer/short_break_duration_setting.dart';
import 'package:minimal_pomodoro_timer/ui/page/settings/widget/timer/wakelock_setting.dart';
import 'package:minimal_pomodoro_timer/ui/page/settings/widget/view/focus_progress_color_setting_tile.dart';
import 'package:minimal_pomodoro_timer/ui/page/settings/widget/view/hide_left_time_setting.dart';
import 'package:minimal_pomodoro_timer/ui/page/settings/widget/view/hide_timer_count_setting.dart';
import 'package:minimal_pomodoro_timer/ui/page/settings/widget/view/hide_timer_item_setting.dart';
import 'package:minimal_pomodoro_timer/ui/page/settings/widget/view/long_break_progress_color_setting_tile.dart';
import 'package:minimal_pomodoro_timer/ui/page/settings/widget/view/short_break_progress_color_setting_tile.dart';
import 'package:minimal_pomodoro_timer/ui/page/settings/widget/view/theme_setting.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(''),
      ),
      body: SettingsList(
        lightTheme: SettingsThemeData(
            settingsSectionBackground:
                Theme.of(context).scaffoldBackgroundColor,
            settingsListBackground: Theme.of(context).scaffoldBackgroundColor),
        darkTheme: SettingsThemeData(
            settingsSectionBackground:
                Theme.of(context).scaffoldBackgroundColor,
            settingsListBackground: Theme.of(context).scaffoldBackgroundColor),
        sections: [
          SettingsSection(
            title: Text(AppLocalizations.of(context)!.settingTimer),
            tiles: const [
              CustomSettingsTile(child: FocusDurationSetting()),
              CustomSettingsTile(child: ShortBreakDurationSetting()),
              CustomSettingsTile(child: LongBreakDurationSetting()),
              CustomSettingsTile(child: LongBreakIntervalSetting()),
            ],
          ),
          SettingsSection(
            title: Text(AppLocalizations.of(context)!
                .settingTimerCompletionNotification),
            tiles: const [
              CustomSettingsTile(child: WakelockSettingTile()),
              CustomSettingsTile(child: RingtoneSetting()),
              CustomSettingsTile(child: VibrationCountSetting()),
              CustomSettingsTile(child: AppNotificationSetting()),
            ],
          ),
          SettingsSection(
            title: Text(AppLocalizations.of(context)!.settingView),
            tiles: const [
              CustomSettingsTile(child: HideTimerItemSettingTile()),
              CustomSettingsTile(child: HideTimerCountSettingTile()),
              CustomSettingsTile(child: HideLeftTimeSettingTile()),
              CustomSettingsTile(child: ThemeSetting()),
              CustomSettingsTile(child: FocusProgressColorSettingTile()),
              CustomSettingsTile(child: ShortBreakProgressColorSettingTile()),
              CustomSettingsTile(child: LongBreakProgressColorSettingTile()),
            ],
          ),
          SettingsSection(
            title: Text(AppLocalizations.of(context)!.settingOther),
            tiles: const [
              CustomSettingsTile(child: ReviewSetting()),
              CustomSettingsTile(child: VersionLicenseSetting()),
            ],
          ),
        ],
      ),
    );
  }
}
