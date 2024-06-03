import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../settings/settings.dart';

class SettingButton extends ConsumerWidget {
  const SettingButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      icon: const Icon(Icons.settings),
      onPressed: () => {
        Navigator.of(context)
            .push(MaterialPageRoute(
              builder: (context) => const SettingsPage(),
            ))
            .then((value) {})
      },
    );
  }
}
