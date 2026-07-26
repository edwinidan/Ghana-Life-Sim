import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract final class SettingsService {
  static const _hapticsKey = 'settings_haptics';
  static const _reducedMotionKey = 'settings_reduced_motion';

  static final hapticsEnabled = ValueNotifier<bool>(true);
  static final reducedMotion = ValueNotifier<bool>(false);

  static Future<void> init() async {
    final preferences = await SharedPreferences.getInstance();
    hapticsEnabled.value = preferences.getBool(_hapticsKey) ?? true;
    reducedMotion.value = preferences.getBool(_reducedMotionKey) ?? false;
  }

  static Future<void> setHapticsEnabled(bool value) async {
    hapticsEnabled.value = value;
    final preferences = await SharedPreferences.getInstance();
    await preferences.setBool(_hapticsKey, value);
  }

  static Future<void> setReducedMotion(bool value) async {
    reducedMotion.value = value;
    final preferences = await SharedPreferences.getInstance();
    await preferences.setBool(_reducedMotionKey, value);
  }
}
