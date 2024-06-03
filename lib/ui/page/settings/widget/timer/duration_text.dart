import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DurationText extends StatelessWidget {
  final Duration duration;

  const DurationText(this.duration, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final h = duration.inHours.toString();
    final hu = (duration.inHours == 1)
        ? AppLocalizations.of(context)!.hour
        : AppLocalizations.of(context)!.hours;
    final sm = duration.inMinutes - duration.inHours * 60;
    final m = (sm < 10) ? "0$sm" : sm.toString();
    final sn = duration.inSeconds - duration.inMinutes * 60;
    final s = (sn < 10) ? "0$sn" : sn.toString();

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(h),
        Text(hu),
        Text(m),
        Text(AppLocalizations.of(context)!.min),
        Text(s),
        Text(AppLocalizations.of(context)!.sec),
      ],
    );
  }
}
