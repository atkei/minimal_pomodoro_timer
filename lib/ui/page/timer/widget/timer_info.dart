import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minimal_pomodoro_timer/ui/page/timer/widget/timer_info/timer_count_text.dart';
import 'package:minimal_pomodoro_timer/ui/page/timer/widget/timer_info/timer_item_text.dart';
import 'package:minimal_pomodoro_timer/ui/page/timer/widget/timer_popup_menu.dart';

class TimerInfo extends ConsumerWidget {
  const TimerInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenSize = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;
    final width = (orientation == Orientation.portrait)
        ? screenSize.width * 0.9
        : screenSize.width * 0.3;
    final height = (orientation == Orientation.portrait)
        ? screenSize.height * 0.3
        : screenSize.height * 0.9;

    return SizedBox(
      width: width,
      height: height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: width,
            height: height * 0.2,
            child: const Align(
                alignment: Alignment.centerLeft, child: TimerPopupMenu()),
          ),
          SizedBox(
            width: width,
            height: height * 0.3,
            child: const Align(
                alignment: Alignment.bottomCenter, child: TimerItemText()),
          ),
          SizedBox(
            width: width,
            height: height * 0.3,
            child: const Align(
                alignment: Alignment.topCenter, child: TimerCountText()),
          ),
          SizedBox(
            width: width,
            height: height * 0.2,
          ),
        ],
      ),
    );
  }
}
