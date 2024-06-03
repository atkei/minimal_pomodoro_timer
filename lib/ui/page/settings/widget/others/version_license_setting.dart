import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:settings_ui/settings_ui.dart';

class VersionLicenseSetting extends StatelessWidget {
  const VersionLicenseSetting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;
    final settingFontSize = (orientation == Orientation.portrait)
        ? screenSize.height * 0.018
        : screenSize.width * 0.018;

    return SettingsTile(
      title: Text(
        AppLocalizations.of(context)!.versionLicense,
        style: TextStyle(fontSize: settingFontSize),
      ),
      onPressed: (context) async {
        final info = await PackageInfo.fromPlatform();

        showLicensePage(
          applicationVersion: info.version,
          context: context,
        );
      },
    );
  }
}
