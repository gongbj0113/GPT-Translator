import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../model/settings.dart';

class SettingsRepository {
  Settings? _settings;

  Future<Settings> loadSettings() async {
    if (_settings != null) {
      return _settings!;
    }

    const FlutterSecureStorage storage = FlutterSecureStorage();

    final String? data = await storage.read(key: 'settings');

    if (data == null) {
      // Save initial settings
      final Settings initialSettings = await Settings.initial();
      await storage.write(
          key: 'settings', value: jsonEncode(initialSettings.toJson()));
      _settings = initialSettings;

      return initialSettings;
    }

    final Map<String, dynamic> json = jsonDecode(data);
    _settings = Settings.fromJson(json);
    return Settings.fromJson(json);
  }

  Settings get settings => _settings!;

  Future<void> saveSettings(Settings settings) async {
    _settings = settings;

    const FlutterSecureStorage storage = FlutterSecureStorage();
    await storage.write(key: 'settings', value: jsonEncode(settings.toJson()));
  }
}
