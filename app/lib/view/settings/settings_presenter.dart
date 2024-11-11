import 'package:app/entity/settings.dart';
import 'package:app/service/settings_database.dart';

class SettingsPresenter {
  static final SettingsDatabase _database = SettingsDatabase();

  void saveSettings(Settings settings) {
    _database.saveSettings(settings);
  }

  Future<List<Settings>> readSettings() async {
    return await _database.readSettings().then((settings) {
      return settings;
    });
  }
}
