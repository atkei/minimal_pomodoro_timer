import 'package:vibration/vibration.dart';

class VibrationService {
  late bool isVibrating;

  static final VibrationService _instance = VibrationService._internal();

  factory VibrationService() {
    return _instance;
  }

  Future<void> vibrate(int maxCount) async {
    if (maxCount == 0) {
      return;
    }

    if (await Vibration.hasCustomVibrationsSupport() ?? false) {
      isVibrating = true;
      int count = 0;
      if (maxCount > -1) {
        while (isVibrating && count < maxCount) {
          await _doVibrate();
          count++;
        }
      } else {
        while (isVibrating) {
          await _doVibrate();
        }
      }
    }
  }

  Future<void> _doVibrate() async {
    await Vibration.vibrate();
    await Future.delayed(const Duration(milliseconds: 1000));
  }

  void stopVibrate() {
    isVibrating = false;
    Vibration.cancel();
  }

  VibrationService._internal() {
    isVibrating = false;
  }
}
