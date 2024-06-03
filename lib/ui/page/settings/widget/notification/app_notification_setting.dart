import 'package:app_settings/app_settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:settings_ui/settings_ui.dart';

class AppNotificationSetting extends StatelessWidget {
  const AppNotificationSetting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;
    final settingFontSize = (orientation == Orientation.portrait)
        ? screenSize.height * 0.018
        : screenSize.width * 0.018;

    return SettingsTile(
      title: Text(
        AppLocalizations.of(context)!.appNotification,
        style: TextStyle(fontSize: settingFontSize),
      ),
      onPressed: (context) async {
        AppSettings.openAppSettings(type: AppSettingsType.notification);
      },
    );
  }
}
