import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:settings_ui/settings_ui.dart';

class ReviewSetting extends ConsumerWidget {
  const ReviewSetting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenSize = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;
    final settingFontSize = (orientation == Orientation.portrait)
        ? screenSize.height * 0.018
        : screenSize.width * 0.018;

    return SettingsTile(
      title: Text(
        AppLocalizations.of(context)!.reviewApp,
        style: TextStyle(fontSize: settingFontSize),
      ),
      onPressed: (context) async {
        final InAppReview inAppReview = InAppReview.instance;
        if (await inAppReview.isAvailable()) {
          inAppReview.requestReview();
        }
      },
    );
  }
}
