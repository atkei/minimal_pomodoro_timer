import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';

class RingtoneService {
  static final RingtoneService _instance = RingtoneService._internal();

  factory RingtoneService() {
    return _instance;
  }

  Future<void> play(bool enabled) async {
    if (enabled) {
      FlutterRingtonePlayer().playNotification();
    }
  }

  RingtoneService._internal();
}
