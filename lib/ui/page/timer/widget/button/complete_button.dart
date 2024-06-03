import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../provider/timer_provider_helper.dart';

class CompleteButton extends ConsumerWidget {
  const CompleteButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      icon: const Icon(Icons.stop),
      onPressed: () {
        nextTimer(ref);
      },
    );
  }
}
