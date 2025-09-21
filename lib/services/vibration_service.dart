import 'package:vibration/vibration.dart';

class VibrationService {
  static Future<void> chadVibration(int count) async {
    if (await Vibration.hasVibrator() == true) {
      for (int i = 0; i < count; i++) {
        await Vibration.vibrate(duration: 100);
        if (i < count - 1) {
          await Future.delayed(const Duration(milliseconds: 200));
        }
      }
    }
  }

  static Future<void> startVibration() async {
    await chadVibration(2);
  }

  static Future<void> stopVibration() async {
    await chadVibration(1);
  }

  static Future<void> levelUpVibration() async {
    await chadVibration(1);
  }
}
